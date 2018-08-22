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
    } else {
      return(FALSE)
    }
  }
}
int_in_vector(4, c(1,2,3))

