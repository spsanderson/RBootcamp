library(dplyr)
df <- mtcars

# Return rows of cars that have an mpg value greater than 20 and 6 cylinders
df %>%
  filter(mpg > 20 & cyl == 6)

# Reorder the Data Frame by cyl first, then by descending wt.
df %>%
  arrange(cyl, desc(wt))

# Select the columns mpg and hp
select(df, mpg, hp)

# Select the distinct values of the gear column.
distinct(df, gear)

# Create a new column called "Performance" which is calculated by 
# hp divided by wt.
mutate(df, Performance = (hp / wt))


# Find the mean mpg value using dplyr.
summarise(df, mean(mpg, na.rm = T))

# Use pipe operators to get the mean hp value for cars with 6 cylinders
df %>%
  filter(cyl == 6) %>%
  summarise(mean(hp, na.rm = T))
