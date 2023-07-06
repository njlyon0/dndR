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
library(httr)


library(gh)

grim_conts <- gh::gh("/repos/Traneptora/grimoire/contents")
str(grim_conts)


for(i in 1:length(grim_conts)){

  message("Element ", i, " is ", grim_conts[[i]]$name)

}


grim_conts[[11]]


# Grab the contents of that repo
grimoire_gh <- httr::GET(url = paste0("https://api.github.com/repos/Traneptora/grimoire/tree/master", "?recursive=1"))
grimoire_gh


httr::GET(url = "")

# Check for warnings / errors
httr::stop_for_status(x = grimoire_gh)

# Access files in that link
httr::content(x = grimoire_gh)$tree





# Can read Markdown in GitHub Grimoire from R
base::readLines(con = url("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/2014-08-24-acid-splash.markdown"))

## Need to figure out how to list out all of those URLs...

#
