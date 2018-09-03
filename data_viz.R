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
rm(list = ls())
# Data & Aesthetics
mplot <- ggplot(
  data = movies
  , aes(
    x = year
    , y = rating
  )
)
# Geometries
mplot <- mplot +
  geom_bin2d(
    binwidth = c(3, 1)
  )

mplot <- mplot +
  geom_hex()

mplot <- mplot + 
  geom_density2d()
# Facets
# Stats
# Coordinates
# Theme
mplot <- mplot +
  scale_fill_gradient(
    high = "red"
    , low = "blue"
  )
# Print Graph
mplot

# Coordinates & Facets ####
rm(list = ls())
df <- mpg
# Data & Aestetics
pl <- ggplot(
  data = df
  , aes(
    x = displ
    , y = hwy
  )
)
# Geometries
pl <- pl +
  geom_point()
# Facets
# Stats
# Coordinates
pl <- pl +
  coord_cartesian(
    xlim = c(1, 4)
    , ylim = c(15, 30)
  )

pl <- pl +
  coord_fixed(
    ratio = 1/1
  )
# Theme
# Print Graph
pl

# Data & Aestetics
pl <- ggplot(
  data = df
  , aes(
    x = displ
    , y = hwy
  )
)
# Geometries
pl <- pl +
  geom_point()
# Facets
pl <- pl +
  facet_grid(
    . ~ cyl
  )

pl <- pl +
  facet_grid(
    drv ~ .
  )

pl <- pl +
  facet_grid(
    drv ~ cyl
  )
# Stats
# Coordinates
# Theme
# Print Graph
pl

# Themes ####
library(ggthemes)

rm(list = ls())

df <- mtcars
# Data & Astheticss
pl <- ggplot(
  data = df
  , aes(
    x = wt
    , y = mpg
  )
)
# Geometries
pl <- pl +
  geom_point()
# Facets
# Stats
# Coordinates
# Theme
pl <- pl +
  theme_excel()
# Print Graph
pl
