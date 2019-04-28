# Lib Load ####
install.load::install_load(
  "ISLR"
  , "DataExplorer"
  , "tidyverse"
  , "funModeling"
  , "DataExplorer"
  , "esquisse"
  , "caTools"
  , "mlr"
  , "rJava"
  , "class"
)

# Get file ####
# use iris dataset
df <- datasets::iris
head(df, 5)
str(df)

# Standardize df
Species <- df$Species
df <- df[, -5]
df.std <- scale(df)
str(df)
var(df.std[,1])
var(df.std[,2])
df.final <- data.frame(df.std, Species)
head(df.final, 2)

# Train / Test Data ####
split <- sample.split(df.final$Species, SplitRatio = 0.7)

train.data <- df.final %>%
  filter(split == T) %>%
  select(-Species)

train.species <- subset(df.final$Species, split == T)

test.data <- df.final %>%
  filter(split == F) %>%
  select(-Species)
test.species <- subset(df.final$Species, split == F)

create_report(train.data)

# Make KNN ####
set.seed(101)
predicted.species <- knn(
  train.data
  , test.data
  , train.species
  , k = 1
)

table(predicted.species)
mean(test.species != predicted.species)

# KNN Elbow ####
predicted.species <- NULL
error.rate <- NULL

for(i in 1:10){
  set.seed(101)
  predicted.species = knn(train.data, test.data, train.species, k = i)
  error.rate[i] = mean(test.species != predicted.species)
}

# Visualize
print(error.rate)
kvalues <- 1:10

error.df <- data.frame(error.rate, kvalues)

# Visualize
# Data and AES
error.df %>% ggplot(
  aes(
    x = kvalues
    , y = error.rate
  )
) +
  # Geometries
  geom_point() +
  geom_line(
    lty = "dotted"
    , color = "red"
    , size = 1
  ) +
  # Statistics
  # Coordinates
  # Facets
  # Theme
  theme_bw() +
  labs(
    title = "KNN Model Error Rate for values of K"
    , subtitle = paste0(
      "Minimum Error rate is: "
      , round(min(error.df$error.rate), 4)
      , " for K = "
      , error.df %>% filter(error.rate == min(error.rate)) %>% select(kvalues)
    )
    , x = "K Values"
    , y = "Error Rate"
  )

# Optional KNN ####
thoracic.df <- foreign::read.arff(file.choose(new = T))
head(thoracic.df)
plot_missing(thoracic.df)

