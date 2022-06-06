# --------------------------------------------- #
                # Package Checking
# --------------------------------------------- #

# Routine Checks --------------------------------

# Load the package
devtools::load_all()

# Run a R CMD check
devtools::check()

# Update documentation
devtools::document()

# Testing Dice Functions ------------------------

for (i in 1:1000){
  result <- data.frame('result' = d4())
  dice_check[[i]] <- result }
dice_check_df <- dice_check %>%
  purrr::map_dfr(.f = select, everything())
hist(x = dice_check_df$result)

# Adding Badges to README -----------------------

# R-CMD Check
# usethis::use_github_action_check_standard()

# Releasing to CRAN -----------------------------

# CRAN Repository Policy here:
## https://cran.r-project.org/web/packages/policies.html

# General info about releasing process here:
## https://r-pkgs.org/release.html

# Simplest way is to invoke devtools again
# devtools::release()

# Can also manually submit via CRAN's portal:
## https://cran.r-project.org/submit.html




# Getting Started -------------------------------
## Now unnecessary but good for next time!

# Create a README for easy GitHub rendering
# usethis::use_readme_rmd()


# ***

# Need a NEWS.md file!

# ***

# Reverse Dependency Checking -------------------
## Currently unnecessary but good to save for when updates are released

# Create a template for checking downstream dependencies
# usethis::use_revdep()

# For more information on this see:
## https://r-lib.github.io/revdepcheck/

# End ----
