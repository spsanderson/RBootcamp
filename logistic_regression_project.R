# Lib Load ####
library(tidyverse)
library(Amelia)
library(funModeling)
library(DataExplorer)
library(esquisse)
library(caTools)
library(ROCR)

# Get File ####
adult <- read.csv(file.choose(new = T))
adult %>% glimpse()
head(adult, 5)

# Lets drop the column X as it is a secondary index
adult <- adult %>%
  select(-X)

# View Data ####
head(adult, 1)
str(adult)
summary(adult)
plot_missing(adult)
create_report(adult)
table(adult$type_employer)

# combine never-worked and without-pay since they are essentially the same thing call uemp
adult$type_employer_clean <- NA

job.reclass.func <- function(job) {
  job <- as.character(job)
  if(job == 'Never-worked' | job == 'Without-pay') {
    return('Unemp')
  } else if(job == 'Self-emp-inc' | job == 'Self-emp-not-inc'){
    return('Self')
  } else {
    return(job)
  }
}
adult$type_employer_clean <- sapply(adult$type_employer, job.reclass.func)
table(adult$type_employer_clean)

# dplyr pipped version
adult <- adult %>%
  mutate(
    type_employer_dplyr = ifelse(
      (type_employer == 'Never-worked' | type_employer == 'Without-pay')
      , 'Unemp'
      , ifelse(
        (type_employer == 'Self-emp-inc' | type_employer == 'Self-emp-not-inc')
        , 'Self'
        , as.character(type_employer)
      )
    )
  )

# reslect columns
adult <- adult %>%
  select(
    -type_employer, -type_employer_dplyr
  )

# The assignment says to group govt jobs, i'm not quite sure about this, lets lookk
# at age and income
adult %>%
  filter(
    type_employer_clean == 'State-gov' | 
      type_employer_clean == 'Local-gov' | 
      type_employer_clean == 'Federal-gov'
  ) %>%
  ggplot(
    aes(
      x = type_employer_clean
      , y = age
      , fill = income
    )
  ) +
  geom_boxplot(
    outlier.colour = 'red'
  ) +
  labs(
    title = "Boxplot Government Emplyment Type by Income Level and Gender",
    x = "Government Employer Type",
    y = "Age",
    fill = "Govt Type"
    ) +
  theme_bw() +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  facet_wrap(vars(sex))
# The average ages above are not significantly different from each group of government employer type
# so it should be ok to reduce these groups into Government employee group state and local
# write a function to do this and do this via a piped dplyr method
govt.emp.reclass.func <- function(job){
  job <- as.character(job)
  if(job == 'State-gov' | job == 'Local-gov') {
    return('SL-gov')
  } else {
    return(job)
  }
}

adult$type_emp_govt <- sapply(adult$type_employer_clean, govt.emp.reclass.func)

# dplyr style
adult <- adult %>%
  mutate(
    type_employer_dplyr = ifelse(
      (
        type_employer_clean == 'State-gov' | 
        type_employer_clean == 'Local-gov' 
      )
      , 'SL-gov'
      , as.character(type_employer_clean)
      )
    )

# Since all look good we can make adult$type_employer equal to type_employer_clean
adult$type_employer <- NA
adult$type_employer <- adult$type_emp_govt

# reslect data frame
adult <- adult %>%
  select(-type_employer_clean, -type_emp_govt, -type_employer_dplyr)

# Marital Status ####
# Look at marital status and pair it down
table(adult$marital)
# reduce to 
# Married
# Not-Married
# Never-Married
marital.reclass.func <- function(marital){
  marital <- as.character(marital)
  if(
    marital == 'Married-AF-spouse' |
    marital == 'Married-civ-spouse' |
    marital == 'Married-spouse-absent'
  ){
    return('Married')
  } else if (
    marital == 'Divorced' |
    marital == 'Separated' |
    marital == 'Widowed'
  ) {
    return('Not-Married')
  } else {
    return(marital)
  }
}
adult$marital_clean <- sapply(adult$marital, marital.reclass.func)
adult$marital <- adult$marital_clean
adult <- adult %>%
  select(-marital_clean)

# Country Check ####
table(adult$country)
unique(adult$country)

# going to gruop by continent
country.reclass.func <- function(country) {
  country <- as.character(country)
  if(
    country == 'United-States' |
    country == 'Honduras' |
    country == 'Dominican-Republic' |
    country == 'Outlying-US(Guam-USVI-etc)' |
    country == 'Cuba' |
    country == 'Mexico' |
    country == 'El-Salvador' |
    country == 'Jamaica' |
    country == 'Canada' |
    country == 'Haiti' |
    country == 'Puerto-Rico' |
    country == 'Guatemala' |
    country == 'Nicaragua'
  ) {
    return('North-America')
  } else if (
    country == 'Iran' |
    country == 'Laos' |
    country == 'China' |
    country == 'Philippines' |
    country == 'Cambodia' |
    country == 'Taiwan' |
    country == 'Japan' |
    country == 'Vietnam' |
    country == 'Thailand' |
    country == 'Hong' |
    country == 'India'
  ) {
    return('Asia')
  } else if (
    country == 'Columbia' |
    country == 'South' |
    country == 'Trinadad&Tobago' |
    country == 'Ecuador' |
    country == 'Peru'
  ) {
    return('South-America')
  } else if (
    country == 'Hungary' |
    country == 'England' |
    country == 'Scotland' |
    country == 'Holand-Netherlands' |
    country == 'Italy' |
    country == 'France' |
    country == 'Yugoslavia' |
    country == 'Germany' |
    country == 'Poland' |
    country == 'Greece' |
    country == 'Ireland'
  ) {
    return('Europe')
  } else if(
    country == 'Portugal'
  ) {
    return('Africa')
  } else {
    return('Unclassified')
  }
}

