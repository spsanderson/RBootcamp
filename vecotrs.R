# Vector Indexing and Slicing
v1 <- c(100,200,300)
v2 <- c('a','b','c')
v1
v2

# Thankfully indexing starts at 1 in R
v1[2] # will give the value 200
v2[3] # will give the value 'c'

# Slicing
v1[c(1,2)] # Grab first and second elements
v2[c(1,3)] # Grab first and third elements

# Grab a continuous vector slice
v <- seq(from = 1, to = 10, by = 1)
v
# The below will give the same thing
v2 <- c(1,2,3,4,5,6,7,8,9,10)
v2

v[2:4]
v[7:10]

# Index elements by name
v <- c(1,2,3,4)
names(v) <- c('a','b','c','d')
v
v['b']
v[c('b','c')]
v[c('d','a','b','c')]

# Filter out values
v[v > 2]
v > 2

# You can name your filters!
my.filter <- v > 2
v[my.filter]
