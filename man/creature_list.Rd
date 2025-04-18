% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/creature_list.R
\name{creature_list}
\alias{creature_list}
\title{List Creatures Based on Criteria}
\usage{
creature_list(
  name = NULL,
  size = NULL,
  type = NULL,
  source = NULL,
  xp = NULL,
  cr = NULL,
  ver = "2014"
)
}
\arguments{
\item{name}{(character) text to look for in creature names}

\item{size}{(character) size(s) of creature}

\item{type}{(character) creature 'type' (e.g., "undead", "elemental", etc.)}

\item{source}{(character) source book/document of creature}

\item{xp}{(character/numeric) experience point (XP) value of creature (note this must be an exact match as opposed to partial matches tolerated by other arguments)}

\item{cr}{(character/numeric) challenge rating (CR) value of creature (note this must be an exact match as opposed to partial matches tolerated by other arguments)}

\item{ver}{(character) which version of fifth edition to use ("2014" or "2024"). Note that only 2014 is supported and entering "2024" will print a warning to that effect}
}
\value{
(dataframe) Up to 23 columns of information with one row per creature(s) that fit(s) the user-specified criteria. Fewer columns are returned when no creatures that fit the criteria have information for a particular category (e.g., if no queried creatures have damage vulnerabilities, that column will be excluded from the results). If no creatures fit the criteria, returns a message to that effect instead of a data object
}
\description{
Query list of fifth edition Dungeons & Dragons creatures (2014 version) based on partial string matches between user inputs and the relevant column of the creature information data table. Currently supports users querying the creature list by creature name, size, type, source document, experience point (XP), and challenge rating (CR). All characters arguments are case-insensitive. XP and CR may be specified as either characters or numbers but match to creature must be exact in either case (rather than partial). Any argument set to `NULL` (the default) will not be used to include/exclude creatures from the returned set of creatures
}
\examples{
# Identify medium undead creatures from the Monster Manual worth 450 XP
dndR::creature_list(type = "undead", size = "medium", source = "monster manual", xp = 450)

}
