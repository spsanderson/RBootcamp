# Conditional training

# Example: Write a script that prints "Hello" if the variable x is equal to 1:
x <- 1
if (x == 1) {
  print("Hello")
}

# Ex 1: Write a script that will print "Even Number" if the variable x is an 
# even number, otherwise print "Not Even": 
x <- 3
if (x %% 2 == 0) {
  print("Even")
} else {
  print("Odd")
}

# Ex 2: Write a script that will print 'Is a Matrix' if the variable x is a 
# matrix, otherwise print "Not a Matrix". Hint: You may want to check out 
# help(is.matrix) 
mat <- matrix(1:25, nrow = 5)
if (is.matrix(mat)) {
  print("Is a Matrix")
} else {
  print("Not a Matrix")
}

# Ex 3: Create a script that given a numeric vector x with a length 3, will 
# print out the elements in order from high to low. You must use if,else if, 
# and else statements for your logic. (This code will be relatively long) 
x <- c(1,3,2)
sort(x, decreasing = T)
length(x)
if (length(x) == 3) {
  sorted.x <- sort(x, decreasing = T)
  print(sorted.x[1])
  print(sorted.x[2])
  print(sorted.x[3])
} 

if ((length(x) == 3) & (x[1] > x[2])) {
  # First and second place
  fir <- x[1]
  sec <- x[2]
} else {
  fir <- x[2]
  sec <- x[1]
}

if((length(x) == 3) & (x[3] > fir) & (x[3] > sec)) {
  # If third element is largest
  thi <- sec
  sec <- fir
  fir <- x[3]
  # Third element is smallest
} else if ( (x[3] < fir) & (x[3] < sec) ) {
  thi <- x[3]
} else {
  thi <- sec
  sec <- x[3]
}

print(paste(fir, sec, thi))

# Ex 4: Write a script that uses if,else if, and else statements to print the 
# max element in a numeric vector with 3 elements. 
x <- c(2,100,10)

if ( (x[1] > x[2]) & (x[1] > x[3]) ) {
  # if x[1] is bigger than 2 and 3
  print(x[1])
  # x[1] cleared, no compare 2 and 3
} else if ( x[2] > x[3] ) {
  print(x[2])
  # 2 cleared no print last number
} else {
  print(x[3])
}
