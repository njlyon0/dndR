library(dplyr)
# Create Character Advancement Table

XP_table <- data.frame(XP = c(0, 300, 900, 2700, 6500, 14000, 23000, 34000,
                              48000, 64000, 85000, 100000, 120000, 140000,
                              165000, 195000, 225000, 265000, 305000, 355000),
                       Level = seq(1:20),
                       Proficiency = rep(c("+2", "+3", "+4", "+5", "+6"), each = 4))

XP_table
XP_value <- 1000


filter(XP_table, XP <= XP_value) %>%
  utils::tail(x = ., n = 1)

# Create Level Calculator function

level.calc <- function(XP){

  if(is.numeric(XP) == TRUE){

    for (i in 1:length(XP_table$XP)) {

      if (XP <= XP_table$XP[i]){

        print(paste("Level", max(XP_table$Level[XP_table$XP <= XP]), sep = " "))

        break

      }else{

        if (XP > XP_table$XP[20]){

          print("Level 20")

          break
        }
      }
    }

  }else{

    stop("XP must be numeric")

  }
}

level.calc(XP = 100)

