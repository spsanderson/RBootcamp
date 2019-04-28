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

# Use MLR ####
# Make train and test tasks
trainTask <- makeClassifTask(data = train, target = "income")
testTask <- makeClassifTask(data = test, target = "income")

# mlr Tree ####
getParamSet("classif.rpart")

# Make learner tree
learner.tree <- makeLearner('classif.rpart', predict.type = 'response')

# make CV
tree.cv <- makeResampleDesc("CV", iters = ncol(df))

# Hyper-parameter search - grid search
tree.gs <- makeParamSet(
  makeIntegerParam('minsplit', lower = 2, upper = 50)
  , makeIntegerParam('minbucket', lower = 2, upper = 50)
  , makeIntegerParam('cp', lower = 0.001, upp = 0.2)
)

# grid search
tree.gs.control <- makeTuneControlGrid()

# tune hyper-parameters
tree.tune <- tuneParams(
  learner = learner.tree
  , resampling = tree.cv
  , task = trainTask
)