# reclass country to continent
adult$continent <- sapply(adult$country, country.reclass.func)

adult %>% select(
  country, continent
) %>%
  distinct_all() %>%
  arrange(continent)

# make reclassed columns factors
str(adult)
adult$marital <- factor(adult$marital)
adult$type_employer <- factor(adult$type_employer)
adult$continent <- factor(adult$continent)
str(adult)

# drop country from data frame and leave continent
adult <- adult %>%
  select(-country)
str(adult)

Amelia::missmap(adult)
plot_missing(adult)

# Viz EDA ####
# Use ggplot2 to create a histogram of ages, colored by income
# Data and AES
adult %>%
  ggplot(
    aes(
      x = age
      , fill = income
      )
    ) +
  # Geometries
  geom_histogram(
    color = "black"
    , binwidth = 1
    ) +
  labs(
    title = "Histogram of Age"
    , x = "Age"
    , y = "Count"
    , fill = "Income"
    ) +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  theme_bw()

# Plot a histogram of hours worked per week
# Data and AES
adult %>%
  ggplot(
    aes(
      x = hr_per_week
      , fill = income
    )
  ) +
  # Geometries
  geom_histogram(
    color = "black"
    , binwidth = 5
  ) +
  # Facets
  # Statistics
  # Coordinates
  # Theme
  theme(
    legend.background = element_blank()
    , legend.key = element_blank()
  ) +
  labs(
    title = "Histogram of Hours Worked Per Week"
    , y = "Count"
    , x = "Hours Worked per Week"
    , fill = "Income"
  ) + 
  theme_bw()

# Create a barplot of region with the fill color defined by income class. 
# Optional: Figure out how rotate the x axis text for readability
adult %>%
  group_by(continent, income) %>%
  summarise(inc_n = n()) %>%
  # data and aes
  ggplot(
    aes(
      x = reorder(continent, -inc_n)
      , y = inc_n
      , fill = income
    )
  ) +
  # Geometries
  geom_bar(
    color = 'black'
    , stat = 'identity'
  ) +
  # Facets
  # Statistics
  # Coordinates
  # Theme
  labs(
    title = "Barplot of Counts by Continent"
    , x = ""
    , y = ""
    , fill = 'Income'
  ) +
  theme(
    legend.background = element_blank()
    , legend.key = element_blank()
    , axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)
  )

 # Build Logit Model ####
# Split adult into train and test with a 70/30 split
# check head
head(adult, 5)
set.seed(101)

# Split 
split <- sample.split(adult$income, SplitRatio = 0.7)
train <- subset(adult, split == T)
test <- subset(adult, split == F)

# Training model
train.log.mod <- glm(
  formula = income ~ . #-education_num -occupation -continent -fnlwgt
  , family = binomial(link = 'logit')
  # , weights = fnlwgt # causes algo to fail convergence possible to overfit, perfect separation
  , data = train
  )
summary(train.log.mod)
anova(train.log.mod)

# use step() on train.log.mod
train.log.mod.stp <- step(train.log.mod)
summary(train.log.mod)

# Train Confusion Matrix ####
test$predicted.income <- predict(train.log.mod.stp, newdata = test, type = 'response')
conf.mat <- as.matrix(table(test$income, test$predicted.income > 0.5))
model.acc <- (conf.mat[1,1]+conf.mat[2,2])/sum(conf.mat)
model.recall <- conf.mat[1,1]/(conf.mat[1,1]+conf.mat[1,2])
model.precision <-  conf.mat[1,1]/(conf.mat[1,1]+conf.mat[2,1])

# Use MLR ####
library(mlr)
library(rJava)
# Make train and test tasks
trainTask <- makeClassifTask(data = train, target = "income")
testTask <- makeClassifTask(data = test, target = "income")

# Check trainTask and testTakes
trainTask
testTask

# normalize the data
trainTask <- normalizeFeatures(trainTask, method = 'standardize')
testTask <- normalizeFeatures(testTask, method = 'standardize')

# Feature importance
lm.feat <- generateFilterValuesData(
  trainTask
  , method = c(
    "information.gain"
    , 'chi.squared'
  )
)
plotFilterValues(lm.feat)

# Logit mlr mode ####
logistic.learner <- makeLearner('classif.logreg', predict.type = 'response')

# cross validate
cv.logistic <- crossval(
  learner = logistic.learner
  , task = trainTask
  , iters = ncol(train)
  , stratify = T
  , measures = acc
  , show.info = T
)

cv.logistic$aggr
cv.logistic$measures.test

# train model
fmodel <- train(logistic.learner, trainTask)
getLearnerModel(fmodel)

# predict on test
fpmodel <- predict(fmodel, testTask)

# create submission fiel
fpmodel$data$response
submit <- data.frame(
  fpmodel$data
)
head(submit)
table(submit$truth, submit$response)

# mlr logit confustion matrix ####
mlr.mat <- as.matrix(table(submit$truth, submit$response))
print(mlr.mat)
mlr.model.acc <- (mlr.mat[1,1] + mlr.mat[2,2])/sum(mlr.mat)
mlr.model.recall <- mlr.mat[1,1]/(mlr.mat[1,1] + mlr.mat[1,2])
mlr.model.precision <-  mlr.mat[1,1]/(mlr.mat[1,1] + mlr.mat[2,1])
