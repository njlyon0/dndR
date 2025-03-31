#' @title Generate a Diagram of a Party's Ability Scores
#'
#' @description Input a party's ability scores and visualize either by ability or player character. Includes dashed line for average of ability scores within chosen `by` parameter. Huge shout out to Tim Schatto-Eckrodt for contributing this function!
#'
#' @param by (character) either "player" (default) or "ability". Defines the facets of the party diagram
#' @param pc_stats (null / list) either `NULL` (default) or named list of ability scores for each character. If `NULL`, player names and scores are requested interactively in the console
#' @param quiet (logical) if FALSE (default), prints interactively assembled PC list for ease of subsequent use
#'
#' @return (ggplot object) party diagram as a ggplot object
#' @import ggplot2
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' \donttest{
#' # Create named list of PCs and their scores
#' party_list <- list(
#' Vax = list(
#' STR = "10", DEX = "13", CON = "14", INT = "15", WIS = "16", CHA = "12"),
#' Beldra = list(
#' STR = "20", DEX = "15", CON = "10", INT = "10", WIS = "11", CHA = "12"),
#' Rook = list(
#' STR = "10", DEX = "10", CON = "18", INT = "9", WIS = "11", CHA = "16"))
#'
#' # Create a party diagram using that list (by player)
#' party_diagram(by = "player", pc_stats = party_list, quiet = TRUE)
#'
#' # Can easily group by ability with the same list!
#' party_diagram(by = "ability", pc_stats = party_list, quiet = FALSE)
#' }
party_diagram <- function(by = "player", pc_stats = NULL, quiet = FALSE) {
  # Squelch visible bindings note
  STR <- CHA <- player <- ability <- score <- NULL
  
  # Error out if 'by' is not valid
  if(!by %in% c("player", "ability"))
    stop("'by' must be 'player' or 'ability'")
  
  # If quiet is not a logical, warn the user and coerce to default
  if(is.logical(quiet) != TRUE){
    warning("'quiet' must be logical. Coercing to FALSE")
    quiet <- FALSE }
  
  # Assemble ability scores ----
  
  # If no ability scores are passed to the function, generate a new list
  # Groundwork
  if (is.null(pc_stats)) {
    pc_stats <- list()
    base::message("Creating diagram for a new party")
    base::message("Adding PC 1")
    i <- 1
    while(TRUE){
      # Request name from user
      pc_value <- list()
      name <-
        base::readline(prompt = sprintf("Name (leave empty for 'PC %s'): ", i))
      if(name == ""){ name <- sprintf("PC %s", i) }
      
      # Request ability scores for this PC from user
      ## Strength
      pc_value["STR"] <- base::readline(prompt = "STR: ")
      if (!grepl("^[0-9]*$", pc_value["STR"])) {
        stop("Ability score must only contain numbers") }
      ## Dexterity
      pc_value["DEX"] <- base::readline(prompt = "DEX: ")
      if (!grepl("^[0-9]*$", pc_value["DEX"])) {
        stop("Ability score must only contain numbers") }
      ## Constitution
      pc_value["CON"] <- base::readline(prompt = "CON: ")
      if (!grepl("^[0-9]*$", pc_value["CON"])) {
        stop("Ability score must only contain numbers") }
      ## Intelligence
      pc_value["INT"] <- base::readline(prompt = "INT: ")
      if (!grepl("^[0-9]*$", pc_value["INT"])) {
        stop("Ability score must only contain numbers") }
      ## Wisdom
      pc_value["WIS"] <- base::readline(prompt = "WIS: ")
      if (!grepl("^[0-9]*$", pc_value["WIS"])) {
        stop("Ability score must only contain numbers") }
      ## Charisma
      pc_value["CHA"] <- base::readline(prompt = "CHA: ")
      if (!grepl("^[0-9]*$", pc_value["CHA"])) {
        stop("Ability score must only contain numbers") }
      
      # Assemble statistics into list and advance counter
      pc_stats[[name]] <- pc_value
      i <- i + 1
      
      # Ask user if they want to add another PC and if they do, return to top  of 'while' loop
      if (base::substr(x = base::readline(prompt = sprintf("Add PC %s? (yes/no): ", i)), start = 1, stop = 1) == "n") {
        break
      } else { next }
    }
    # Print representation of list for easier subsequent access
    base::dput(x = pc_stats)
  }
  
  # Wrangle ability scores ----
  # Wrangle list to make it easier for 'ggplot2'
  pc_df <- pc_stats %>%
    # Condense list into a dataframe
    purrr::map_df(.f = dplyr::bind_rows) %>%
    # Strip player name out of the list names as a column
    dplyr::mutate("player" = names(pc_stats), .before = STR) %>%
    # Coerce all abilities into numeric
    dplyr::mutate(dplyr::across(.cols = -player,
                                .fns = base::as.numeric)) %>%
    # Pivot longer
    tidyr::pivot_longer(cols = STR:CHA,
                        names_to = "ability",
                        values_to = "score") %>%
    # Make the abilities have an order
    dplyr::mutate(ability = factor(x = ability, levels = c("STR", "DEX", "CON", "INT", "WIS", "CHA"))) %>%
    # Make it a dataframe
    as.data.frame()
  
  # Create core diagram by player ----
  if(by == "player"){
    
    ## Create summarized dataframe
    pc_summarized <- pc_df %>%
      dplyr::group_by(player) %>%
      dplyr::mutate(mean = base::round(
        x = base::mean(x = score, na.rm = TRUE),
        digits = 2)) %>%
      as.data.frame()
    
    ## Create fundamental plot (tiny stuff handled after)
    diagram_core <- ggplot(pc_summarized,
                           aes(x = .data[["ability"]], y = .data[["score"]],
                               color = .data[["ability"]])) +
      # Add horizontal lines for averages
      geom_hline(aes(yintercept = mean), linetype = "dashed") +
      # Connect end point to axis
      geom_segment(aes(x = .data[["ability"]], y = 0,
                       yend = .data[["score"]], xend = .data[["ability"]]),
                   linewidth = 2, alpha = 0.7) +
      # Add text bubbles for individual scores
      geom_label(aes(x = .data[["ability"]], y = .data[["score"]] - 4,
                     label = .data[["score"]]), color = "black") +
      # Facet the graph!
      facet_wrap(. ~ player, scales = "free") +
      # Add better title
      labs(title = "Party Diagram by Player")
  }
  
  # Create core diagram by score ----
  if(by == "ability"){
    
    ## Create summarized dataframe
    pc_summarized <- pc_df %>%
      dplyr::group_by(ability) %>%
      dplyr::mutate(mean = base::round(
        x = base::mean(x = score, na.rm = TRUE),
        digits = 2)) %>%
      as.data.frame()
    
    ## Create fundamental plot (tiny stuff handled after)
    diagram_core <- ggplot(pc_summarized,
                           aes(x = .data[["player"]], y = .data[["score"]],
                               color = .data[["ability"]])) +
      # Add horizontal lines for averages
      geom_hline(aes(yintercept = mean), linetype = "dashed") +
      # Connect end point to axis
      geom_segment(aes(x = .data[["player"]], y = 0,
                       yend = .data[["score"]], xend = .data[["player"]]),
                   linewidth = 2, alpha = 0.7) +
      # Add text bubbles for individual scores
      geom_label(aes(x = .data[["player"]], y = .data[["score"]] - 4,
                     label = .data[["score"]]), color = "black") +
      # Facet the graph!
      facet_wrap(. ~ ability, scales = "free") +
      # Add better title
      labs(title = "Party Diagram by Ability Score")
  }
  
  # Finalize diagram ----
  diagram <- diagram_core +
    # Add a point geometry to scores (makes big end point)
    geom_point(size = 3) +
    # Let the y-axis resize based on actual scores
    scale_y_continuous(limits = c(0, max(20, max(pc_summarized$score)))) +
    # Manually change the palette
    scale_color_brewer(type = "qual", palette = "Dark2") +
    # Flip coords so abilities are on y-axis
    coord_flip() +
    # Flip order of abilities
    scale_x_discrete(limits = rev) +
    # Use a more streamlined theme
    theme_classic() +
    # Input better labels
    labs(x = "Ability", y = "Score", color = "Ability")
  
  # Return the finished diagram
  return(diagram) }
