## ---------------------------------------- ##
          # Update Spell Information
## ---------------------------------------- ##
# Author(s): Nick Lyon

# PURPOSE:
## Strip spell information from markdown files in a GitHub repository
## My forked repo here: https://github.com/njlyon0/dnd_grimoire

## ---------------------------------------- ##
            # Housekeeping ----
## ---------------------------------------- ##

# Load libraries
librarian::shelf(tidyverse, supportR, dndR)

# Clear environment
rm(list = ls())

# Define repo name
spell_repo <- "njlyon0/dnd_grimoire"

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
spell_contents <- supportR::github_ls(repo = paste0("https://github.com/", spell_repo),
                                      folder = "_posts",
                                      recursive = F, quiet = F)

# Check structure
dplyr::glimpse(spell_contents)

# Strip out just markdown file names
spell_mds <- spell_contents$name

# Check that out
dplyr::glimpse(spell_mds)

## ---------------------------------------- ##
      # Extract Markdown Content ----
## ---------------------------------------- ##

# Make an empty list to store individually-wrangled spells within
list_o_spells <- list()

# Loop across spell markdown files
for(k in 1:length(spell_mds)){
# for(k in 2){

  # Define that spell's markdown URL
  spell_con <- base::url(paste0("https://raw.githubusercontent.com/", spell_repo,
                                "/main/_posts/", spell_mds[k]))

  # Strip out spell information as a vector
  spell_info <- base::readLines(con = spell_con)

  # Close the connection
  base::close(spell_con)

  # Wrangle the markdown information into something more manageable & add to spell list
  raw_spell <- as.data.frame(spell_info) %>%
    # Drop irrelevant lines
    dplyr::filter(nchar(spell_info) != 0 & spell_info != "---") %>%
    # Split the contents by the colon for later use
    tidyr::separate_wider_delim(cols = spell_info, delim = ":", cols_remove = F,
                                names = c("left", "right"),
                                too_few = "align_start", too_many = "merge") %>%
    # Add a column of what the true column names should be based on the contents
    dplyr::mutate(names_v1 = dplyr::case_when(
      left == "layout" ~ "layout",
      left == "title" ~ "title",
      left == "date" ~ "date",
      left == "sources" ~ "sources",
      left == "tags" ~ "tags",
      left == "subtags" ~ "subtags",
      dplyr::lag(x = left, n = 1) == "subtags" ~ "type",
      dplyr::lag(x = left, n = 1) == "tags" & !"subtags" %in% left ~ "type",
      left == "**Casting Time**" ~ "casting_time",
      left == "**Range**" ~ "range",
      left == "**Components**" ~ "components",
      left == "**Duration**" ~ "duration",
      # If none of above, must be description text
      TRUE ~ "description")) %>%
    # Get a row number column
    dplyr::mutate(row_num = 1:nrow(.)) %>%
    # Identify highest non-description row
    dplyr::mutate(temp_num = max(dplyr::filter(., names_v1 != "description")$row_num)) %>%
    # Count number of description rows
    dplyr::mutate(names = ifelse(test = names_v1 != "description",
                                 yes = names_v1,
                                 no = paste0("description_", (row_num - temp_num)))) %>%
    # Pare down to only needed columns
    dplyr::select(names, spell_info) %>%
    # Pivot wider
    tidyr::pivot_wider(names_from = names, values_from = spell_info) %>%
    # Wrangle spell name
    dplyr::mutate(name = gsub(pattern = "title:  |title: |\"", replacement = "", x = title),
                  .before = title) %>%
    # Drop title column
    dplyr::select(-title)

  # Add to list
  list_o_spells[[k]] <- raw_spell

  # Message successful wrangling
  message("Finished wrangling spell ", k, " '", raw_spell$name, "'") }

## ---------------------------------------- ##
      # Wrangle Markdown Content ----
## ---------------------------------------- ##

