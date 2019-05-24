# Lib Load ####
install.load::install_load(
  "tidyverse"
  , "cluster"
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
