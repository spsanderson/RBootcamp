# Training Exercise with Data Frames
#Ex 1: Recreate the following dataframe by creating vectors and using the 
# data.frame function: 
row.names <- c('Sam','Frank','Amy')
Age <- c(22, 25, 26)
Weight <- c(150,165,120)
Sex <- c('M','M','F')
df <- data.frame(Age, Weight, Sex)
rownames(df) <- row.names
df

# Ex 2: Check if mtcars is a dataframe using is.data.frame()
is.data.frame(mtcars)

#Use as.data.frame() to convert a matrix into a dataframe: 
mat <- matrix(1:25,nrow = 5)
is.matrix(mat)
mat.df <- as.data.frame(mat)
is.data.frame(mat.df)

# Ex 4: Set the built-in data frame mtcars as a variable df. We'll use this df 
# variable for the rest of the exercises. 
df <- mtcars

# Ex 5: Display the first 6 rows of df 
head(df)

# Ex 6: What is the average mpg value for all the cars? 
avg.mpg <- mean(df$mpg)
avg.mpg
mean(df[,1])
mean(df[, 'mpg'])

# Ex 7: Select the rows where all cars have 6 cylinders (cyl column) 
six.cyl <- df[(df$cyl == 6), ]
six.cyl
six.cylb <- df[df$cyl == 6, ]
six.cylb
subset(df, df$cyl == 6)

# Ex 8: Select the columns am,gear, and carb. 
df[, c('am','gear','carb')]

# Ex 9: Create a new column called performance, which is calculated by hp/wt
df$performance <- round((df$hp / df$wt), 2)
head(df)

# Ex 10: Your performance column will have several decimal place precision. 
# Figure out how to use round() (check help(round)) to reduce this accuracy 
# to only 2 decimal places.
# See above done already

# Ex 10: What is the average mpg for cars that have more than 100 hp AND a wt 
# value of more than 2.5. 
filtered.df <- subset(df, subset = ((df$hp > 100) & (df$wt > 2.5)))
head(filtered.df)
mean(filtered.df$mpg)         
# Extra method
mean(subset(df, hp > 100 & wt > 2.5)$mpg)

# Ex 11: What is the mpg of the Hornet Sportabout? 
df[['Hornet Sportabout','mpg']]
# OR
df['Hornet Sportabout', ]$mpg
