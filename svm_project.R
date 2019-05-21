# Lib Load ####
install.load::install_load(
  "e1071"
  , "ggplot2"
  , "dplyr"
  , "esquisse"
)

# Get file ####
loans <- read.csv(file.choose(new = T))
str(loans)
summary(loans)

# Feature Engineer ####
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
loans$credit.policy <- factor(loans$credit.policy)

# EDA ####
# Create a histogram of fico scores colored by not.fully.paid
esquisser()
library(ggplot2)

loans %>% ggplot(
  aes(
    x = fico
    , fill = not.fully.paid
    )
  ) +
  geom_histogram(
    binwidth = 5
    , color = "black"
    ) +
  labs(
    title = "FICO Histogram",
    x = "FICO",
    y = "Count",
    subtitle = "Color by Not Fully Paid"
    ) +
  theme_bw()

loans %>% ggplot(
  aes(
    x = fico
    , fill = not.fully.paid
  )
) +
  geom_density(
    alpha = 0.5
  ) +
  labs(
    title = "FICO Density Plot"
    , x = "FICO"
    , y = "Density"
    , subtitle = "Color by Not Fully Paid"
  ) +
  theme_bw()

# Create a barplot of purpose counts, colored by not.fully.paid. Use position=dodge in the geom_bar argument
loans %>% ggplot(
  aes(
    x = purpose
    , fill = not.fully.paid
  )
) +
  geom_bar(
    position = "dodge"
    ) +
  labs(
    title = "FICO Bar Plot"
    , x = "Purpose of Loan"
    , y = "Count"
    , subtitle = "Colored by Not Fully Paid"
  ) +
  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1))

# Data and AES
loans %>% ggplot(
  aes(
    x = fico
    , y = int.rate
    #, fill = as.factor(not.fully.paid)
  )
) +
# Geometries
geom_point(
  aes(
    color = not.fully.paid
  )
  , alpha = 0.5
  , position = position_jitter()
) +
# Statistics
# Facets
# Themes
  labs(
    title = "FICO vs Interest Rate Paid"
    , subtitle = "Colored by Not Fully Paid"
    , x = "FICO"
    , y = "Interest Rate"
    , fill = "Not Fully Paid"
  ) +
  theme_minimal()
# Print

# Split Data ####
set.seed(seed = 101)
loansplit <- caTools::sample.split(loans$not.fully.paid, SplitRatio = 0.7)
train <- subset(loans, loansplit == T)
test <- subset(loans, loansplit == F)

# Model ####
model <- svm(not.fully.paid ~ ., data = train)
summary(model)

pred <- predict(model, newdata = test %>% select(-not.fully.paid))
table(pred, test$not.fully.paid)

# Tune Model ####
tune.model <- tune(
  svm
  , train.x = not.fully.paid ~ .
  , data = train
  , kernel = 'radial'
  , ranges = list(
    cost = c(1, 10)
    , gamma = c(0.01, 1)
    )
  )
summary(tuned.model)
tuned.model <- svm(not.fully.paid ~ ., data = train, cost = 10, gamma = 0.1)
tuned.pred <- predict(tuned.model, newdata = test %>% select(-not.fully.paid))
table(tuned.pred, test$not.fully.paid)
