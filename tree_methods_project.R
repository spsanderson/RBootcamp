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

df %>% ggplot(
  aes(
    x = F.Undergrad
    , fill = Private
    )
  ) +
  geom_histogram(
    bins = 30
    , color = "black"
    , alpha = 0.5
    ) +
  labs(
    title = "Histogram of Full Time Undergrad"
    , x = "Full Time Undergrad"
    , y = "Count"
    , subtitle = "Filled by Private Yes/No"
    , fill = "Private"
    ) +
  theme_bw()

df %>% ggplot(
  aes(
    x = Grad.Rate
    , fill = Private
    )
  ) +
  geom_histogram(
    bins = 30
    , alpha = 0.5
    , color = "black"
    ) +
  labs(
    title = "Histogram of Graduation Rate"
    , x = "Graduation Rate"
    , y = "Count"
    , subtitle = "Fill by Private Yes/No"
    , fill = "Private"
    ) +
  theme_bw()

# Clean Data ####
# If grad.rate is over 100 then make 100
grad.rate.func <- function(rate){
  if_else(
    rate > 100
    , 100
    , rate
  )
}

df$Grad.Rate <- sapply(df$Grad.Rate, grad.rate.func)
# recheck above hist

# Train / Test split ####
split <- sample.split(df$Private, SplitRatio = 0.7)
train.df <- subset(df, split == T)
test.df <- subset(df, split == F)

# Tree Test ####
tree.test <- rpart(Private ~ ., data = train.df, method = "class")
printcp(tree.test)
plotcp(tree.test)
rsq.rpart(tree.test)
print(tree.test)
summary(tree.test)
prp(tree.test)









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