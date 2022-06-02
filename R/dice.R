#' @title Roll a Four-Sided Dice ("d4")
#'
#' @description Picks a random number from 1-4
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d4 <- function(){
  base::sample(x = 1:4, size = 1)
}

#' @title Roll a Six-Sided Dice ("d6")
#'
#' @description Picks a random number from 1-6
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d6 <- function(){
  base::sample(x = 1:6, size = 1)
}

#' @title Roll an Eight-Sided Dice ("d8")
#'
#' @description Picks a random number from 1-8
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d8 <- function(){
  base::sample(x = 1:8, size = 1)
}

#' @title Roll a Ten-Sided Dice ("d10")
#'
#' @description Picks a random number from 1-10
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d10 <- function(){
  base::sample(x = 1:10, size = 1)
}

#' @title Roll a Twelve-Sided Dice ("d12")
#'
#' @description Picks a random number from 1-12
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d12 <- function(){
  base::sample(x = 1:12, size = 1)
}

#' @title Roll a Twenty-Sided Dice ("d20")
#'
#' @description Picks a random number from 1-20
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d20 <- function(){
  base::sample(x = 1:20, size = 1)
}

#' @title Roll a One Hundred-Sided Dice ("d100")
#'
#' @description Picks a random number from 1-100
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d100 <- function(){
  base::sample(x = 1:100, size = 1)
}

#' @title Flip a Coin
#'
#' @description Picks a random number from 1-2. Essentially a "d2".
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
coin <- function(){
  base::sample(x = 1:2, size = 1)
}

#' @title Roll a Two-Sided Dice
#'
#' @description Picks a random number from 1-2. Essentially flips a coin.
#'
#' @return Numeric, the specified dice outcome
#' @export
#'
d2 <- function(){
  base::sample(x = 1:2, size = 1)
}

