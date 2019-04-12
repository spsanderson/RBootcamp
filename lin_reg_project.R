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
) +
# Facets
# Statistics
# Coordinates
# Theme
  theme_bw()
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
p2 <- p2 + scale_color_continuous(low = "light blue", high = "orange")
# Print
print(p2)

# What is the correlation between temp and count? 
# Get only numeric columns
num.cols <- sapply(bike, is.numeric)
num.cols
cor.data <- cor(bike[,num.cols])
cor.data
corrplot(cor.data)

cor(bike$temp, bike$count)
cor(bike[,c("temp","count")])

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

# Create an "hour" column that takes the hour from the datetime column. 
# You'll probably need to apply some function to the entire datetime column and reassign it.
bike$hour <- format(bike$datetime, "%H")
bike$hour <- sapply(bike$datetime, function(x){format(x,"%H")})
# Now create a scatterplot of count versus hour, with color scale based on temp. 
# Only use bike data where workingday==1.
# Optional Additions:
# Use the additional layer: 
# scale_color_gradientn(colors=c('color1',color2,etc..)) 
# where the colors argument is a vector gradient of colors you choose, not just high and low.
# Use position=position_jitter(w=1, h=0) inside of geom_point() and check out what it does.

# Data and AES
p3 <- bike %>%
  filter(workingday == 1) %>%
  ggplot(
  aes(
    x = hour
    , y = count
  )
) +
# Geometries
  geom_point(
    aes(
      color = temp
      , alpha = 0.5
    )
    #, position = position_jitter(w = 1, h = 0)
    , position = position_jitterdodge()
  ) +
# Facets
# Statistics
# Coordinates
# Themes
  scale_color_gradientn(colors = c('dark blue', "blue", 'light blue', "green", 'light green','orange','yellow',"red"))
# Print
print(p3)

# Data and AES - non-working days
p4 <- bike %>%
  filter(workingday != 1) %>%
  ggplot(
    aes(
      x = hour
      , y = count
    )
  ) +
  # Geometries
  geom_point(
    aes(
      color = temp
    )
    , position = position_jitter(w = 1, h = 0)
  ) +
  # Facets
  # Statistics
  # Coordinates
  # Themes
  scale_color_gradientn(colors = c("blue","green","red"))
# Print
print(p4)

# Linear model based soley on temperature data
temp.model = lm(count ~ temp, data = bike)
summary(temp.model)
plot(temp.model)

6.0462 + 9.1705*25
predict(temp.model, newdata = data.frame(temp = 25))

# Use sapply() and as.numeric to change the hour column to a column of numeric values.
bike$hour.numeric <- sapply(bike$hour, FUN = as.numeric)

# multi model
lm.bike <- lm(
  count ~ season
  + holiday
  + workingday
  + weather
  + temp
  + humidity
  + windspeed
  + factor(hour)
  , data = bike
)
summary(lm.bike)
plot(lm.bike)
