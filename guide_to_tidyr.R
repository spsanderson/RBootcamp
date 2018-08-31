library(tidyr) # or load the tidyverse as tidyr is part of it
library(data.table)

# gather() create key pair values
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min = 0, max = 100)
q2 <- runif(9, min = 0, max = 100)
q3 <- runif(9, min = 0, max = 100)
q4 <- runif(9, min = 0, max = 100)

df <- data.frame(comp = comp, year = yr, Qtr1 = q1, Qtr2 = q2, Qtr3 = q3, Qtr4 = q4)
df

gather(
  df
  , Quarter
  , Revenue
  , Qtr1:Qtr4
)

stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10,0,1),
  Y = rnorm(10,0,2),
  Z = rnorm(10,0,4)
)
stocks

stocks.gathered <- stocks %>%
  gather(stock, price, X:Z)

head(stocks.gathered)

# Spread
stocks.gathered %>% spread(stock, price)
stocks.gathered %>% spread(time, price)

df <- data.frame(new_col = c(NA,"a.x","b.y","c.z"))
df
separate(df, new_col, c('ABC', 'XYZ'))

df <- data.frame(new_col = c(NA,'a-x','b-y','c-z'))
df.sep <- separate(data = df, col = new_col, into = c('ABC', 'XYZ'), sep = '-')
df.sep

unite(df.sep, united.columns, ABC, XYZ)
unite(df.sep, united.columns, ABC, XYZ, sep = "---")
