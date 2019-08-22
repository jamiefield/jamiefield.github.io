## How to set a working directory
  setwd("INSERT YOUR PATH HERE")

## How to import data in RStudio

## Import a .csv file that contains data
  dat <- read.csv("myData.csv", header = TRUE)

## Import a .xlsx file that contains data
  install.packages("xlsx")
  library("xlsx")

  dat1 <- read.xlsx("myData.xlsx", 1, header = TRUE)
