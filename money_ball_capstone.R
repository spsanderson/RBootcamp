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
rm(file.to.load)

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

lost.players.df <- lost.players.2001 %>%
  select(
    playerID
    , H
    , X2B
    , X3B
    , HR
    , OBP
    , SLG
    , BA
    , AB
  )
describe(lost.players.df)

replacement.players.df <- merged.data %>%
  filter(
    yearID == 2001
  )
nrow(replacement.players.df)
head(replacement.players.df, 1)

max.salary <- sum(lost.players.2001[,'salary'])
max.salary

max.sal <- max(lost.players.2001$salary * 0.85)
max.sal

min.obp <- sum(lost.players.2001$OBP)
min.obp

min.ab <- sum(lost.players.2001$AB)
min.ab

dfa <- replacement.players.df %>%
  filter(salary <= max.sal, OBP >= (min.obp/3), AB >= (min.ab/3))
head(dfa)

ggplot(
  data = dfa
  , aes(
    x = OBP
    , y = salary
  )
) +
  geom_point()

possible.players <- dfa[, c("playerID", "OBP", "salary","AB")]
head(arrange(possible.players, desc(OBP)), 5)
possible.players$AB_Sal <- possible.players$salary/possible.players$AB
plot(possible.players$AB_Sal)
possible.players$AB_Sal_OBP <- (possible.players$salary/possible.players$AB)*possible.players$OBP
plot(possible.players$AB_Sal_OBP)
head(arrange(possible.players, desc(OBP)), 5)
head(arrange(possible.players, desc(AB_Sal)), 5)
head(arrange(possible.players, desc(AB_Sal_OBP)), 5)
nrow(possible.players)
