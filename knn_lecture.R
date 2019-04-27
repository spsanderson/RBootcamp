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
# Get caravan data
str(Caravan)
summary(Caravan$Purchase)

# Clean data ####
any(is.na(Caravan))

# Varaible standardization
var(Caravan[,1])
var(Caravan[,2])
# clearly standardization is needed
# first save purchase as it's own vector
purchase <- Caravan$Purchase
# Make a standardized data.frame
standardized.caravan <- Caravan %>%
  dplyr::select(-Purchase) %>%
  scale()
ncol(standardized.caravan)
create_report(standardized.caravan)

# Recheck variance
var(standardized.caravan[,1])
var(standardized.caravan[,2])

# Make train and test set
train.index <- 1:round(0.7 * nrow(standardized.caravan), 0)
train.data <- standardized.caravan[train.index, ]
train.purchase <- purchase[train.index]

test.data <- standardized.caravan[-train.index, ]
test.purchase <- purchase[-train.index]

# Use KNN ####
set.seed(101)
predicted.purchase <- knn(
  train.data
  , test.data
  , train.purchase
  , k = 1
)
predicted.purchase.cv <- knn.cv(
  train.data
  , train.purchase
  , k = 1
)
table(predicted.purchase)
table(predicted.purchase.cv)
mean(test.purchase != predicted.purchase)

# Make a for loop to get optimal k value
predicted.purchase <- NULL
error.rate <- NULL

for(i in 1:20){
  set.seed(101)
  predicted.purchase = knn(train.data, test.data, train.purchase, k = i)
  error.rate[i] = mean(test.purchase != predicted.purchase)
}
print(error.rate)
kvalues <- 1:20

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

# New model ####
f.predicted.purchase <- knn(
  train.data
  , test.data
  , train.purchase
  , k = error.df %>% filter(error.rate == min(error.rate)) %>% select(kvalues)
)

table(f.predicted.purchase)
mean(test.purchase != f.predicted.purchase)
