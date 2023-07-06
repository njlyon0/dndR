# Spell Exploration Script

# I'd like a function that looks through all available spells and returns the desired ones
# `wizaRd` has some neat ones (https://github.com/oganm/wizaRd/tree/master) but the package won't install (for now) due to a dependency issue
# In the meantime I'm going to explore ways of meeting this need myself


# Load libraries
librarian::shelf(tidyverse, dndR)
# librarian::shelf(oganm/wizaRd)

# Grimoire link (list of 5e spells)
## https://github.com/Traneptora/grimoire/tree/master

# Load needed library
library(gh); library(purrr)



# Identify a repo URL
repo_url <- "https://github.com/Traneptora/grimoire"
folder <- "_includes"

# Strip out owner and repo name
repo_bits <- stringr::str_split_1(string = gsub(x = repo_url,
                                 pattern = "https\\:\\/\\/github.com\\/",
                                 replacement = ""),
                   pattern = "/")

# Build first query
repo_query_raw <- paste("/repos", repo_bits[1], repo_bits[2], "contents", sep = "/")

# Assemble API query
repo_query <- ifelse(nchar(folder) > 0,
                     yes = paste0(repo_query_raw, "/", folder),
                     no = repo_query_raw)

# Process GitHub URL into GitHub API query format
repo_conts <- gh::gh(endpoint = repo_query)

# Make empty vectors for later use
repo_values <- NULL
repo_types <- NULL

# Identify files in that folder
for(k in 1:length(repo_conts)){

  # Strip out vector of file/directory names and types
  repo_values <- c(repo_values, repo_conts[[k]]$name)
  repo_types <- c(repo_types, repo_conts[[k]]$type)

}

# Create a dataframe from this
repo_df <- data.frame("name" = repo_values,
                      "type" = repo_types)




# Identify top level contents
top <- gh::gh("/repos/Traneptora/grimoire/contents")

# Make two empty vectors
top_names <- NULL
top_types <- NULL

# Loop across resulting list
for(k in 1:length(top)){

  # Strip out vector of file/directory names and types
  top_names <- c(top_names, top[[k]]$name)
  top_types <- c(top_types, top[[k]]$type)

}

# Create a dataframe from this
top_df <- data.frame("name" = top_names,
                     "type" = top_types) %>%
  # Add some housekeeping columns we need later
  dplyr::mutate(listed = ifelse(type == "dir",
                                yes = FALSE, no = NA),
                parent = ".")

# Check out that product
top_df

# Duplicate this object
contents <- top_df

# While any folders are not identified
while(FALSE %in% contents$listed){

  # Loop across contents
  for(w in 1:nrow(contents)){

    # Only operate on unlisted directories (otherwise skip)
    if(contents[w, ]$type == "dir" & contents[w, ]$listed == FALSE){

      # Message start of processing
      message("Listing contents of directory '", contents[w, ]$name, "'")

      # Identify contents of that folder
      sub_list <- gh::gh(paste0("/repos/Traneptora/grimoire/contents/", contents[w, ]$name))



    } # Close conditional



    # # Skip non-directories
    # if(contents[w, ]$type != "dir"){
    #   message("Skipping non-directory '", contents[w, ]$name, "'")
    # }
    #
    # # Skip previously listed directories
    # if(contents[w, ]$type == "dir" & contents[w, ]$listed == TRUE){
    #   message("Skipping previously listed directory '", contents[w, ]$name)
    # }

    # Otherwise...



  } # Close `for` loop



} # Close `while` loop










# Can read Markdown in GitHub Grimoire from R
base::readLines(con = url("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/2014-08-24-acid-splash.markdown"))

## Need to figure out how to list out all of those URLs...

#
