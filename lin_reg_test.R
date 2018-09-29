# Lin Reg Lecture ####

# Read in data ####
File.To.Choose <- file.choose(new = T)
df <- read.csv(File.To.Choose, sep = ';')
rm(File.To.Choose)

# df str ####
head(df, 2)
str(df)
summary(df)

# Check for NA's ####
any(is.na(df))

# Lib Load ####
library(ggplot2)
library(ggthemes)
library(dplyr)

# Correlation ####
num.cols <- sapply(df, is.numeric)
head(num.cols)

# Get numeric data for correlations
cor.data <- cor(df[,num.cols])
cor.data
