# Lib Load ####
library(tidyverse)
library(Amelia)
library(funModeling)
library(DataExplorer)
library(esquisse)
library(caTools)

# Get File ####
adult <- read.csv(file.choose(new = T))
adult %>% glimpse()