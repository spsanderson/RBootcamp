library(ggplot2)
library(ggthemes)
# Histogram of hwy mpg values
df <- mpg
head(df)

# Data & Asetitics
hplot <- ggplot(
  data = df
  , aes(
    x = hwy
  )
)
# Geometries
hplot <- hplot +
  geom_histogram(
    binwidth = 1
    , fill = "pink"
  )
# Facets
# Stats
# Coordinates
# Themes
# Print Graph
hplot

# Data & Aestetics
# Barplot of car counts per manufacturer with color fill defined by cyl count
bplot <- ggplot(
  data = df
  , aes(
    x = manufacturer
  )
)
# Geometries
bplot <- bplot +
  geom_bar(
    aes(
      fill = factor(cyl)
    )
  )
# Facets
# Stats
# Coordinates
# Themes
# Print graph
bplot

# Data & Aestetics
df2 <- txhousing
# Create a scatterplot of volume versus sales. Afterwards play around with 
# alpha and color arguments to clarify information
scplot <- ggplot(
  data = df2
  , aes(
    x = sales
    , y = volume
  )
)
# Geometries
scplot <- scplot +
  geom_point(
    color = "blue"
    , alpha = 0.4
  )
# Facets
# Stats
# Coordinates
# Themes
# Print graph
scplot

# Data & Aestetics
scsmoothplot <- ggplot(
  data = df2
  , aes(
    x = sales
    , y = volume
  )
)
# Geometries
scsmoothplot <- scsmoothplot +
  geom_point(
    color = "blue"
    , alpha = 0.4
  )
# Facets
# Stats
scsmoothplot <- scsmoothplot +
  geom_smooth(
    aes(
      color = "red"
    )
    , se = F
  )
# Coordinates
# Themes
# Print Graph
scsmoothplot

# Data & Aesthetics
# Geometries
# Facets
# Stats
# Coordinates
# Themes
# Print Graph