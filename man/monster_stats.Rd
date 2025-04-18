% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monster_stats.R
\name{monster_stats}
\alias{monster_stats}
\title{Quickly Identify Monster Statistics}
\usage{
monster_stats(xp = NULL, cr = NULL)
}
\arguments{
\item{xp}{(numeric) experience point (XP) value of the monster}

\item{cr}{(numeric) challenge rating (CR) of the monster. Note that this is NOT necessary if XP is provided}
}
\value{
(dataframe) two columns and eight rows
}
\description{
Quickly identify the vital statistics of a single creature worth the provided experience points (XP) or Challenge Rating (CR). Uses the table provided in p. 274-275 of the Dungeon Master's Guide. Accepts Challenge Ratings of 0, '1/8', '1/4, and '1/2' in addition to numbers between 1 and 30. CR is *not necessary* to provide **if** XP is provided.
}
\examples{
# Identify monster statistics for a known challenge rating
dndR::monster_stats(cr = 4)

# Or XP value
dndR::monster_stats(xp = 2800)

}
