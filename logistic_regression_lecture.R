# Lib Load ####
library(tidyverse)
library(Amelia)
library(funModeling)

# Get File ####
df.train <- read.csv(file.choose(new = T))

df.train %>% glimpse()

# Missing Map ####
missmap(
  df.train
  , legend = T
  , col = c("yellow","black")
  , rank.order = T
)

# Impute missing Ages ####
df.train <- df.train %>%
  group_by(
    Sex, Survived, Pclass
  ) %>%
  mutate(
    avg.age = round(mean(Age, na.rm = T), 0)
  )

df.train$Age.Imputed <- ifelse(
  is.na(df.train$Age)
  , df.train$avg.age
  , df.train$Age
)

# Frequencies ####
freq(
  data = df.train
  , input = c(
    'Survived'
    , 'Pclass'
    , 'Sex'
    , 'SibSp'
    , 'Parch'
    , 'Embarked'
  )
)

# Data and AES
df.train %>%
  ggplot(
    aes(
      x = Sex
      , y = Age
      , fill = factor(Survived)
    )
  ) +
  # geometries
  geom_boxplot(
    outlier.color = "red"
    , outlier.alpha = 0.4
    ) +
# Facets
# Stats
# Coordinates
# Themes
  labs(
    title = "Box-Plot of Age/Sex by Survival"
    , y = ""
    , x = ""
    , fill = "Survival"
  ) +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  )
 
# Age Histogram
df.train %>%
  ggplot(
    aes(
      x = Age.Imputed
    )
  ) +
  geom_histogram(
    fill = "light blue"
    , alpha = 0.618
    , color = "black"
  ) +
  theme_bw()
