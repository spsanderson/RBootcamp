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

