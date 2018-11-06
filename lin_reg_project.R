# Linear Regression Project

# Lib Load ####
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrplot)
library(corrgram)

# Get file to use ####
file.to.use <- file.choose(new = T)
bike <- read.csv(file.to.use)
head(bike, 5)

# Our target is obviously bike$count

# EDA ####
# Data and Aestetics
temp_plot <- ggplot(
  data = bike
  , aes(
    x = temp
    , y = count
    )
  )
# Geometries
temp_plot <- temp_plot + geom_point(
  aes(
    color = temp
  )
  , alpha = 0.3
)
# Facets
# Statistics
# Coordinates
# Theme
# Print
print(temp_plot)


# Plot count versus datetime as a scatterplot with a color gradient based 
# on temperature. You'll need to convert the datetime column into POSIXct 
# before plotting.
bike$datetime <- as.POSIXct(bike$datetime)
class(bike$datetime)

# Data and Aestetics
p2 <- ggplot(
  data = bike
  , aes(
    x = datetime
    , y = count
  )
)
# Geometries
p2 <- p2 + geom_point(
  aes(
    color = temp
  )
)
# Facets
# Statistics
# Coordinates
# Theme
p2 <- p2 + scale_color_gradient(low = "light blue", high = "orange")
# Print
print(p2)

# What is the correlation between temp and count? 
# Get only numeric columns
num.cols <- sapply(bike, is.numeric)
num.cols
cor.data <- cor(bike[,num.cols])
cor.data

corrplot(cor.data)
cor.p.test.bike <- cor.mtest(cor.data)
corrplot(cor.p.test.bike[["p"]])

# Let's explore the season data. Create a boxplot, with the y axis 
# indicating count and the x axis begin a box for each season.
# Data and Aestetics
bp1 <- ggplot(
  data = bike
  , aes(
    x = factor(season)
    , y = count
  )
  , group(season)
)
# Geometries
bp1 <- bp1 + geom_boxplot(
  aes(
    color = factor(season)
  )
)
# Facets
# Statistics
# Coordinates
# Themes
# Print
print(bp1)
