# Basic R exercises
# 2 to the power of 5
2 ^ 5

# Create a vector called stock.prices with the following data points: 
# 23,27,23,21,34 
stock.prices <- c(23,27,23,21,34)
stock.prices

# Assign names to the price data points relating to the day of the week, 
# starting with Mon, Tue, Wed, etc...
stock.prices.names <- c("Mon", "Tues", "Wed", "Thu","Fri")
names(stock.prices) <- stock.prices.names
stock.prices

# What was the average (mean) stock price for the week? 
# (You may need to reference a built-in function) 
mean.stock.price <- mean(stock.prices)
mean.stock.price

# reate a vector called over.23 consisting of logicals that correspond to the 
# days where the stock price was more than $23 
# Use the over.23 vector to filter out the stock.prices vector and only return
# the day and prices where the price was over $23 
over.23 <- stock.prices[stock.prices > 23]
over.23
# OR
over.23b <- stock.prices > 23
stock.prices[over.23b]

# Use a built-in function to find the day the price was the highest
max.price <- stock.prices[stock.prices == max(stock.prices)]
max.price
max.price <- stock.prices == max(stock.prices)
stock.prices[max.price]
