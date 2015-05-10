########### Apply statements
## In this homework we will do a few simple excercises with apply.  
## You will be using apply statements in many of the upcoming assignments.

# Load the rainfall data, you will get two lists, [rain] and [day]
load("rainfallCO.rda")

# Create a variable 
# max.rain : a vector of length 5 with the maximum rainfall at each station
max.rain <- sapply(rain, max)
# Create a variable 
# mean.rain : a vector of length 5 with the average rainfall at each station
mean.rain <- sapply(rain, mean)


# Create a variable 
# sd.rain : a vector of length 5 with the standard deviation of the rainfall at each station
sd.rain <- (rain, sd)

# Create a variable 
# n1989.rain : a vector of length 5 with the number of measurements at each station in the year 1989 (use [day])
n1989.rain <- 


