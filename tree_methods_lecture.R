# Lib Load ####
install.load::install_load(
  "rpart"
  , "rpart.plot"
  , "esquisse"
  , "DataExplorer"
  , "tidyverse"
  , "mlr"
  , "randomForest"
)

# Use the Kyphosis data set
df <- rpart::kyphosis
str(df)
glimpse(df)
plot_missing(df)
create_report(df)

# Make Tree ####
tree <- rpart(Kyphosis ~ ., method = "class", data = df)
printcp(tree)
plotcp(tree)
rsq.rpart(tree)
print(tree)
summary(tree)
prp(tree)

# Random Forest Model ####
rf <- randomForest(Kyphosis ~ ., data = df)
print(rf)
importance(rf)

