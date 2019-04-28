# Lib Load ####
install.load::install_load(
  "rpart"
  , "rpart.plot"
  , "esquisse"
  , "DataExplorer"
  , "tidyverse"
  , "mlr"
  , "randomForest"
  , "ISLR" # for the college df
  , "caTools"
)

# Data ####
df <- College
str(df)
head(df, 5)
plot_missing(df)
create_report(df)

# EDA ####
esquisser()

df %>% ggplot(
  aes(
    x = Room.Board
    , y = Grad.Rate
    , color = Private
  )
) +
  geom_point() +
  labs(
    title = "Graduation Rate vs. Room and Board"
    , subtitle = "Colored by Private Yes/No"
    , x = "Room and Board"
    , y = "Graduation Rate"
    ) +
  theme_bw()

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