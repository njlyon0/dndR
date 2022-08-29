## --------------------------------------------------- ##
              # `dndR` vs. DMG Comparisons
## --------------------------------------------------- ##

# PURPOSE:
## Creates graphs comparing DMG data to their `dndR` equivalents
## These can then be easily embedded into the README or vignette

# Setup ----

# Clear environment
rm(list = ls())

# Load needed libraries
# install.packages("librarian")
librarian::shelf(njlyon0/dndR, tidyverse)

# `xp_pool` vs. DMG ----

# Assemble a dataframe showing the DMG's party level versus easy encounter XP
xp_df <- data.frame('pc_level' = 1:20,
                    'easy_xp' = c(25, 50, 75, 125, 250, 300, 350, 450, 550, 600, 800, 1000, 1100, 1250, 1400, 1600, 2000, 2100, 2400, 2800)
                    ) %>%
  # For each row...
  dplyr::rowwise() %>%
  # Calculate the XP for that party level using my function
  dplyr::mutate(calc_xp = dndR::xp_pool(party_level = pc_level,
                                        party_size = 1,
                                        difficulty = 'easy')) %>%
  # Rename a column more intuitively
  dplyr::rename(book_xp = easy_xp) %>%
  # Pivot longer for ease of plotting
  tidyr::pivot_longer(cols = -pc_level, 
                      names_to = 'calc_method',
                      values_to = 'xp') %>%
  # Change the entries of the calc_method column
  dplyr::mutate(
    authority = base::ifelse(test = calc_method == "book_xp",
                             yes = "DMG",
                             no = "dndR"))

# Create the plot
xp_pool_plot <- ggplot2::ggplot(xp_df, aes(x = pc_level, y = xp, 
                                           shape = authority))  +
  geom_point(aes(fill = authority), color = 'black', size = 3,
             pch = rep(x = c(21, 24), times = 20),
             position = position_dodge(width = 0.5)) +
  geom_smooth(aes(color = authority), method = 'loess',
              formula = 'y ~ x', se = FALSE) +
  labs(x = "Party Level", y = "Experience Points (XP)") +
  scale_color_manual(values = c("#f46d43", "#74add1")) +
  scale_fill_manual(values = c("#f46d43", "#74add1")) +
  theme_classic() +
  theme(legend.position = c(0.15, 0.9),
        legend.title = element_blank(),
        axis.text.y = element_text(angle = 90, hjust = 0.5),
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 16))

# Check it out
xp_pool_plot

# Save it
ggplot2::ggsave(filename = file.path("vignettes", "xp_pool_plot.png"),
                plot = last_plot(), dpi = 720)

# `cr_convert` vs. DMG ----

# Assemble a dataframe showing the DMG XP to CR relationship
cr_actual <- data.frame(
  "cr" = c(0, 0.125, 0.25, 0.5, 1:30),
  "dmg_xp" = c(0, 25, 50, 100, 200, 450, 700, 1100, 1800, 2300, 2900,
               3900, 5000, 5900, 7200, 8400, 10000, 11500, 13000, 15000,
               18000, 20000, 22000, 25000, 33000, 41000, 50000, 62000,
               75000, 90000, 105000, 120000, 135000, 155000) ) %>%
  # For each row...
  dplyr::rowwise() %>%
  # Calculate XP for a given CR using `cr_convert`
  dplyr::mutate("calc_xp" = dndR::cr_convert(cr = cr)) %>%
  # Pivot to long format
  tidyr::pivot_longer(cols = dplyr::contains('_xp'),
                      names_to = "authority",
                      values_to = "xp") %>%
  # And clean up the entries of the source column
  dplyr::mutate(source = base::ifelse(test = (authority == "calc_xp"),
                                      yes = "dndR", no = "DMG"))

# Creat the plot comparison
cr_convert_plot <- ggplot(cr_actual, aes(x = cr, y = xp,
                                         shape = source)) +
  # geom_point(size = 3, pch = rep(x = c(17, 19), times = 34),
  #            position = position_dodge(width = 0.5)) +
  geom_point(aes(fill = source), color = 'black', size = 3,
             pch = rep(x = c(21, 24), times = 34),
             position = position_dodge(width = 0.5)) +
  geom_smooth(aes(color = source), method = 'loess',
              formula = 'y ~ x', se = FALSE) +
  # geom_smooth(formula = 'y ~ x', method = 'loess', se = F) +
  labs(x = "Challenge Rating (CR)", y = "Experience Points (XP)") +
  scale_color_manual(values = c("#c51b7d", "#4d9221")) +
  scale_fill_manual(values = c("#c51b7d", "#4d9221")) +
  theme_classic() +
  theme(legend.position = c(0.2, 0.9),
        legend.title = element_blank(),
        # axis.text.y = element_text(angle = 90, hjust = 0.5, size = 12),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 14),
        axis.title = element_text(size = 16))

# Check it out
cr_convert_plot

# Save it
ggplot2::ggsave(filename = file.path("vignettes", "cr_convert_plot.png"),
                plot = last_plot(), dpi = 720)

# Clear environment (again)
rm(list = ls())

# End ----