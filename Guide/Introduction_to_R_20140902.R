# Quick intro to data exploration in R

# R can be regarded as an implementation of the S language
# which was developed at Bell Laboratories by Rick Becker, John Chambers and Allan Wilks.
# It has a lot of built-in functionality that makes
# common data analysis and data plotting tasks very easy. The R programming language is somewhat
# similar to C (similar syntax for loops, conditionals, recursive functions), 
# and so it is a very flexible and powerful scripting language which makes it easy to replicate analyses.
# It is free and open source, and has a thriving user base in both industry and academia.  There is a 
# huge community of people developing R packages (these are addins akin to MATLAB toolboxes), 
# which are easy to install and link via the R command line.

# --------------- Creating Scalars, Datatypes ---------------
# In R (like Python, MATLAB, Mathematica)  we can bind variables in our workspace
# Let's make some scalars. R has 4 fundamental datatypes
# 1. numeric

rep(1,4)
rep(1,3)
rep(T,4)
rep(c(T,F),4)

x = 55
mode(x)

# 2. character (strings)
name = 'Jeff'
mode(name)

# 3. logical
test = FALSE
test = F
test = T
mode(test)

# 4. factor - discrete valued data
fact = factor('male')
fact

# Some simple calculations

i = 1:5
sum(i)
3*sum(i)

i
i-1
sum(i-1)

i = 1:5
i
i^2+i
sum(i^2+i)

l = c(1.2, -1.4, 1.35, .2, 1.9)
l
mean(l)
n=5
sd_plus = sqrt(sum((l-mean(l))^2)/(n-1))
sd_plus
# notice: R's built-in sd() function actually uses sd_plus with n-1 in the denominator. Be careful! 
sd(l)


# --------------- Some data structures ---------------
# Usually in R, we are working with vectors, arrays, datasets, or lists (not just scalars)
# To combine scalars to make a vector, or to concatenate vectors, we use the 'c' command
vec1 = c(1,2,3,4)
vec2 = c(5,6,7,8)
vec3 = c(vec1,vec2)
fact2 = factor(c('male','female','male','male','male','female'))

vec1
vec2
vec3

fact2

# There are some shorthands for creating simple vectors:
# Sequences
vec1 = 1:4
vec2 = seq(5, 8, by=2) 
# Note: I am specifying 'by=' to say that I want the parameter 'by'
# in the seq function to be 1.  This way, one can give function parameters
# out of order if we want, tr make our code more expressive. To 
# see the help for a particular function enter it in the command line with
# a '?' prefix:
??seq

# Repeats
rep1 = rep(10, times=8)
rep1
rep2 = rep(vec1, times = 3)
rep2
rep3 = rep(vec1, each = 3)
rep3

# One VERY useful feature of R is the ability to name things
# and index by name, rather than just by number. This
# is very common in data analysis (and not as easy in MATLAB or Python)
# A quick example
ages = c(8, 35, 35, 63)
names(ages) = c('junior','mom','dad','grandma')
ages

# To combine vectors into a matrix we can use rbind and cbind
mat1 = rbind(vec1,vec2)
mat1
mat2 = cbind(vec1,vec2)
mat2

# Let's give the matrix some row names
rownames(mat1) = c('first','second')
colnames(mat1) = c('I','II','III','IV')
mat1

# --- Handling missing data ---
# In addition, R has a special element to indicate missing data:
spotty = c(141, NA, 120, NA, 64)
# NA's like to propagate themselves
sum(spotty)
# So you need to tell R to ignore them:
sum(spotty, na.rm=T)
# But this does:
sum(is.na(spotty))

# --------------- Subsetting and accessing vectors and matrices ---------------
# When you load R, there are several example datasets pre-loaded
# Let's work with the precipitation dataset, which is just a vector
# showing precipitation data for a bunch of cities
precip
names(precip)

# There are the 4 basic methods of subsetting vectors / matrices in R:
# 1) by position
precip[1]
precip[66]
precip[10:14]
mat1[2,2]

# 2) by exclusion
precip[-70]
precip[-(4:50)]

