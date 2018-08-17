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
