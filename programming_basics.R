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
