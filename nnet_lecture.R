# Lib Load ####
install.load::install_load(
  "MASS"
  , "caTools"
  , "neuralnet"
  , "ggplot2"
)
head(Boston)
str(Boston)

# Make var df ####
df <- Boston

# when training nnet it is good to scale data
maxs <- apply(df, MARGIN = 2, max)
mins <- apply(df, MARGIN = 2, min)              
scaled.data <- scale(df, center = mins, scale = maxs - mins)
scaled.data <- as.data.frame(scaled.data)
head(scaled.data,1)
head(Boston,1)

# Train/Test ####
split <- sample.split(scaled.data$medv, SplitRatio = 0.7)
train <- subset(scaled.data, split == T)
test <- subset(scaled.data, split == F)
head(train, 1)
head(test, 1)

# Make nnet ####
n <- colnames(train)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))

# Train nnet ####
nn <- neuralnet(f, data = train, hidden = c(length(train) - 1, length(train) / 2), linear.output = T)
plot(nn)

# Predictions ####
predicted.nn.values <- compute(nn, test %>% dplyr::select(-medv))
str(predicted.nn.values)

true.predictions <- predicted.nn.values$net.result * (max(df$medv) - min(df$medv)) + min(df$medv)
test.r <- (test$medv) * (max(df$medv) - min(df$medv)) + min(df$medv)
MSE.nn <- sum((test.r - true.predictions)^2) / nrow(test)
MSE.nn

error.df <- data.frame(test.r, true.predictions)
head(error.df)

error.df %>%
  ggplot(
    aes(
      x = test.r
      , y = true.predictions
    )
  ) + 
  geom_point() + 
  stat_smooth()
