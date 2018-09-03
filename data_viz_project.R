# Data Visualization Project
# Steven Sanderson, MPH
# For 
# https://www.udemy.com/data-science-and-machine-learning-bootcamp-with-r/

# Libraries ####
library(ggplot2)
library(data.table)
library(ggthemes)

# Load data ####
file.to.load <- file.choose(new = TRUE)
df <- fread(file.to.load)
rm(file.to.load)

# Head ####
head(df)

# Plot ####
# Use ggplot() + geom_point() to create a scatter plot object called pl. 
# You will need to specify x=CPI and y=HDI and color=Region as aesthetics 
#
# Change the points to be larger empty circles. (You'll have to go back and add 
# arguments to geom_point() and reassign it to pl.) You'll need to figure 
# out what shape= and size= 
# Data & Aesthetics
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

p1 <- ggplot(
  data = df
  , aes(
    x = CPI
    , y = HDI
    , color = Region
  )
)
# Geometries
p1 <- p1 +
  geom_point(
    shape = 1
    , size = 5
  )

# Facets
# Stats
p1 <- p1 +
  geom_smooth(
    aes(
      group = 1
    )
    , color = "red"
    , se = FALSE
    , method = "lm"
    , formula = y ~ log(x)
  )

# Coordinates
p1 <- p1 +
  geom_text(
    aes(
      label = Country
    )
    , color = "grey20"
    , data = subset(
      df, Country %in% pointsToLabel
    )
    , check_overlap = TRUE
  ) +
  scale_x_continuous(
    name = "Corruptions Perception Index, 2011 (10 = Least Corrupt)"
    , limits = c(1, 10)
    , breaks = 1:10
  ) +
  scale_y_continuous(
    name = "Human Development Index, 2011 (1 = Best)"
    , limits = c(0.2, 1)
  ) +
  ggtitle("Corruption and Human Development")

# Themes
p1 <- p1 +
  theme_economist_white()

# Print Graph
p1
