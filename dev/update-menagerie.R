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

# Silence summarize
options(dplyr.summarise.inform = F)

# Clear environment
rm(list = ls())

# Define repo name
beast_repo <- "njlyon0/dnd_menagerie"

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
beast_contents <- supportR::github_ls(repo = paste0("https://github.com/", beast_repo),
                                      folder = "_creatures", recursive = T, quiet = F) %>%
  # Drop subfolders
  dplyr::filter(type != "dir") %>%
  # Remove any template markdown files
  dplyr::filter(stringr::str_detect(string = name, pattern = "template") != TRUE)

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

# Make another list to store malformed markdown files
## Or those without expected components
quarantine <- list()

# Loop across creature markdown files
for(k in 1:length(beast_mds)){
  # for(k in 2){

  # Define that beast's markdown URL
  beast_con <-  base::url(paste0("https://raw.githubusercontent.com/", beast_repo,
                                 "/main/", beast_contents$path[k], "/", beast_mds[k]))

  # Tabularize the markdown file of beast info
  beast_info <- supportR::tabularize_md(file = beast_con)

  # Close the connection
  base::close(beast_con)

  # Skip homebrew monsters
  if(!"level_3" %in% names(beast_info)){

    # Add to quarantine list for later evaluation
    quarantine[[paste("beast_", k)]] <- beast_info

    # Skip message
    message("Quarantining creature ", k, " (expected markdown formatting not found)")

    # If not homebrewed, attempt wrangling
  } else {

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
      # Remove any multiple spaces
      dplyr::mutate(description = gsub(pattern = "  |   | ", replacement = " ",
                                       x = description)) %>%
      # And pivot to wide format
      tidyr::pivot_wider(names_from = names, values_from = description)

    # Add to list
    list_o_beasts[[paste("beast_", k)]] <- tidy_beast

    # Message successful wrangling
    message("Finished wrangling creature ", k, " (", tidy_beast$name,
            ") of ", length(beast_mds))
  } # Close wrangling conditional
} # Close loop

# Perform further wrangling on extracted markdown content
beasts_v1 <- list_o_beasts %>%
  # Unlist that list into a dataframe
  purrr::list_rbind(x = .) %>%
  # Remove unwanted columns
  dplyr::select(-layout) %>%
  # Move the longer format columns
  dplyr::relocate(dplyr::starts_with("ability_"),
                  dplyr::starts_with("action_"),
                  .after = dplyr::everything())

# Check structure of that
dplyr::glimpse(beasts_v1)

# Identify "quarantined" creatures
quarantine %>%
  purrr::list_rbind(x = .) %>%
  dplyr::filter(stringr::str_detect(string = text, pattern = "name: "))

# Export this for later
write.csv(x = beasts_v1, file = file.path("dev", "raw_data", "raw_menagerie.csv"),
          na = '', row.names = F)

# Read back in if needed
## beasts_v1 <- read.csv(file = file.path("dev", "raw_data", "raw_menagerie.csv"))

# Clean environment
rm(list = setdiff(ls(), c("beasts_v1")))

## ---------------------------------------- ##
      # Wrangle Markdown Content ----
## ---------------------------------------- ##

# Check structure of current object
dplyr::glimpse(beasts_v1)

