# Spell Exploration Script

# I'd like a function that looks through all available spells and returns the desired ones
# `wizaRd` has some neat ones (https://github.com/oganm/wizaRd/tree/master) but the package won't install (for now) due to a dependency issue
# In the meantime I'm going to explore ways of meeting this need myself


# Load libraries
librarian::shelf(tidyverse, dndR)
# librarian::shelf(oganm/wizaRd)

# Grimoire link (list of 5e spells)
## https://github.com/Traneptora/grimoire/tree/master


# Can read Markdown in GitHub Grimoire from R
base::readLines(con = url("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/2014-08-24-acid-splash.markdown"))

## Need to figure out how to list out all of those URLs...

# Working on solve in function-form in `supportR`

#
