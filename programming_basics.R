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
