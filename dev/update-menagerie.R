## ---------------------------------------- ##
        # Update Creature Information
## ---------------------------------------- ##
# Author(s): Nick Lyon

# PURPOSE:
## Strip creature information from markdown files in a GitHub repository
## My forked repo here: https://github.com/njlyon0/dnd_menagerie

## ---------------------------------------- ##
            # Housekeeping ----
## ---------------------------------------- ##

# Load libraries
librarian::shelf(tidyverse, supportR)

# Clear environment
rm(list = ls())

# Define repo name
beast_repo <- "njlyon0/dnd_menagerie"

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
beast_contents <- supportR::github_ls(repo = paste0("https://github.com/", beast_repo),
                                      folder = "_creatures", recursive = T, quiet = F) %>%
  # Drop subfolders
  dplyr::filter(type != "dir")

# Check structure
dplyr::glimpse(beast_contents)

# Strip out just markdown file names
beast_mds <- beast_contents$name

# Check that out
dplyr::glimpse(beast_mds)

## ---------------------------------------- ##
      # Extract Markdown Content ----
## ---------------------------------------- ##

# Make an empty list to store individually-wrangled spells within
list_o_beasts <- list()

# Loop across creature markdown files
for(k in 1:length(beast_mds)){
# for(k in 2){
# k <- 2

  # Define that beast's markdown URL
  beast_con <-  base::url(paste0("https://raw.githubusercontent.com/", beast_repo,
                                 "/main/", beast_contents$path[k], "/", beast_mds[k]))

  # Tabularize the markdown file of beast info
  beast_info <- supportR::tabularize_md(file = beast_con)

  # Close the connection
  base::close(beast_con)

  # Wrangle the markdown information into something more manageable
  raw_beast <- beast_info %>%
    # Drop irrelevant lines
    dplyr::filter(nchar(text) != 0 & text != "---") %>%
    # Split the contents by the colon for later use
    tidyr::separate_wider_delim(cols = text, delim = ":", cols_remove = F,
                                names = c("left", "right"),
                                too_few = "align_start", too_many = "merge") %>%
    # Make left bit lowercase
    # dplyr::mutate(left = tolower(left)) %>%
    # Add a column of what the true column names should be based on the contents
    dplyr::mutate(names = dplyr::case_when(
      # Some can be allowed to remain as they are
      tolower(left) %in% c("layout", "name", "tags", "page_number",
                           "alignment", "challenge", "languages",
                           "senses", "skills", "saving_throws", "speed",
                           "hit_points", "armor_class", "condition_immunities",
                           "damage_vulnerabilities", "damage_resistances",
                           "damage_immunities") ~ tolower(left),
      # Others must be changed
      tolower(left) == "size" ~ "type",
      # Capitalize ability scores
      left == "cha" ~ "CHA",
      left == "wis" ~ "WIS",
      left == "int" ~ "INT",
      left == "con" ~ "CON",
      left == "dex" ~ "DEX",
      left == "str" ~ "STR",
      # If there is an "actions" heading then it must be that
      level_3 == "Actions" ~ "action",
      # If none of above, must be description text
      TRUE ~ "ability")) %>%
    # Get actual text of information (i.e., not section titles) into one columns
    dplyr::mutate(description = dplyr::case_when(
      names == "ability" & !is.na(right) ~ paste(left, right),
      names == "ability" & is.na(right) ~ left,
      names == "action" ~ text,
      T ~ gsub(pattern = '"', replacement = "", x = right))) %>%
    # Pare down to only desired columns
    dplyr::select(names, description)

  # Split off chunks that need separate handling
  tag <- dplyr::filter(raw_beast, names %in% c("layout", "name", "tags"))
  stat <- dplyr::filter(raw_beast, names %in% c("STR", "DEX", "CON", "INT", "WIS", "CHA"))
  ability <- dplyr::filter(raw_beast, names %in% c("ability", "action"))
  skill <- dplyr::filter(raw_beast, !names %in% c(tag$names, stat$names,
                                                  "ability", "action"))

  # Reorder statistics
  stat_v2 <- stat %>%
    # Make stats into a factor
    dplyr::mutate(names = factor(names, levels = c("STR", "DEX", "CON",
                                                   "INT", "WIS", "CHA"))) %>%
    # Order by stats
    dplyr::arrange(names) %>%
    # Change names back into a character
    dplyr::mutate(names = as.character(names))

  # Handle ability/action coalescing
  ability_v2 <- ability %>%
    # Identify the start of each ability
    dplyr::mutate(start = ifelse(stringr::str_count(string = description,
                                                    pattern = "\\*\\*\\*") == 2,
                                 yes = description, no = NA)) %>%
    # Fill down
    tidyr::fill(start, .direction = "down") %>%
    # Collapse separate lines into one line
    dplyr::group_by(names, start) %>%
    dplyr::summarize(description = paste(description, collapse = " ")) %>%
    dplyr::ungroup() %>%
    # Count number of abilities / actions
    dplyr::group_by(names) %>%
    dplyr::mutate(ct = dplyr::row_number()) %>%
    dplyr::ungroup() %>%
    # Paste count together with name
    dplyr::mutate(names = paste0(names, "_", ct)) %>%
    # Drop superseded columns
    dplyr::select(-start, -ct)

  # Reassemble into a single dataframe
  tidy_beast <- tag %>%
    dplyr::bind_rows(stat_v2) %>%
    dplyr::bind_rows(skill) %>%
    dplyr::bind_rows(ability_v2) %>%
    # Drop trailing/leading white space
    dplyr::mutate(description = base::trimws(x = description, which = "both")) %>%
    # And pivot to wide format
    tidyr::pivot_wider(names_from = names, values_from = description)

  # Add to list
  list_o_beasts[[k]] <- tidy_beast

  # Message successful wrangling
  message("Finished wrangling creature ", k, " (", tidy_beast$name,
          ") of ", length(beast_mds)) }

