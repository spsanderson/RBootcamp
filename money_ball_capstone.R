# Money Ball Capstone
# Lib Load ####
library(dplyr)
library(ggplot2)

# Get File ####
file.to.load <- file.choose(new = T)
batting <- read.csv(file.to.load)
rm(file.to.load)

# look at data
head(batting)
str(batting)
head(batting$AB, 5)
head(batting$X2B, 5)

# Feature Engineering ####
# Add Batting Average
batting$BA <- batting$H / batting$AB
tail(batting$BA)

head(batting)

 batting$OBP <- ( batting$H + batting$BB + batting$HBP ) / 
  ( batting$AB + batting$BB + batting$HBP + batting$SF )
head(batting$OBP)
