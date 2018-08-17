######
# Data Frames - the workhorse of R

# Data Frame Basics
head(state.x77)
head(USPersonalExpenditure)
head(women)

# All datasets built into R
data()
head(WorldPhones)
tail(WorldPhones)
tail(state.x77)
dim(state.x77)
class(state.x77)
str(state.x77)
summary(state.x77)

# Create our own data.frame
days <- c("Mon","Tue","Wed","Thu","Fri")
temp <- c(22.2,21,23,24.3,25)
rain <- c(T,T,F,F,T)
df <- data.frame(days, temp, rain)
df
str(df)
summary(df)

#####
# Selection and Indexing
df[1, ] # The first row of the data.frame just like a matrix
df[, 1] # The first column of the data.frame just like a matrix
df[,'rain'] # Slice by column name
df[1:5, c('days','temp')]

df$days # Dollar sign notiation
df$temp # returns a vector
df$rain
df['temp'] # Bracket notation returns a data.frame

# Grab a subset
days.rained <- subset(df, subset = rain == TRUE)
days.rained
subset(df, subset = temp > 23)

# Sort
sorted.temp <- order(df['temp'])
sorted.temp
df[sorted.temp,]

desc.temp <- order(-df['temp'])
desc.temp
df[desc.temp, ]

desc.temp <- order(-df$temp)
df[desc.temp, ]

#####
# Data Frame Operations
# Creating Data Frames
empty <- data.frame()
c1 <- 1:10
c2 <- letters[1:10]
c1
c2
df <- data.frame(col.name.1 = c1, col.name.2 = c2)
df

# Import export
d2 <- read.csv('some_file.csv')
write.csv(df, file = 'saved_df.csv') # index saved as column X
df2 <- read.csv('saved_df.csv')
df2

# Getting info about df
nrow(df) # how many rows do you have
ncol(df) # how many columns less the idnex column
colnames(df) # column names
str(df)
summary(df)

# Reference a particular cell in a data.frame
df
df[[5,2]] # cell at row 5 column 2 'e'
df[5,2]
a <- df[[5,2]]
b <- df[5,2]
str(a)
str(b)
df[[5,'col.name.2']]
df[[2,'col.name.1']] <- 9999
df
df[1,] # return a row - returns data.frame not vector

# Reference columns
head(mtcars)
nrow(mtcars)

mtcars$mpg # most common way to grab a column returns a vector
mtcars[, 'mpg'] # returns a vector
mtcars[, 1] # returns a vector
mtcars[['mpg']] # again returns a vector
mtcars['mpg'] #returns a data.frame
mtcars[1] # returns a data.frame
head(mtcars[c('mpg', 'cyl')]) # get multiple columns

# Overview data frame operations