# Perform further wrangling on extracted markdown content
spells_v1 <- list_o_spells %>%
  # Unlist that list into a dataframe
  purrr::list_rbind() %>%
  # Remove unwanted columns
  dplyr::select(-layout, -date) %>%
  # Move the subtags column
  dplyr::relocate(subtags, .after = tags) %>%
  # Do some generally-valuable tidying
  dplyr::mutate(
    sources = gsub(pattern = "sources: |\\[|\\]", replacement = "", x = sources),
    tags = gsub(pattern = "tags: |\\[|\\]", replacement = "", x = tags),
    subtags = gsub(pattern = "subtags: |\\[|\\]", replacement = "", x = subtags),
    type = gsub(pattern = "\\*\\*", replacement = "", x = type),
    casting_time = gsub(pattern = "\\*\\*Casting Time\\*\\*: ", replacement = "",
                        x = casting_time),
    range = gsub(pattern = "\\*\\*Range\\*\\*: ", replacement = "", x = range),
    components = gsub(pattern = "\\*\\*Components\\*\\*: ", replacement = "",
                      x = components),
    duration = gsub(pattern = "\\*\\*Duration\\*\\*: ", replacement = "",
                    x = duration))

# Check structure of that
dplyr::glimpse(spells_v1)

# Export this for later
write.csv(x = spells_v1, file = file.path("dev", "raw_data", "raw_spells.csv"),
          na = '', row.names = F)

# Read back in if needed
## spells_v1 <- read.csv(file = file.path("dev", "raw_data", "raw_spells.csv"))

# Clean environment
rm(list = setdiff(ls(), c("spells_v1")))

## ---------------------------------------- ##
        # Tidy Spell Information ----
## ---------------------------------------- ##

# Do wrangling of non-description bits of spells
spells_v2 <- spells_v1 %>%
  # Create a column for whether the spell can be cast as a ritual
  dplyr::mutate(ritual = stringr::str_detect(string = tags, pattern = "ritual")) %>%
  # Drop "concentration" & "ritual" from tags
  dplyr::mutate(tags = gsub(pattern = "concentration, |concentration,|ritual, ",
                            replacement = "", x = tags)) %>%
  # Detect number of commas in tags
  dplyr::mutate(class_ct = stringr::str_count(string = tags, pattern = ",") - 2) %>%
  # Split apart tags information
  tidyr::separate_wider_delim(cols = tags, delim = ", ", cols_remove = T,
                              names = c(paste0("class_", 1:max(.$class_ct, na.rm = T)),
                                        "level", "junk", "school"),
                              too_few = "align_end", too_many = "merge") %>%
  # Drop 'junk' column & class count column
  dplyr::select(-junk, -class_ct) %>%
  # Tidy up the level column
  dplyr::mutate(level = gsub(pattern = "level", replacement = "level ", x = level)) %>%
  # If subtags column is empty, replace with NA
  dplyr::mutate(subtags = ifelse(test = nchar(subtags) == 0,
                                 yes = NA, no = subtags)) %>%
  # Combine class columns & subtags to get all classes with access to a given spell
  tidyr::unite(col = "class", dplyr::starts_with("class_"), subtags,
               sep = ", ", na.rm = T) %>%
  # Tidy that column a small amount
  dplyr::mutate(class = gsub(pattern = "  ", replacement = "", x = class)) %>%
  dplyr::mutate(class = gsub(pattern = "-", replacement = " ", x = class)) %>%
  # Drop now-superseded 'type' column
  dplyr::select(-type) %>%
  # Expand source acronyms for accessibility
  ## A
  dplyr::mutate(
    sources = gsub(pattern = "AAG", replacement = "Astral Adventurer's Guide", x = sources),
    sources = gsub(pattern = "AVT", replacement = "A Verdant Tomb", x = sources),
    ## E
    sources = gsub(pattern = "EE", replacement = "Elemental Evil", x = sources),
    sources = gsub(pattern = "EGW", replacement = "Explorer’s Guide to Wildemount", x = sources),
    ## F
    sources = gsub(pattern = "FCD", replacement = "From Cyan Depths", x = sources),
    sources = gsub(pattern = "FTD", replacement = "Fizban’s Treasury of Dragons", x = sources),
    ## G
    sources = gsub(pattern = "GGR", replacement = "Guildmasters’ Guide to Ravnica", x = sources),
    ## I
    sources = gsub(pattern = "IDRF", replacement = "Icewind Dale: Rime of the Frostmaiden",
                   x = sources),
    ## L
    sources = gsub(pattern = "LLK", replacement = "Lost Laboratory of Kwalish", x = sources),
    ## P
    sources = gsub(pattern = "PHB", replacement = "Player's Handbook", x = sources),
    ## S
    sources = gsub(pattern = "SCAG", replacement = "Sword Coast Adventurer’s Guide", x = sources),
    sources = gsub(pattern = "SCC", replacement = "Strixhaven: A Curriculum of Chaos", x = sources),
    sources = gsub(pattern = "SRD", replacement = "System Reference Document", x = sources),
    ## T
    sources = gsub(pattern = "TCE", replacement = "Tasha’s Cauldron of Everything", x = sources),
    ## X
    sources = gsub(pattern = "XGE", replacement = "Xanathar’s Guide to Everything", x = sources)) %>%
  # Do some minor grammar fixes
  dplyr::mutate(
    casting_time = gsub(pattern = "1 minutes", replacement = "1 minute", x = casting_time),
    components = gsub(pattern = "V,S", replacement = "V, S", x = components),
    components = gsub(pattern = "V ", replacement = "V", x = components)) %>%
  # Make these columns lowercase
  dplyr::mutate(casting_time = tolower(casting_time),
                range = tolower(range),
                duration = tolower(duration))

