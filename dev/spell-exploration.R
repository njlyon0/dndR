## ---------------------------------------- ##
            # Spell Exploration
## ---------------------------------------- ##
# Author(s): Nick Lyon

# PURPOSE:
## Develop a function that allows users to query extant D&D spells based on various criteria
## `wizaRd` (github.com/oganm/wizaRd) has something similar but it is very list-y
## Ideally this will create something that is structurally similar to other `dndR` functions
### E.g., vectors / dataframes (I feel those are a little more accessible to R novices)

## ---------------------------------------- ##
            # Housekeeping ----
## ---------------------------------------- ##

# Load libraries
librarian::shelf(tidyverse, supportR, dndR)

# Clear environment
rm(list = ls())

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
spell_repo <- supportR::github_ls(repo = 'https://github.com/Traneptora/grimoire',
                                 folder = "_posts", recursive = F, quiet = F)

# Check structure
dplyr::glimpse(spell_repo)

# Strip out just markdown file names
spell_mds <- spell_repo$name

# Check that out
dplyr::glimpse(spell_mds)

## ---------------------------------------- ##
      # Extract Spell Information ----
## ---------------------------------------- ##

# Clean environment
rm(list = setdiff(ls(), c("spell_mds")))

# Make an empty list to store individually-wrangled spells within
list_o_spells <- list()

# Loop across spell markdown files
for(k in 1:length(spell_mds)){
# for(k in 2){

  # Define that spell's markdown URL
  spell_con <- base::url(paste0("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/", spell_mds[k]))

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

# Perform further wrangling
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

## ---------------------------------------- ##
      # Wrangle Spell Information ----
## ---------------------------------------- ##

# Do wrangling of non-description bits of spells
spells_v2 <- spells_v1 %>%
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
  # Combine class columns & subtags to get all classes with access to a given spell
  tidyr::unite(col = "class", dplyr::starts_with("class_"), subtags,
               sep = ", ", na.rm = T) %>%
  # Tidy that column a small amount
  dplyr::mutate(class = gsub(pattern = "  ", replacement = "", x = class)) %>%
  # Drop now-superseded 'type' column
  dplyr::select(-type) %>%
  # Expand source acronyms for accessibility
  ## A
  dplyr::mutate(sources = gsub(pattern = "AAG", replacement = "Astral Adventurer's Guide", x = sources)) %>%
  dplyr::mutate(sources = gsub(pattern = "AVT", replacement = "A Verdant Tomb", x = sources)) %>%
  ## E
  dplyr::mutate(sources = gsub(pattern = "EE", replacement = "Elemental Evil", x = sources)) %>%
  dplyr::mutate(sources = gsub(pattern = "EGW", replacement = "Explorer’s Guide to Wildemount", x = sources)) %>%
  ## F
  dplyr::mutate(sources = gsub(pattern = "FCD", replacement = "From Cyan Depths", x = sources)) %>%
  dplyr::mutate(sources = gsub(pattern = "FTD", replacement = "Fizban’s Treasure of Dragons", x = sources)) %>%
  ## G
  dplyr::mutate(sources = gsub(pattern = "GGR", replacement = "Guildmasters’ Guide to Ravnica", x = sources)) %>%
  ## I
  dplyr::mutate(sources = gsub(pattern = "IDRF", replacement = "Icewind Dale: Rime of the Frostmaiden", x = sources)) %>%
  ## L
  dplyr::mutate(sources = gsub(pattern = "LLK", replacement = "Lost Laboratory of Kwalish", x = sources)) %>%
  ## P
  dplyr::mutate(sources = gsub(pattern = "PHB", replacement = "Player's Handbook", x = sources)) %>%
  ## S
  dplyr::mutate(sources = gsub(pattern = "SCAG", replacement = "Sword Coast Adventurer’s Guide", x = sources)) %>%
  dplyr::mutate(sources = gsub(pattern = "SCC", replacement = "Strixhaven: A Curriculum of Chaos", x = sources)) %>%
  dplyr::mutate(sources = gsub(pattern = "SRD", replacement = "System Reference Document", x = sources)) %>%
  ## T
  dplyr::mutate(sources = gsub(pattern = "TCE", replacement = "Tasha’s Cauldron of Everything", x = sources)) %>%
  ## X
  dplyr::mutate(sources = gsub(pattern = "XGE", replacement = "Xanathar’s Guide to Everything", x = sources)) %>%
  # dplyr::mutate(sources = gsub(pattern = "", replacement = "", x = sources)) %>%
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
sort(unique(spells_v2$sources))

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
# Wrangle Spell Descriptions ----
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
  # Collapse all description text into one row / spell
  dplyr::group_by(name, sources, class, level, school, casting_time, range, components, duration, higher_levels) %>%
  dplyr::summarize(description = paste(text, collapse = ". ")) %>%
  dplyr::ungroup() %>%
  # Remove some unnecessary formatting from the higher level info
  dplyr::mutate(higher_levels = gsub(pattern = "\\*\\*At Higher Levels.\\*\\* ",
                                     replacement = "", x = higher_levels),
                .after = description)

## Need to fix secondary spell formatting within description of current spell
## Like this:
# *[Gust of Wind](gust-of-wind)*


# Re-check structure
dplyr::glimpse(spells_v3)
## view(spells_v3)



## ---------------------------------------- ##
# Query Spells ----
## ---------------------------------------- ##


# Once I finish upstream of this I can work on a streamlined path for querying specific spells / spells by criteria (e.g., class, school, etc.)



# End ----

