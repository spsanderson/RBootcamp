# Lib Load ####
install.load::install_load(
  "tidyverse"
  , "cluster"
  , "ggplot2"
)

# Get files ####
df1 = read.csv(file.choose(new = T), sep = ";")
df2 = read.csv(file.choose(new = T), sep = ";")

# Add lable columns to both df 
df1$label <- 'Red'
df2$label <- 'White'

# head data.frames
head(df1)
head(df2)

# Combine df1 and df2 into wine
wine <- bind_rows(
  df1
  , df2
)

head(wine)
tail(wine)

# EDA ####
# Data and AES
wine %>%
  ggplot(
    aes(
      x = residual.sugar
      , fill = label
    )
  ) +
# Geomtries
  geom_histogram(
    color = "black"
    , alpha = 0.618
    , binwidth = 1
  ) +
# Statistics
# Facets
# Coordinates
# Theme
  scale_fill_manual(values = c("red", "white")) +
  labs(
    title = "Histogram of Sugar Residuals by Wine Color"
    , y = "Count"
    , x = "Residual Sugars"
    , fill = "Red/White"
  ) +
  theme_minimal()

# drop outlier from above
wine %>%
  filter(residual.sugar < 25) %>%
  ggplot(
    aes(
      x = residual.sugar
      , fill = label
    )
  ) +
  geom_histogram(
    binwidth = 1
    , color = "black"
    , alpha = 0.618
  ) +
  scale_fill_manual(values = c("red", "white")) +
  labs(
    title = "Histogram of Sugar Residuals by Wine Color"
    , subtitle = "Filtered for Residual Surgars < 25"
    , y = "Count"
    , x = "Residual Sugars"
    , fill = "Red/White"
  ) +
  theme_minimal()

# Citirc acid
wine %>%
  ggplot(
    aes(
      x = citric.acid
      , fill = label
    )
  ) +
  # geometries
  geom_histogram(
    color = "black"
    , alpha = 0.618
    , binwidth = 0.1
  ) +
  # Statistics
  # Facets
  # Coordinates
  # theme
  scale_fill_manual(
    values = c("red", "white")
  ) +
  labs(
    title = "Histogram of Citric Acid by Wine Color"
    , y = "Count"
    , x = "Citric Acid"
    , fill = "Red/White"
  ) +
  theme_minimal()

# Alcohol
wine %>%
  ggplot(
    aes(
      x = alcohol
      , fill = label
    )
  ) +
  # geometries
  geom_histogram(
    color = "black"
    , alpha = 0.618
    , binwidth = 0.1
  ) +
  # Statistics
  # facets
  # coordinates
  # theme
  labs(
    title = "Histogram of Alcohol by Wine Color"
    , y = "Count"
    , x = "Alcohol"
    , fill = "Red/White"
  ) +
  scale_fill_manual(values = c("red", "white")) +
  theme_minimal()

# Create a scatterplot of residual.sugar versus citric.acid, color by red and white wine
wine %>%
  ggplot(
    aes(
      x = citric.acid
      , y = residual.sugar
    )
  ) +
  # geometries
  geom_point(
   aes(
     color = label
   )
   , alpha = 0.318
   , position = position_jitter()
  ) +
  # Statistics
  # facets
  # coordinaates
  # theme
  labs(
    title = "Scatter Plot of Residual Surgars vs Citirc Acid by Wine Color"
    , x = "Citric Acid"
    , y = "Residual Sugars"
    , color = "Red/White"
  ) +
  scale_color_manual(values = c("red", "white")) +
  theme(
    panel.background = element_rect("grey")
  )

# Create a scatterplot of volatile.acidity versus residual.sugar, color by red and white wine
wine %>%
  ggplot(
    aes(
      x = volatile.acidity
      , y = residual.sugar
    )
  ) +
  # geometries
  geom_point(
    aes(
      color = label
    )
    , alpha = 0.318
    , position = position_jitter()
  ) +
  # statistics
  # facets
  # coodinates
  # theme
  labs(
    title = "Scatter Plot of Residual Sugars vs Volatile Acidity by Wine Color"
    , color = "Red/White"
    , x = "Residual Sugars"
    , y = "Volatile Acidity"
  ) +
  scale_color_manual(values = c("red","white")) +
  theme(
    panel.background = element_rect("grey")
  )

# Make Cluster Data ####
clus.data <- wine %>% select(-label)
head(clus.data, 1)
