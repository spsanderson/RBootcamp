# Lib Load ####
install.load::install_load(
  "neuralnet"
  , "tidyverse"
  , "ggplot2"
  , "caTools"
  , "rpart"
)

# Get data ####
df <- read.csv(file.choose(new = T))
head(df)
str(df)

# EDA ####
df %>%
  ggplot(
    aes(
      x = Image.Var
      , y = Image.Skew
    )
  ) + 
  geom_point(
    aes(
      color = Class
    )
  )