# 3) by logical - you provide a logical vector with the same length as the vector
# you wish to subset
l = length(precip)
# Get the 4th element
l
rep(F,4)
precip[c(F,F,F,T,rep(F,l-4))]
# Get all elements less than 10
precip[precip < 10]
# Notice that "precip < 10" is itself a logical vector
# Get all elements greater than 50
precip[precip > 50]

mat1[c(F,T),c(F,T,T,F)]

# 4) by name
precip['Charleston']
precip[c('Chicago','San Francisco')]
mat1['first','II']


# --------------- Aside: Vectorized calculations ---------------
# In R (and MATLAB and Python), unlike C or Java, we want to avoid writing long loops,
# especially when we need to perform the same operation on every element of a vector,
# matrix, or list.  All arithmetic and logical operations in R can be vectorized.
# Remember we had these short vectors:
vec1

vec2
# We can add them in a vectorized way:
vec1 + vec2
# We can compare them in a vectorized way, resulting in a vector of logicals:
vec1 == vec2 - 4
vec1 == vec2 * 3
# For example, convert precip from inches to feet
precip / 12
# We can use a vector of logicals to subset
# This is what we did with precip
precip > 50
# precip has 70 elements, and 50 is a scalar, but that's ok because R recycles to match dimension
# How many cities have precip > 50 ?
sum(precip > 50)
# Which cities?
precip[precip > 50]

# --------------- Basic Plotting ---------------
# It's very easy to create plots via the command line in R
# R has a built-in plotting library, though there are
# some external packages that are very popular (ggplot2, for example)

# Let's use the internal plotting library
# Use the cars dataset, which shows braking times for cars traveling various speeds
# 'plot' gives you a scatter plot 
plot(cars$speed,cars$dist)
# Can change the plotting character, color, give some titles
plot(cars$speed, cars$dist, col = 'blue', pch = 17,
     xlab = 'Speed', ylab = 'Braking Distance', main = 'Speed vs. Braking Distance')

# Can make histograms and density estimates
hist(chickwts$weight, freq = F, col = 'lightblue')
plot(density(chickwts$weight), ylim = c(0, 0.006))
# Add the histogram back on top
hist(chickwts$weight, freq = F, col = 'lightblue', add = T)

# Generate a random vector
x = rnorm(n=100, mean = 10, sd = 5) # Gaussian
x = rpois(n=100, lambda = 6) # Poisson
x = rbinom(n = 120, size = 10, prob = .2) # Binomial
s = sample(1000, size = 50, replace = T) # Sampling from a set with replacement
s = sample(52, size = 5, replace = F) # Sampling from a set without replacement

# Convert a vector into a matrix
m = matrix(data = x, nrow = 20, ncol = 6)

# transpose
t(m)

# matrix multiplication
cc = t(m) %*% m

# Take the inverse of a matrix
solve(cc)


# --------------- Some more data containers ---------------
# --- Lists ---
# Vectors and matrices in R must all contain data of the same type (numeric, logical, or character)
# If you need to combine different datatypes into one container you can use a list
list1 = list(c('Bob','Jeff'),1:20,c(F,T,F,F,F))
# We subset lists with the double bracket
list1[[1]]
list1[[1]][2]
# We can name things in list
names(list1) = c('People','Numbers','Logicals')
# Then we can access things by name
list1[['People']]
list1$People

# -- Data frames ---
# Data frames are the standard dataset object in R
# A data frame is halfway between a list and a matrix
# A data frame is a list of columns. Each column has to have the
# same length, but, unlike a matrix, they can be of different types
# We can use the built-in chickwts dataset
head(chickwts)
# We can subset a data frame just like a matrix
chickwts[1:10,1]
chickwts[chickwts$feed == 'casein',]
chickwts[chickwts$weight > 300,]
# Let's do some quick calculations
table(chickwts$feed)
mean(chickwts$weight)
sd(chickwts$weight)
summary(chickwts)

# Q-Q plots
par(mfrow=c(1,2))

# create sample data 
x <- rt(100, df=3)

# normal fit 
qqnorm(x); 
qqline(x)

# Finding help
?boxplot
# EXERCISE: Plot a boxplot for any of the variables