# Check out source information
sort(unique(gsub(pattern = "0|1|2|3|4|5|6|7|8|9", replacement = "",
                 x = spells_v2$sources)))

# Check out 'tags' column products
sort(unique(spells_v2$level))
sort(unique(spells_v2$school))

# Check out combination 'tags' and 'subtags' class/sub-class column
sort(unique(spells_v2$class))

# Check out other spell information
sort(unique(spells_v2$casting_time))
sort(unique(spells_v2$range))
sort(unique(spells_v2$components))
sort(unique(spells_v2$duration))

# Re-check structure (ignore description columns for now)
dplyr::glimpse(dplyr::select(spells_v2, -dplyr::starts_with("description")))

## ---------------------------------------- ##
      # Tidy Spell Descriptions ----
## ---------------------------------------- ##

# Glimpse the full structure
dplyr::glimpse(spells_v2)

# Wrangle descritpion into something more manageable
spells_v3 <- spells_v2 %>%
  # Pivot longer to get all description information into one column
  tidyr::pivot_longer(cols = dplyr::starts_with("description_"),
                      names_to = "desc_num", values_to = "text") %>%
  # Drop description column names (will shortly be outdated)
  dplyr::select(-desc_num) %>%
  # Drop NA rows
  dplyr::filter(!is.na(text)) %>%
  # Identify higher level spell information
  dplyr::mutate(
    higher_levels = ifelse(
      test = stringr::str_detect(string = text,
                                 pattern = "This spell’s damage increases by") |
        stringr::str_detect(string = text, pattern = "At Higher Levels."),
      yes = text, no = NA) ) %>%
  # Fill that in for the other rows of the spell
  dplyr::group_by(name) %>%
  tidyr::fill(higher_levels, .direction = "up") %>%
  dplyr::ungroup() %>%
  # Remove the higher level text from the general text column
  dplyr::mutate(text = dplyr::case_when(
    ## Fire bolt is malformed and needs special treatment
    name == "Fire Bolt" &
      stringr::str_detect(string = text, pattern = "This spell’s damage increases by") ~ "You hurl a mote of fire at a creature or object within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 fire damage. A flammable object hit by this spell ignites if it isn’t being worn or carried.",
    ## For other spells, with that text, coerce that row to NA
    name != "Fire Bolt" & (stringr::str_detect(string = text,
                                               pattern = "This spell’s damage increases by") |
                             stringr::str_detect(string = text,
                                                 pattern = "At Higher Levels.")) ~ NA,
    ## Retain any other text
    TRUE ~ text)) %>%
  # Remove the non-higher level stuff from fire bolt's description
  dplyr::mutate(higher_levels = ifelse(name == "Fire Bolt",
                                       yes = "This spell’s damage increases by 1d10 when you reach 5th level (2d10), 11th level (3d10), and 17th level (4d10).",
                                       no = higher_levels)) %>%
  # Drop the empty text rows created by removing the higher level information
  dplyr::filter(!is.na(text)) %>%
  # Identify creature stat blocks
  dplyr::mutate(stat_block = ifelse(
    test = stringr::str_detect(string = text, pattern = "## <u>") |
      stringr::str_detect(string = text, pattern = "ANIMATED OBJECTS STATISTICS"),
    yes = T, no = NA)) %>%
  # Fill NA for everything beneath stat block starts (i.e., stat block contents)
  dplyr::group_by(name) %>%
  tidyr::fill(stat_block, .direction = "down") %>%
  dplyr::ungroup() %>%
  # Remove creature stat block rows
  dplyr::filter(is.na(stat_block)) %>%
  # Count remaining text numbers
  dplyr::group_by(name) %>%
  dplyr::mutate(text_num = 1:dplyr::n()) %>%
  dplyr::ungroup() %>%
  # Simplify a few spell's descriptions manually
  dplyr::mutate(text = dplyr::case_when(
    ## Control weather has lengthy tables that we can manually simplify
    name == "Control Weather" & text == "**Precipitation**" ~ "Precipitation: 1 - Clear / 2 - Light Clouds / 3 - Overcast or ground fog / 4 - Rain, hail, or snow / 5 - Torrential rain, driving hail, or blizzard /// Temperature: 1 - Unbearable heat / 2 - Hot / 3 - Warm / 4 - Cool / 5 - Cold / 6 - Arctic cold /// Wind: 1 - Calm / 2 - Moderate wind / 3 - Strong wind / 4 - Gale / 5 - Storm",
    ## Choas Bolt also has a lengthy table
    name == "Chaos Bolt" & text == "|d8 |Damage Type|" ~ "1 - Acid / 2 - Cold / 3 - Fire / 4 - Force / 5 - Lightning / 6 - Poison / 7 - Psychic / 8 - Thunder",
    ## If the spell isn't specified, don't mess with the text
    TRUE ~ text)) %>%
  # Remove unnecessary information from specific spells
  ## Chaos Bolt
  dplyr::filter(name != "Chaos Bolt" | name == "Chaos Bolt" &
                  stringr::str_detect(string = text, pattern = "d8s") |
                  stringr::str_detect(string = text, pattern = "1 - Acid") |
                  stringr::str_detect(string = text, pattern = "creature")) %>%
  ## Control Weather
  dplyr::filter(name != "Control Weather" | name == "Control Weather" &
                  stringr::str_detect(string = text, pattern = "weather") |
                  stringr::str_detect(string = text, pattern = "Precipitation: 1 -")) %>%
  ## Teleport
  dplyr::filter(name != "Teleport" | name == "Teleport" &
                  stringr::str_detect(string = text, pattern = "instantly transports") |
                  stringr::str_detect(string = text, pattern = "rolls d100")) %>%
  ## Reincarnate
  dplyr::filter(name != "Reincarnate" | name == "Reincarnate" &
                  stringr::str_detect(string = text, pattern = "touch") |
                  stringr::str_detect(string = text, pattern = "fashions") |
                  stringr::str_detect(string = text, pattern = "reincarnated")) %>%
  ## Scrying
  dplyr::filter(name != "Scrying" | name == "Scrying" &
                  stringr::str_detect(string = text, pattern = "saving throw") |
                  stringr::str_detect(string = text, pattern = "save") |
                  stringr::str_detect(string = text, pattern = "choose a location")) %>%
  ## Misc. Other
  dplyr::filter(!name %in% c("Creation", "Summon Lesser Demons", "Reality Break") |
                  name %in% c("Creation", "Summon Lesser Demons", "Reality Break") &
                  stringr::str_detect(string = text, pattern = "\\|") != T) %>%
  # Handle [Spell Name](spell-name) formatting weirdness in text
  ## Split text by first square bracket
  tidyr::separate_wider_delim(cols = text, delim = "[", names = c("want1", "xtra1"),
                              too_few = "align_start", too_many = "merge") %>%
  ## Split remaining text by `](`
  tidyr::separate_wider_delim(cols = xtra1, delim = "](", names = c("want2", "xtra2"),
                              too_few = "align_start", too_many = "merge") %>%
  ## Tidy up that spell name that is now separate
  dplyr::mutate(want2 = stringr::str_to_title(want2)) %>%
  ## Split by closing parentheses
  tidyr::separate_wider_delim(cols = xtra2, delim = ")", names = c("junk", "want3"),
                              too_few = "align_end", too_many = "merge") %>%
  ## Recombine the parts we want and drop the column we don't
  tidyr::unite(col = "text", dplyr::starts_with("want"), sep = "", na.rm = T) %>%
  dplyr::select(-junk) %>%
  # Do that again to catch multiple spells in the same text row
  tidyr::separate_wider_delim(cols = text, delim = "[", names = c("want1", "xtra1"),
                              too_few = "align_start", too_many = "merge") %>%
  tidyr::separate_wider_delim(cols = xtra1, delim = "](", names = c("want2", "xtra2"),
                              too_few = "align_start", too_many = "merge") %>%
  dplyr::mutate(want2 = stringr::str_to_title(want2)) %>%
  tidyr::separate_wider_delim(cols = xtra2, delim = ")", names = c("junk", "want3"),
                              too_few = "align_end", too_many = "merge") %>%
  tidyr::unite(col = "text", dplyr::starts_with("want"), sep = "", na.rm = T) %>%
  dplyr::select(-junk) %>%
  # Re-do one final time for the two spells that reference three spells in one line of description
  tidyr::separate_wider_delim(cols = text, delim = "[", names = c("want1", "xtra1"),
                              too_few = "align_start", too_many = "merge") %>%
  tidyr::separate_wider_delim(cols = xtra1, delim = "](", names = c("want2", "xtra2"),
                              too_few = "align_start", too_many = "merge") %>%
  dplyr::mutate(want2 = stringr::str_to_title(want2)) %>%
  tidyr::separate_wider_delim(cols = xtra2, delim = ")", names = c("junk", "want3"),
                              too_few = "align_end", too_many = "merge") %>%
  tidyr::unite(col = "text", dplyr::starts_with("want"), sep = "", na.rm = T) %>%
  dplyr::select(-junk) %>%
  # Drop other unwanted column(s)
  dplyr::select(-stat_block, -text_num) %>%
  # Pare down to only non-unique columns
  dplyr::distinct() %>%
  # Drop empty description text rows
  dplyr::filter(!is.na(text) & nchar(text) != 0) %>%
  # Re-count lines of description
  dplyr::group_by(name) %>%
  dplyr::mutate(description_num = paste0("description_", 1:dplyr::n())) %>%
  dplyr::ungroup() %>%
  # Pivot to wide format
  tidyr::pivot_wider(names_from = description_num, values_from = text) %>%
  # Combine separate description text columns
  tidyr::unite(col = "description", dplyr::starts_with("description_"), sep = " ", na.rm = T) %>%
  # Remove some unnecessary formatting from the higher level info
  dplyr::mutate(higher_levels = gsub(pattern = "\\*\\*\\*At Higher Levels.\\*\\*\\* |\\*\\*At Higher Levels.\\*\\* ",
                                     replacement = "", x = higher_levels),
                .after = description) %>%
  # Fix weird not-quotes in text columns
  dplyr::mutate(description = gsub(pattern = "’", "'", x = description)) %>%
  dplyr::mutate(higher_levels = gsub(pattern = "’", "'", x = higher_levels))

