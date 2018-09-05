library(ggplot2)
library(plotly)

# Data & Aesthetics
pl <- ggplot(
  data = mtcars
  , aes(
    x = mpg
    , y = wt
  )
) 

# Geometries
pl <- pl +
  geom_point()

# Facets
# Stats
# Coordinates
# Theme
# Print Graph
pl

gpl <- ggplotly(pl)
gpl