## ---------------------------------------- ##
      # Wrangle Markdown Content ----
## ---------------------------------------- ##

# Perform further wrangling on extracted markdown content
beasts_v1 <- list_o_beasts %>%
  # Unlist that list into a dataframe
  purrr::list_rbind() %>%
  # Remove unwanted columns
  dplyr::select(-layout) %>%
  # Move the description columns
  dplyr::relocate(dplyr::starts_with("description"),
                  .after = dplyr::everything())

# Check structure of that
dplyr::glimpse(beasts_v1)

# Export this for later
write.csv(x = beasts_v1, file = file.path("dev", "raw_data", "raw_menagerie.csv"),
          na = '', row.names = F)

# Read back in if needed
## beasts_v1 <- read.csv(file = file.path("dev", "raw_data", "raw_menagerie.csv"))

# Clean environment
rm(list = setdiff(ls(), c("beasts_v1")))

## ---------------------------------------- ##
        # Tidy Creature Information ----
## ---------------------------------------- ##

# Do wrangling of non-description bits of creatures
beasts_v2 <- beasts_v1 %>%
  # Create a column for whether the creature can be cast as a ritual
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
  # Combine class columns & subtags to get all classes with access to a given creature
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
                 x = beasts_v2$sources)))

# Check out 'tags' column products
sort(unique(beasts_v2$level))
sort(unique(beasts_v2$school))

# Check out combination 'tags' and 'subtags' class/sub-class column
sort(unique(beasts_v2$class))

# Check out other creature information
sort(unique(beasts_v2$casting_time))
sort(unique(beasts_v2$range))
sort(unique(beasts_v2$components))
sort(unique(beasts_v2$duration))

# Re-check structure (ignore description columns for now)
dplyr::glimpse(dplyr::select(beasts_v2, -dplyr::starts_with("description")))

## ---------------------------------------- ##
      # Tidy Creature Descriptions ----
## ---------------------------------------- ##

# Glimpse the full structure
dplyr::glimpse(beasts_v2)

# Wrangle descritpion into something more manageable
beasts_v3 <- beasts_v2 %>%
  # Pivot longer to get all description information into one column
  tidyr::pivot_longer(cols = dplyr::starts_with("description_"),
                      names_to = "desc_num", values_to = "text") %>%
  # Drop description column names (will shortly be outdated)
  dplyr::select(-desc_num) %>%
  # Drop NA rows
  dplyr::filter(!is.na(text)) %>%
  # Identify higher level creature information
  dplyr::mutate(
    higher_levels = ifelse(
      test = stringr::str_detect(string = text,
                                 pattern = "This spell’s damage increases by") |
        stringr::str_detect(string = text, pattern = "At Higher Levels."),
      yes = text, no = NA) ) %>%
  # Fill that in for the other rows of the creature
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
  # Simplify a few creature's descriptions manually
  dplyr::mutate(text = dplyr::case_when(
    ## Control weather has lengthy tables that we can manually simplify
    name == "Control Weather" & text == "**Precipitation**" ~ "Precipitation: 1 - Clear / 2 - Light Clouds / 3 - Overcast or ground fog / 4 - Rain, hail, or snow / 5 - Torrential rain, driving hail, or blizzard /// Temperature: 1 - Unbearable heat / 2 - Hot / 3 - Warm / 4 - Cool / 5 - Cold / 6 - Arctic cold /// Wind: 1 - Calm / 2 - Moderate wind / 3 - Strong wind / 4 - Gale / 5 - Storm",
    ## Choas Bolt also has a lengthy table
    name == "Chaos Bolt" & text == "|d8 |Damage Type|" ~ "1 - Acid / 2 - Cold / 3 - Fire / 4 - Force / 5 - Lightning / 6 - Poison / 7 - Psychic / 8 - Thunder",
    ## If the creature isn't specified, don't mess with the text
    TRUE ~ text)) %>%
  # Remove unnecessary information from specific creatures
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
  dplyr::mutate(higher_levels = gsub(pattern = "\\*\\*At Higher Levels.\\*\\* ",
                                     replacement = "", x = higher_levels),
                .after = description) %>%
  # Fix weird not-quotes in text columns
  dplyr::mutate(description = gsub(pattern = "’", "'", x = description)) %>%
  dplyr::mutate(higher_levels = gsub(pattern = "’", "'", x = higher_levels))

# Re-check structure
dplyr::glimpse(beasts_v3)

## ---------------------------------------- ##
            # Final Tidying ----
## ---------------------------------------- ##

# Do final tidying
menagerie <- beasts_v3 %>%
  # Rename some columns
  dplyr::rename(beast_name = name,
                beast_source = sources,
                pc_class = class,
                beast_level = level,
                beast_school = school,
                ritual_cast = ritual) %>%
  # Fix any lingering name issues
  dplyr::mutate(beast_name = gsub(pattern = "’", replacement = "'", x = beast_name)) %>%
  # Move some columns to new places
  dplyr::relocate(ritual_cast, .before = casting_time) %>%
  dplyr::relocate(higher_levels, .after = description)

# Last structure check
dplyr::glimpse(menagerie)

## ---------------------------------------- ##
                # Export ----
## ---------------------------------------- ##

# Export locally to dev folder for experimental purposes
## Already ignored by package (because `dev` folder) and added to `.gitignore`
write.csv(x = menagerie, file = file.path("dev", "tidy_data", "menagerie.csv"),
          row.names = F, na = '')

## If desired, export into package as a .rda object
# save(menagerie, file = file.path("data", "menagerie.rda"))

# End ----