# Re-check structure
dplyr::glimpse(spells_v3)

## ---------------------------------------- ##
          # Non-ASCII Handling ----
## ---------------------------------------- ##

# Need to check for non-ASCII characters
spells_v4 <- spells_v3 %>%
  # Process each row separately
  dplyr::rowwise() %>%
  # Count non-ASCII characters
  dplyr::mutate(non_ascii_ct = sum(stringr::str_detect(dplyr::c_across(-ritual),
                                                       pattern = "[^[:ascii:]]"),
                                   na.rm = T))

# Check how many rows this affects
spells_v4 %>%
  dplyr::filter(non_ascii_ct != 0) %>%
  dplyr::pull(name)

# Attempt fixes
spells_v5 <- spells_v4 %>%
  # Drop old count (interferes with downstream stuff)
  dplyr::select(-non_ascii_ct) %>%
  # Pretty sure weird curly apostrophe is (part of) this problem
  dplyr::mutate(dplyr::across(.cols = -ritual,
                              .fns = \(t){gsub(pattern = "’", replacement = "'",
                                               x = t)})) %>%
  # Curly quotes are an issue too
  dplyr::mutate(dplyr::across(.cols = -ritual,
                              .fns = \(t){gsub(pattern = "“|”", replacement = '"',
                                               x = t)})) %>%
  # Also non-hyphen dashes
  dplyr::mutate(dplyr::across(.cols = -ritual,
                              .fns = \(t){gsub(pattern = "—|−|-", replacement = "-",
                                               x = t)})) %>%
  # Multiplication symbol
  dplyr::mutate(dplyr::across(.cols = -ritual,
                              .fns = \(t){gsub(pattern = "×", replacement = "*",
                                               x = t)})) %>%
  # Worst of all, weird spaces
  dplyr::mutate(dplyr::across(.cols = -ritual,
                            .fns = \(t){gsub(pattern = " |  |  |­", replacement = " ",
                                               x = t)})) %>%
  # Bizarre letter weirdness
  dplyr::mutate(dplyr::across(.cols = -ritual,
                              .fns = \(t){gsub(pattern = "ﬁ", replacement = "fi",
                                               x = t)})) %>%
  # Re-count non-ASCII characters
  dplyr::rowwise() %>%
  dplyr::mutate(non_ascii_ct = sum(stringr::str_detect(dplyr::c_across(-ritual),
                                                       pattern = "[^[:ascii:]]"),
                                   na.rm = T))