# Do wrangling of non-descriptive bits of creatures
beasts_v2 <- beasts_v1 %>%
  # Remove commas from raw challenge rating
  dplyr::mutate(challenge = gsub(pattern = ",", replacement = "", x = challenge)) %>%
  # Separate XP and CR information
  dplyr::mutate(xp = stringr::str_extract(string = challenge,
                                          pattern = "((\\d+){1,50} XP)"),
                cr = stringr::str_extract(string = challenge,
                                          pattern = "1\\/(\\d+){1,50} \\("),
                .after = challenge) %>%
  # Fill in missing CRs (non-fractional ones)
  dplyr::mutate(cr = ifelse(is.na(cr) == TRUE,
                            yes = stringr::str_extract(string = challenge,
                                                       pattern = "(\\d+){1,50} \\("),
                            no = cr)) %>%
  # Remove dangling non-numbers
  dplyr::mutate(xp = gsub(pattern = " XP", replacement = "", x = xp),
                cr = gsub(pattern = " \\(", replacement = "", x = cr)) %>%
  # Convert fraction CRs into decimals
  dplyr::mutate(cr = dplyr::case_when(
    cr == "1/2" ~ "0.5",
    cr == "1/4" ~ "0.25",
    cr == "1/8" ~ "0.125",
    T ~ cr)) %>%
  # Drop superseded 'challenge' information
  dplyr::select(-challenge) %>%
  # Parse 'type' into size versus type
  tidyr::separate_wider_delim(cols = type, delim = " ",
                              names = c("size", "type"),
                              too_many = "merge") %>%
  # Make most character columns lowercase
  dplyr::mutate(dplyr::across(.cols = c("tags", "size", "type", "languages",
                                        "skills", "senses", "damage_immunities",
                                        "damage_resistances", "condition_immunities",
                                        "damage_vulnerabilities"),
                              .fns = tolower))

# Check structure
dplyr::glimpse(beasts_v2[,1:26])

# Next we need to handle "A" versus "B" variants of creatures
## So that only one value is returned for a given creature
beasts_v3 <- beasts_v2 %>%
  # Drop all "B" variants
  dplyr::filter(stringr::str_detect(string = name, pattern = "\\(B\\)") != TRUE) %>%
  # Remove "(A)" from end of remaining variants' names
  dplyr::mutate(name = gsub(pattern = " \\(A\\)", replacement = "", x = name))

# Check to make sure that only dropped unwanted entries
supportR::diff_check(old = unique(beasts_v2$name), new = unique(beasts_v3$name))

# Check overall structure again
dplyr::glimpse(beasts_v3[,1:26])

# Break tags apart to the component pieces of information
beasts_v4 <- beasts_v3 %>%
  # Remove brackets
  dplyr::mutate(tags = gsub(pattern = "\\[|\\]", replacement = "", x = tags)) %>%
  # Remove one monster that has a weird tag (I suspect it's homebrew)
  dplyr::filter(name != "Angulotl Blade") %>%
  # Serparate by commas
  tidyr::separate_wider_delim(cols = tags, delim = ", ",
                              names = c("junk_1", "junk_2", "junk_3", "source")) %>%
  # Drop 'junk' columns (redundant with existing info)
  dplyr::select(-dplyr::starts_with("junk_")) %>%
  # Tidy up source column
  dplyr::mutate(source = stringr::str_to_title(gsub(pattern = "\\-", replacement = " ", x = source)))

# Re-re-re-check structure
dplyr::glimpse(beasts_v4[,1:26])

## ---------------------------------------- ##
            # Final Tidying ----
## ---------------------------------------- ##

# Do final tidying
menagerie <- beasts_v4 %>%
  # Remove all homebrewed entries
  dplyr::filter(!source %in% c("Homebrew", "Out of The Box 5e")) %>%
  # Rename columns to be more explicit that they are about monsters
  ## (Allows for simpler argument names in downstream functions)
  dplyr::rename(monster_name = name,
                monster_source = source,
                monster_size = size,
                monster_type = type,
                monster_alignment = alignment,
                monster_xp = xp,
                monster_cr = cr) %>%
  # Make XP and CR into numbers
  dplyr::mutate(monster_xp = as.numeric(monster_xp),
                monster_cr = as.numeric(monster_cr)) %>%
  # Make skills in 'title case'
  dplyr::mutate(skills = stringr::str_to_title(string = skills)) %>%
  # Make saving throws uppercase
  dplyr::mutate(saving_throws = toupper(saving_throws)) %>%
  # Reorder "damage_..." columns
  dplyr::relocate(dplyr::starts_with("damage_"),
                  .after = saving_throws) %>%
  # Drop unwanted columns
  dplyr::select(-page_number)

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
