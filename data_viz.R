# Data Visualization
library(ggplot2)
library(ggplot2movies)

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

