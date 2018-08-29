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