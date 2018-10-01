# Lin Reg Lecture ####
# Read in data ####
File.To.Choose <- file.choose(new = T)
df <- read.csv(File.To.Choose, sep = ';')
rm(File.To.Choose)

# df str ####
head(df, 2)
str(df)
summary(df)

# Check for NA's ####
any(is.na(df))

# Lib Load ####
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrplot)
library(corrgram)

# Correlation ####
num.cols <- sapply(df, is.numeric)
head(num.cols)

# Get numeric data for correlations
cor.data <- cor(df[,num.cols])
cor.data

corrplot(cor.data)
corrplot(cor.data, method = 'color')
corrplot(cor.data, method = 'circle')
corrplot(cor.data, method = 'pie')
cor.p.test <- cor.mtest(cor.data)
corrplot(cor.p.test[["p"]])
corrplot(cor.p.test[["p"]], method = 'pie')

corrgram(df)
corrgram(
  df
  , order = T
  , lower.panel = panel.shade
  , upper.panel = panel.pie
  , text.panel = panel.txt
)

ggplot(df, aes(x = G3)) +
  geom_histogram(
    bins = 20
    , alpha = 0.5
    , fill = 'blue'
  )

# Build a model ####
library(caTools) # to slipt into test/train data
# Set a seed
set.seed(101)
# Split sample
sample <- sample.split(df$G3, SplitRatio = 0.7)
# Train
train <- subset(df, sample == TRUE)
# Test
test <- subset(df, sample == FALSE)
# Build Model on Training data
model <- lm(G3 ~., data = train) # all features
print(summary(model))
# Residuals
res <- residuals(model)
res <- as.data.frame(res)
head(res, 5)
ggplot(data = res, aes(res)) +
  geom_histogram(
    fill = 'blue'
    , alpha = 0.5
  )
