#####
# Advanced R Programming

# Built-in R Features
# Sequence
seq(0, 100, by = 10) # create a sequence, start, end, by
seq(0, 100, by = 10)
seq(0, 24, by = 2)

# Sorting
v <- c(1,4,7,2,13,3,11)
v
sort(v) # sort data
sort(v, decreasing = TRUE)

cv <- c('b','d','a','C')
sort(cv)

# Reverse
v <- 1:10
rev(v)

# Structure
str(v)
str(mtcars)

# Summary
summary(mtcars)

# Append - Merge objects together
v <- 1:10
v2 <- 35:40
append(v, v2)

# Check and convert data types
# is.
v <- c(1,2,3)
is.vector(v)
is.data.frame(v)
is.data.frame(mtcars)

# as. to convert into another data type
v <- c(1,2,3)
as.list(v)
as.matrix(v)

#####
# Using Apply
sample(x = 1:10, 1)
v <- 1:5

addrand <- function(x) {
  ran <- sample(1:100, 1)
  return( x + ran )
}
print(addrand(10))

result <- lapply(v, addrand) # returns a list
print(result)

result <- sapply(v, addrand) # returns a vector
print(result)

v <- 1:5
times2 <- function(num){
  return(num * 2)
}
print(times2(v))

# Anonymous functions (lambda in python)
v <- 1:5
result <- sapply(v, function(num){num*2})
print(result)

# using apply with multiple inputs
v <- 1:5
add_choice <- function(num, choice){
  return( num + choice )
}
print(add_choice(2,10))

print(sapply(v, add_choice, choice = 100))

#####
# Math functions
abs(2) # absolute value
abs(-2)
v <- c(-2,-3,0,4)
abs(v)
sum(v)
mean(v)
round(mean(v), 1)

#####
# Regular expressions / Regex
# grepl returns logical
# grep returns an index
text <- "Hi there, do you know who are coding for?"
grepl('coding', text)
grepl('dog', text)
grepl('do you', text)
v <- c('a','b','c','d','d')
v
grepl('b',v)
grep('b', v)

grepl('hello','hello world')
grep('a', c('b', 'a'))

#####
# Dates and timestamps
Sys.Date()
today <- Sys.Date()
class(today)

c <- "1990-01-01"
class(c)
my.date <- as.Date(c)
class(my.date)

my.date <- as.Date("Nov-03-90", format = "%b-%d-%y")
my.date

# %d Day of the month (decimal number)
# %m Month (decimal number)
# %b Month (abbreviated)
# %B Month (Full name)
# %y year (2 digit)
# %Y year (4 digit)

as.Date("June, 01,2002", format = "%B,%d,%Y")
as.POSIXct("11:02:03", format = "%H:%M:%S")
help(strptime)
strptime("11:02:03", format = "%H:%M:%S")
