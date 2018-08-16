##### 
# Creating a Matrix
1:10
v <- 1:10
v

matrix(v)

matrix(v, nrow = 2) # a 2 x 5 matrix

# How do we decide fill order?
matrix(v, nrow = 2, byrow = TRUE)
matrix(1:12, nrow = 4, byrow = FALSE)
matrix(1:12, nrow = 4, byrow = T)

# Create two vecotrs and make a matrix out of them
goog <- c(450,451,452,445,468)
msft <- c(230,231,232,233,220)

stocks <- c(goog, msft)
stocks

stock.matrix <- matrix(stocks, byrow = T, nrow = 2)
stock.matrix

# Name the rows and columns for reference colnames rownames
days <- c("Mon","Tue","Wed","Thr","Fri")
stock.names <- c("goog","msft")

colnames(stock.matrix) <- days
rownames(stock.matrix) <- stock.names

stock.matrix

#####
# Matrix Arthimatic
mat <- matrix(1:25, byrow = T, nrow = 5)
mat

mat * 2 # Mutliply
mat / 2 # divide
mat ^ 2 # power
1 / mat # recipricol
mat ^ (1/2) # Sqrt
sqrt(mat) # sqrt

mat > 15 # filter
mat[mat > 15] #filter
mat / mat # element division
mat + mat # element addition
mat ^ mat # element powers

mat %*% mat # matrix multiplicaiton
mat * mat # element by element multiplication

#####
# Matrix Operations
print(stock.matrix)

colSums(stock.matrix) # sums columns together
rowSums(stock.matrix) # sum across rows
rowMeans(stock.matrix)
colMeans(stock.matrix)

# add columns and rows cbind rbind
fb <- c(111,112,113,120,145)
tech.stocks <- rbind(stock.matrix, fb) # binded by row
tech.stocks

avg <- rowMeans(tech.stocks)
tech.stocks <- cbind(tech.stocks, avg)
tech.stocks

#####
# Matrix selection and indexing
mat <- matrix(1:50, byrow = T, nrow = 5)
mat

mat[1,] # grab the first row
mat[,1] # grav the first column
mat[]   # all rows and columns
mat[1:3,] # grab first 3 rows
mat[1:2,1:3] # grab to left rectangle
mat[, 9:10] # grab last two columns
mat[2:3, 5:6] # center square
mat[4, 3:5]
mat[5, 3:5]
mat[4:5, 3:5]

#####
# Factor and Categorical Matrices
animal <- c('d','c','d','c','c')
id <- c(1,2,3,4,5)
factor(animal)
factor.animal <- factor(animal)
factor.animal
# Nominal - order not important ie cats, dogs
# Ordinal - order important Months of the year
ord.cat <- c('cold','med','hot')
temps <- c('cold','med','hot','hot','hot','cold','med')
temps
fact.temp <- factor(temps, ordered = TRUE, levels = ord.cat) # ordered list
fact.temp
summary(fact.temp) # factored version
summary(temps)     # original


