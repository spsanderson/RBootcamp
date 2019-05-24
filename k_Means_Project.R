# Lib Load ####
install.load::install_load(
  "tidyverse"
  , "cluster"
)

# Get files ####
df1 = read.csv(file.choose(new = T), sep = ";")
df2 = read.csv(file.choose(new = T), sep = ";")

# Add lable columns to both df 
df1$Color <- 'Red'
df2$Color <- 'White'

# head data.frames
head(df1)
head(df2)

