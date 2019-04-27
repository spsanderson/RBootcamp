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

train.data <- subset(df.final, split == T)
train.species <- subset(df.final$Species, split == T)
test.data <- subset(df.final, split == F)

create_report(train.data)

# Make KNN ####
set.seed(101)
predicted.species <- knn(
  train.data
  , test.data
  , train.species
  , k = 1
)
