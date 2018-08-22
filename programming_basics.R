# Programming Basics

# Logical Operators
# & And
# | OR
# ! Not

x <- 10
x < 20
x < 20 & x > 5
(x < 20) & (x > 5) & (x == 10)

(x == 100) | (x == 10)

df <- mtcars
head(df)
df[df$mpg > 20, ]
subset(df, mpg > 20)
df[(df$mpg > 20) & (df$hp > 100), ]
df[(df$mpg > 20) | (df$hp > 100), ]

# if, else, and else if statements
x <- 10
if (x == 10) {
  print('x is equal to 10')
} else if (x == 12) {
  print('x is equal to 12')
} else {
  print('x is not equal to 10 or 12')
}

ham <- 10
cheese <- 10
report <- 'blank'

if ((ham >= 10) & (cheese >= 10)) {
  report <- "strong sales of both ham and cheese"
} else if ((ham == 0) & (cheese == 0)) {
  report <- "No sales today"
} else {
  report <- "We sold something today"
}

print(report)

# While Loops
x <- 0

while (x < 10) {
  print(paste0("x = ", x))
  x <- x + 1
  if (x == 10) {
    print(paste("X is now equal to 10! Break the loop!"))
    break
  }
}

# For loop
vec <- 1:10
for (i in vec) {
  print(i)
}

for (temp.var in vec) {
  result <- temp.var + 1
  print(paste("The temp.var plus 1 is equal to:", result))
}

my.list <- list(1:10, mtcars, 12)
for (item in my.list) {
  print(item)
}

mat <- matrix(1:25, nrow = 5)
for (num in mat) { # goes by columns
  print(num)
}

# nested for loop
for (row in 1:nrow(mat)) {
  for (col in 1:ncol(mat)) {
    #print(paste("The selected row is:", row))
    print(
      paste('The element at row:', row
        , 'and col:', col
        ,'is:', mat[row,col]
        )
      )
  }
}

#####
# Functions
# Non-input function
hello <- function() {
  print("Hello")
}
hello()

hello <- function(name = 'User') {
  print(paste("Hello", name))
}
hello("Steve")
hello()

add_num <- function(num1, num2) {
  # print(num1 + num2)
  my.sum <- num1 + num2 # Scope is local only inside of function
  return(my.sum)
}
add_num(4,5)
result <- add_num(4, 5)
result
# Scope Global
v <- "I'm a Global Variable"
stuff <- "I'm Global Stuff"

fun <- function(stuff) {
  print(v)
  stuff <- "Reassign stuff inside of this function fun"
  print(stuff)
}

fun(stuff)
print(stuff)
