#' @title Generate a Diagram of a Party's Ability Scores
#'
#' @description Input a party's ability scores and visualize either by ability or player character.
#'
#' @param by (character) Either "player" (default) or "ability". Define the facets of the party diagram.

#' @param pc_stats (list) A named list of ability scores for each character.
#'
#' @return (ggplot object) The party diagram as a ggplot object.
#'
#' @import ggplot2
#' 
#' @importFrom stats aggregate
#'
#' @export
#'
party_diagram <- function(pc_stats, by) {
  # Check if by is a valid option
  if (missing(by)) {
    by <- "player"
  } else if (!by %in% c("player", "ability")) {
    stop("`by` must be 'player' or 'ability'")
  }
  # If no ability scores are passed to the function, generate a new list
  if (missing(pc_stats)) {
    pc_stats <- list()
    base::message("Creating diagram for a new party")
    base::message("Adding PC 1")
    i <- 1
    while (TRUE) {
      pc_stat <- list()
      name <-
        base::readline(prompt = sprintf("Name (leave empty for 'PC %s'): ", i))
      if (name == "") {
        name <- sprintf("PC %s", i)
      }
      pc_stat["STR"] <- base::readline(prompt = "STR: ")
      pc_stat["DEX"] <- base::readline(prompt = "DEX: ")
      pc_stat["CON"] <- base::readline(prompt = "CON: ")
      pc_stat["INT"] <- base::readline(prompt = "INT: ")
      pc_stat["WIS"] <- base::readline(prompt = "WIS: ")
      pc_stat["CHA"] <- base::readline(prompt = "CHA: ")
      pc_stats[[name]] <- pc_stat
      i <- i + 1
      if (substr(base::readline(prompt = sprintf("Add PC %s? (yes/no): ", i)), 1, 1) == "n") {
        break
      } else {
        next
      }
    }
    # Print representation for easier access
    dput(pc_stats)
  }

  pc_stats <- do.call(rbind,
                      lapply(names(pc_stats),
                             \(pc) {
                               return(data.frame(
                                 name = pc,
                                 ability = rownames(t(data.frame(pc_stats[[pc]]))),
                                 score = t(data.frame(pc_stats[[pc]]))
                               ))
                             }))
  pc_stats$score <- as.numeric(pc_stats$score)
  pc_stats$ability <-
    factor(pc_stats$ability,
           levels = c("STR", "DEX", "CON", "INT", "WIS", "CHA"))
  if (by == "player") {
    stats_agg <-
      stats::aggregate(pc_stats$score, list(pc_stats$name), FUN = mean)
    names(stats_agg) <- c("name", "mean")
    stats_agg$mean <- round(stats_agg$mean, 2)
    stats_agg$name <-
      paste(stats_agg$name, " (Avg: ", stats_agg$mean, ")", sep = "")
    pc_stats$name <-
      factor(pc_stats$name,
             levels = unique(pc_stats$name),
             labels = stats_agg$name)
    pc_stats$ability <-
      factor(pc_stats$ability, levels = rev(levels(pc_stats$ability)))
    fig <-
      ggplot(pc_stats, aes_string(x = "ability", y = "score", color = "ability")) +
      geom_hline(data = stats_agg,
                 aes(yintercept = mean),
                 linetype = "dashed") +
      geom_point(size = 3) +
      geom_segment(
        aes_string(
          x = "ability",
          y = 0,
          yend = "score",
          xend = "ability"
        ),
        size = 2,
        alpha = .7
      ) +
      geom_label(aes_string(x = "ability", y = "score - 4", label = "score"), color = "black") +
      scale_y_continuous(limits = c(0, max(20, max(pc_stats$score)))) +
      scale_color_brewer(type = "qual", palette = "Dark2") +
      coord_flip() +
      facet_wrap( ~ name, scales = "free") +
      theme_minimal() +
      guides(color = guide_legend(reverse = TRUE)) +
      labs(
        x = "Ability",
        y = "Score",
        title = "Ability Scores by Player",
        color = "Ability"
      )
  } else {
    stats_agg <-
      aggregate(pc_stats$score, list(pc_stats$ability), FUN = mean)
    names(stats_agg) <- c("ability", "mean")
    stats_agg$mean <- round(stats_agg$mean, 2)
    stats_agg$ability <-
      paste(stats_agg$ability, " (Avg: ", stats_agg$mean, ")", sep = "")
    pc_stats$ability <-
      factor(
        pc_stats$ability,
        levels = levels(pc_stats$ability),
        labels = stats_agg$ability
      )
    stats_agg$ability <- factor(stats_agg$ability)
    fig <-
      ggplot(pc_stats, aes_string(x = "name", y = "score", color = "name")) +
      geom_hline(data = stats_agg,
                 aes(yintercept = mean),
                 linetype = "dashed") +
      geom_point(size = 3) +
      geom_segment(aes_string(
        x = "name",
        y = 0,
        yend = "score",
        xend = "name"
      ),
      size = 2,
      alpha = .7) +
      geom_label(aes_string(x = "name", y = "score - 4", label = "score"), color = "black") +
      scale_y_continuous(limits = c(0, max(20, max(pc_stats$score)))) +
      scale_color_brewer(type = "qual", palette = "Dark2") +
      coord_flip() +
      facet_wrap( ~ ability, scales = "free") +
      theme_minimal() +
      guides(color = guide_legend(reverse = TRUE)) +
      labs(
        x = "PC Name",
        y = "Score",
        title = "Players Scores by Ability",
        color = "PC Name"
      )
  }
  return(fig)
}