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
# 