# See how many are still problematic
spells_v5 %>%
  dplyr::filter(non_ascii_ct != 0) %>%
  dplyr::pull(name)

## ---------------------------------------- ##
            # Final Tidying ----
## ---------------------------------------- ##

# Do final tidying
spells <- spells_v5 %>%
  # Drop non-ASCII quantification
  dplyr::select(-non_ascii_ct) %>%
  # Rename some columns
  dplyr::rename(spell_name = name,
                spell_source = sources,
                pc_class = class,
                spell_level = level,
                spell_school = school,
                ritual_cast = ritual) %>%
  # Move some columns to new places
  dplyr::relocate(ritual_cast, .before = casting_time) %>%
  dplyr::relocate(higher_levels, .after = description)

# Last structure check
dplyr::glimpse(spells)

## ---------------------------------------- ##
                # Export ----
## ---------------------------------------- ##

# Export locally to dev folder for experimental purposes
## Already ignored by package (because `dev` folder) and added to `.gitignore`
write.csv(x = spells, file = file.path("dev", "tidy_data", "spells.csv"),
          row.names = F, na = '')

## If desired, export into package as a .rda object
# spells <- read.csv(file = file.path("dev", "tidy_data", "spells.csv"))
# save(spells, file = file.path("data", "spells.rda"), compress = "xz")

# End ----
