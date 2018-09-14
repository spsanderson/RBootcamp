# Money Ball Capstone
# Lib Load ####
library(dplyr)
library(ggplot2)
library(funModeling)

# Get File ####
file.to.load <- file.choose(new = T)
batting <- read.csv(file.to.load)

df_status(batting)
profiling_num(batting)
describe(batting)
#rm(file.to.load)

# look at data
head(batting)
str(batting)
head(batting$AB, 5)
head(batting$X2B, 5)

# Feature Engineering ####
# Add Batting Average
batting$BA <- batting$H / batting$AB
batting %>%
  filter(AB > 0) %>%
  mutate(BA2 = H / AB)
  
tail(batting$BA)

head(batting)

 batting$OBP <- ( batting$H + batting$BB + batting$HBP ) / 
  ( batting$AB + batting$BB + batting$HBP + batting$SF )
head(batting$OBP)

batting$X1B <- (batting$H - batting$X2B - batting$X3B - batting$HR)
batting$SLG <- (batting$X1B + (2 * batting$X2B) + (3 * batting$X3B) + 
                  (4 * batting$HR))/batting$AB
head(batting$SLG)
profiling_num(batting$SLG)
hist(batting$SLG)

str(batting)

file.to.load <- file.choose(new = T)
salary.data <- read.csv(file.to.load)
rm(file.to.load)

batting.1985 <- batting %>%
  filter(yearID >= 1985)
min(batting.1985$yearID)

merged.data <- merge(
  x = batting.1985
  , y = salary.data
  , by = c("playerID", "yearID")
)
head(merged.data, 2)

summary(merged.data)

lost.players <- subset(
  merged.data
  , playerID %in% c('giambja01','damonjo01','saenzol01')
  )
unique(lost.players$playerID)

# or use filter() 
lost.players.2 <- merged.data %>%
  filter(playerID %in% c(
    'giambja01','damonjo01','saenzol01'
  )
)
unique(lost.players.2$playerID)

lost.players.2001 <- subset(lost.players, lost.players$yearID == 2001)
# or
lost.players.2001.2 <- lost.players %>%
  filter(yearID == 2001)

nrow(lost.players.2001)
nrow(lost.players.2001.2)
