# EXAMPLE 1: Create a function that takes in a name as a string argument, 
# and prints out "Hello name"
hello <- function(name) {
  print(paste("Hello", name))
}
hello("John")

# EXAMPLE 2: Create a function that takes in a name as a string argument and 
# returns a string of the form - "Hello name" 
hello_name <- function(name) {
  greeting <- paste("Hello", name)
  return(greeting)
}
my.result <- hello_name("Dave")
print(my.result)
hello_name("J")

# Ex 1: Create a function that will return the product of two integers.
prod2 <- function(int1, int2) {
  my.product <- int1 * int2
  return(my.product)
}
prod2(4,5)

# Ex 2: Create a function that accepts two arguments, an integer and a vector of
# integers. It returns TRUE if the integer is present in the vector, otherwise 
# it returns FALSE. Make sure you pay careful attention to your placement of the
# return(FALSE) line in your function!
int_in_vector <- function(int1, vec1) {
  for(num in vec1){
    if(int1 == vec1[num]){
      return(TRUE)
    }
  }
  return(FALSE)
}
int_in_vector(4, c(1,2,3))

# Ex 3: Create a function that accepts two arguments, an integer and a vector 
# of integers. It returns the count of the number of occurences of the integer 
# in the input vector. 
a <- 1
b <- c(1,1,2)

count_func <- function(a,b) {
  count = 0
  for(item in b){
    if(a == item){
      count = count + 1
    }
  }
  return(count)
}
count_func(1,c(1,1,1,1,1,1,1,1,1))

# Ex 4: We want to ship bars of aluminum. We will create a function that accepts
# an integer representing the requested kilograms of aluminum for the package to
# be shipped. To fullfill these order, we have small bars (1 kilogram each) and 
# big bars (5 kilograms each). Return the least number of bars needed.
# For example, a load of 6 kg requires a minimum of two bars 
# (1 5kg bars and 1 1kg bars). A load of 17 kg requires a minimum of 5 bars 
# (3 5kg bars and 2 1kg bars). 
