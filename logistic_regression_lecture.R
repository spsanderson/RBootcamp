# Lib Load ####
library(tidyverse)
library(Amelia)
library(funModeling)
library(DataExplorer)
library(esquisse)
library(caTools)

set.seed(101)

# Get Train File ####
df.train <- read.csv(file.choose(new = T))

df.train %>% glimpse()

# Train Missing Map ####
missmap(
  df.train
  , legend = F
  , col = c("yellow","black")
  , rank.order = T
)

# Impute Train missing Ages ####
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

# Frequencies Train ####
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

# Viz Train ####
# Data and AES
df.train %>%
  ggplot(
    aes(
      x = factor(Pclass)
      , y = Age.Imputed
      , fill = factor(Survived)
    )
  ) +
  # geometries
  geom_boxplot(
    outlier.color = "red"
    , outlier.alpha = 0.4
    ) +
# Facets
  facet_wrap(vars(Sex)) +
# Stats
# Coordinates
# Themes
  labs(
    title = "Survival by Gender and Class"
    , y = ""
    , x = ""
    , fill = "Survival"
    , caption = "Training Data"
  ) +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  theme_bw()

# Age Histogram
# Data and AES
df.train %>%
  ggplot(
    aes(
      x = Age.Imputed
    )
  ) +
  # Geometries
  geom_histogram(
    fill = "light blue"
    , alpha = 0.618
    , color = "black"
    , binwidth = 5
  ) +
  # Facets
  # Stats
  # Coordinates
  # Themes
  theme_bw()

# Data and AES
df.train %>%
  ggplot(
    aes(
      x = Pclass
      , y = Age.Imputed
      , fill = factor(Pclass)
    )
  ) +
# Geometries
  geom_boxplot(
    alpha = 0.5
    , outlier.colour = "red"
  ) +
# Facets
  facet_wrap(Sex ~.) +
# Stats
# Coordinates
# Themes
  theme_bw() +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  labs(
    y = "Age / Imputed Age"
    , x = "Class"
    , fill = "Class"
    , title = "Boxplot of Age / Imputed Age by Fare Class and Gender"
  )

# Train Train Model ####
str(df.train)

# Get rid of some columns
df.train.clean <- select(
  df.train, - Cabin, -PassengerId, -Name, -Ticket, -Age, -avg.age
)
str(df.train.clean)

# Make factors
df.train.clean$Survived <- factor(df.train.clean$Survived)
df.train.clean$Pclass <- factor(df.train.clean$Pclass)
df.train.clean$SibSp <- factor(df.train.clean$SibSp)
df.train.clean$Parch <- factor(df.train.clean$Parch)
str(df.train.clean)

# Train Model
log.model <- glm(
  Survived ~ .
  , family = binomial(link = 'logit')
  , data = df.train.clean
)
summary(log.model)

# Get Test File ####
df.test <- read.csv(file.choose(new = T))
df.test %>% glimpse()

# Test Missing Map ####
missmap(
  df.test
  , legend = F
  , col = c("yellow","black")
  , rank.order = T
)

# Impute Test Missing AGe ####
df.test <- df.test %>%
  group_by(
    Sex, Pclass
  ) %>%
  mutate(
    avg.age = round(mean(Age, na.rm = T), 0)
  )

df.test$Age.Imputed <- ifelse(
  is.na(df.test$Age)
  , df.test$avg.age
  , df.test$Age
)


# Frequencies Train ####
freq(
  data = df.test
  , input = c(
    'Pclass'
    , 'Sex'
    , 'SibSp'
    , 'Parch'
    , 'Embarked'
  )
)

# Viz Test ####
# Age Histogram
# Data and AES
df.test %>%
  ggplot(
    aes(
      x = Age.Imputed
    )
  ) +
  # Geometries
  geom_histogram(
    fill = "light blue"
    , alpha = 0.618
    , color = "black"
    , binwidth = 5
  ) +
  # Facets
  # Stats
  # Coordinates
  # Themes
  theme_bw()

# Data and AES
df.test %>%
  ggplot(
    aes(
      x = Pclass
      , y = Age.Imputed
      , fill = factor(Pclass)
    )
  ) +
  # Geometries
  geom_boxplot(
    alpha = 0.5
    , outlier.colour = "red"
  ) +
  # Facets
  facet_wrap(Sex ~.) +
  # Stats
  # Coordinates
  # Themes
  theme_bw() +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  labs(
    y = "Age / Imputed Age"
    , x = "Class"
    , fill = "Class"
    , title = "Boxplot of Age / Imputed Age by Fare Class and Gender"
  )

# Train Test Model ####
str(df.test)

# Get rid of some columns
df.test.clean <- select(
  df.test, - Cabin, -PassengerId, -Name, -Ticket, -Age, -avg.age
)
str(df.test.clean)

# Make factors
df.test.clean$Pclass <- factor(df.test.clean$Pclass)
df.test.clean$SibSp <- factor(df.test.clean$SibSp)
df.test.clean$Parch <- factor(df.test.clean$Parch)
str(df.test.clean)

split <- sample.split(df.train.clean$Survived, SplitRatio = 0.7)
final.train <- subset(df.train.clean, split == T)
final.test <- subset(df.train.clean, split == F)
final.log.model <- glm(Survived ~ ., family = binomial(link = 'logit'), data = final.train)
summary(final.log.model)

fitted.probabilies <- predict(final.log.model, final.test, type = 'response')
fittled.results <- ifelse(fitted.probabilies >= 0.5, 1 ,0)
misClassError <- mean(fittled.results != final.test$Survived)
print(1 - misClassError)

# Confusion matrix of tuned log model #####
table(final.test$Survived, fitted.probabilies > 0.5)

# Model on Test Data NO Survied Column #####
