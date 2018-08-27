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
