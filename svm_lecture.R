# Lib Load ####
install.load::install_load(
  "ISLR"
  , "e1071"
)

# Data ####
head(iris)

# Model ####
model <- svm(Species ~ ., data=iris)
summary(model)

# Prediction
predicted.values <- predict(model, data = iris[-Species])
table(predicted.values,iris[,5])

# Tune for combos of gamma 0.5,1,2
# and costs 1/10 , 10 , 100
tune.results <- tune(svm,train.x=iris[1:4],train.y=iris[,5],kernel='radial',
                     ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
summary(tune.results)

tuned.svm <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5)
summary(tuned.svm)

tuned.predicted.values <- predict(tuned.svm,iris[1:4])
table(tuned.predicted.values,iris[,5])
