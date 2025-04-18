% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/encounter_creator.R
\name{encounter_creator}
\alias{encounter_creator}
\title{Balance a Combat Encounter for Given Party Composition and Difficulty}
\usage{
encounter_creator(
  party_level = NULL,
  party_size = NULL,
  ver = NULL,
  difficulty = NULL,
  max_creatures = NULL,
  try = 5
)
}
\arguments{
\item{party_level}{(numeric) integer indicating the average party level. If all players are the same level, that level is the average party level}

\item{party_size}{(numeric) integer indicating how many player characters (PCs) are in the party}

\item{ver}{(character) which version of fifth edition to use ("2014" or "2024")}

\item{difficulty}{(character) one of a specific set of encounter difficulty level names. If `ver = "2014"`, this must be one of "easy", "medium", "hard", or "deadly" while for `ver = "2024"` it must instead be one of "low", "moderate", or "high"}

\item{max_creatures}{(numeric) _optional_ maximum number of allowed creatures. The 2024 version especially skews towards including more creatures (especially at higher difficulty levels) so this argument allows specifying a maximum number of creatures beyond whatever mathematically-appropriate number this function identifies. This is hopefully a convenience for GMs to not have to run dozens of enemies for higher-level parties. If not specified, then there is no maximum number of creatures in the returned random encounter's XP dataframe}

\item{try}{(numeric) integer indicating the number of attempts to make to maximize encounter XP while remaining beneath the threshold defined by the other parameters}
}
\value{
(dataframe) creature experience point (XP) values as well as the maximum XP for an encounter of the specified difficulty and the realized XP cost of the returned creatures
}
\description{
Identifies set of creature XP values that constitute a balanced encounter of specified difficulty for given party composition information (i.e., average player character level and number of party members). Creature selection is semi-random so re-running this function will return similar but not necessarily identical results. It is not always possible to exactly spend all available XP so the true maximum XP and the realized XP (see `?dndR::xp_pool` and `?dndR::xp_cost`) are both returned in the output for context. This function _will not_ exceed the allowed XP so you may need to alter the party information and/or difficulty arguments in order to return an encounter that meets your needs.
}
\examples{
# Create a hard encounter for a 2-person, 9th level party under the 2014 rules
dndR::encounter_creator(party_level = 9, party_size = 2, ver = "2014", difficulty = "hard")

# Create a moderate encounter for a 4-person, 5th level party in the 2024 version
## And allow no more than 6 creatures
dndR::encounter_creator(party_level = 5, party_size = 4, ver = "2024", 
                        difficulty = "moderate", max_creatures = 6)

}
