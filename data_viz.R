# Data Visualization
# library load ####
library(ggplot2)
library(ggplot2movies)

# Histogram ####
# Data & Aesthetics
pl <- ggplot(
  data = movies
  , aes(
    x = rating
  )
)

# Geometries
pl <- pl + 
  geom_histogram(
    binwidth = 0.1
    , color = "black"
    , aes(
      fill = ..count..
    )
  )

# Facets
# Statistics
# Coordinates
pl <- pl +
  xlab("Movie Rating") +
  ylab("Count") +
  ggtitle("My Title")

# Theme
# Print graph
pl

df <- mtcars
# Data & Aesthetics
pl <- ggplot(
  data = df
  , aes(
    x = wt
    , y = mpg
  )
)
# Geometries
pl1 <- pl + geom_point(
  size = 3
  , aes(
    color = hp
  )
)
# Facets
# Statistics
# Coordinates
# Theme
pl1 <- pl1 + scale_color_gradient(low = "blue", high = "red")
# Print graph
pl1

# Bar Plots ####
df <- mpg
# Data & Aestetics
pl1 <- ggplot(
  data = df
  , aes(
    x = class
  )
)
# Geometries
pl1 <- pl1 + geom_bar(
  aes(
    fill = drv
  )
  #, position = position_dodge(preserve = "total")
  #, position = "dodge"
  , position = "fill"
)
# Facets
# Statistics
# Coordinates
# Theme
# Print Graph
pl1

# Boxplot ####
rm(list = ls())
df <- mtcars

# Data & Aestetics
bplot <- ggplot(
  data = df
  , aes(
    x = as.factor(cyl)
    , y = mpg
  )
)
# Geometris
bplot <- bplot +
  geom_boxplot(
    aes(
      fill = factor(cyl)
    )
  )
# Facets
# Statistics
# Coordinates
bplot <- bplot +
  coord_flip()
# Theme
# Print Graph
bplot

# Bi-variate plotting ####
