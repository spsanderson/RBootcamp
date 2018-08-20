# list basics
v <- c(1,2,3)
m <- matrix(1:10, nrow = 2)
df <- mtcars
class(v)
class(m)
class(df)

# A list will allow all of the above in it
my.list <- list(v, m, df)
my.list

# Name items in the list
my.named.list <- list(sample.vec = v, sample.matrix = m, sample.df = df)
my.named.list
my.named.list$sample.vec

# Select objects from a list
my.list[1]
my.named.list['sample.vec'] # returns the list object
my.named.list[1]
my.named.list$sample.vec
class(my.named.list)

my.named.list$sample.vec # returns the vector/matrix etc
my.named.list[["sample.vec"]]

# A list of lists
double.list <- c(my.named.list, my.named.list)
double.list
