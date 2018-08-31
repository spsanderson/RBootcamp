library(dplyr)
library(nycflights13)

# dplyr
head(flights)
summary(flights)

head(
  filter(
    flights
    , month == 11
    , day == 3
    , carrier == 'AA'
  )
)

slice(flights, 1:10)

head(
  arrange(
    flights
    , year
    , month
    , day
    , arr_time
  )
)

head(
  arrange(
    flights
    , year
    , month
    , day
    , desc(arr_time)
  )
)

head(
  select(
    flights
    , carrier
    , arr_time
    , tailnum
  )
)

head(
  rename(
    flights
    , airline_carrier = carrier
  )
)

distinct(select(flights, carrier))

head(mutate(flights, new_col = (arr_delay - dep_delay)))
head(transmute(flights, new_col = (arr_delay - dep_delay)))

summarise(flights, avg_air_time = mean(air_time, na.rm = T))
summarise(flights, total_time = sum(air_time, na.rm = T))

sample_n(flights, 10)
sample_frac(flights, 0.05)

# Pipe Operator ####
df <- mtcars

# Nesting
result <- arrange(sample_n(filter(df, mpg > 20), size = 5), desc(mpg))
print(result)

# Multiple Assingments
a <- filter(df, mpg > 20)
b <- sample_n(a, 5)
c <- arrange(b, desc(mpg))
print(c)

# piped
result <- df %>%
  filter(mpg > 20) %>%
  sample_n(size = 5) %>%
  arrange(desc(mpg))
print(result)
