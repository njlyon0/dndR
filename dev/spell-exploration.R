# Spell Exploration Script

# I'd like a function that looks through all available spells and returns the desired ones
# `wizaRd` has some neat ones (https://github.com/oganm/wizaRd/tree/master) but the package won't install (for now) due to a dependency issue
# In the meantime I'm going to explore ways of meeting this need myself


# Load libraries
librarian::shelf(tidyverse, supportR, dndR)
## librarian::shelf(oganm/wizaRd) # possibly useful package

# Identify spells in Grimoire (GitHub repo with markdown files of _ D&D spells)
spell_repo <- supportR::github_ls(repo = 'https://github.com/Traneptora/grimoire',
                                 folder = "_posts", recursive = F, quiet = F)

# Strip out just markdown file names
spell_mds <- spell_repo$name

# Check that out
dplyr::glimpse(spell_mds)

# Read lines of the first spell's Markdown as a test
base::readLines(con = url(paste0("https://raw.githubusercontent.com/Traneptora/grimoire/master/_posts/", spell_mds[1])))

#


