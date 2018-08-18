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
