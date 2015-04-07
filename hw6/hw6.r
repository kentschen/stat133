# Homework 6
# Stat 133, Lec 2, Spring 2015
# Due : Friday March 20th by 5 pm

# Review the slides on simulations for this assignment.

# Consider the following model on use of a new drug:
# We have a population of doctors, population size : <n.doctors>
# Every doctor has either adopted the use of a new drug, or not (0/1 status)
# Now write a function that runs a simulation for a period of :
# <n.days> where
# - every day exactly two _random_ doctors meet
# - if one has adopted but the other one has not then the
#   holdout adopts the use of the drug with probability p
# Return a matrix that shows for each day which doctors have adopted
# the use of the drug.

# Input varibles are
# <n.days> : the number of days the simulation should be run for
# <n.doctors> : total number of doctors 
# <initial.doctors> : a 0/1 vector of length <n.doctors>, 1 for adopters
# <p> : the probability that the non-adopter adopts the drug.

# Ouput variable
# <has_adopted> : matrix with <n.doctors> rows and <n.days> columns
#                 i.e. one row for each doctor
#                 the entries are 0 for days where the doctor is a
#                 non-adopter, else 1 (so once a row turns to 1 it stays as 1).


sim.doctors <- function(initial.doctors, n.doctors, n.days, p){
  
  has_adopted = matrix(initial.doctors,nrow=n.doctors,ncol=n.days)
  
  for (i in 2:n.days){
    has_adopted[,i] = has_adopted[, i-1]
    sampled = sample(c(1:n.doctors), 2)
    if(has_adopted[sampled[1], i-1] == 0 & has_adopted[sampled[2], i-1] == 1)
      has_adopted[sampled[1],i] = sample(c(0,1), 1, prob = c(1-p, p))
    if(has_adopted[sampled[1],i-1] == 1 & has_adopted[sampled[2], i-1] == 0)
      has_adopted[sampled[2],i] = sample(c(0,1), 1, prob = c(1-p, p))     
  }
  # return the output
  return (has_adopted)
}

  # Set up the output variable, define it as a matrix then use initial.doctors
  # to set the first column (day)

  # Run a simulation for <n.days> (use a for loop).  In the loop:
  # 1) pick two random doctors
  # 2) check if one has adopted the other hasn't
  # 3) convert the non-adopter with probability p

  # return the output


# When you test your function you have to generate <initial.doctors> and
# pick values for the other input parameters.

set.seed(42)



# Generate a value for <initial.doctors> that has 10% 1s and 90% 0s.
# Run your function for at least 5 different values of <p> and plot
# on x-axis: days,
# on y-axis : the number of doctors that have already adopted the drug, on that day
# Put all 5 lines in one figure (e.g. use first plot() then lines() for the subsequent lines)

n.doctors = 100

initial.doctors = sample(c(0, 1), size = n.doctors, prob = c(0.9, 0.1), replace = T)
n.days = 500

p_0.2 = sim.doctors(initial.doctors, n.doctors, n.days, 0.2)
p_0.4 = sim.doctors(initial.doctors, n.doctors, n.days, 0.4)
p_0.6 = sim.doctors(initial.doctors, n.doctors, n.days, 0.6)
p_0.8 = sim.doctors(initial.doctors, n.doctors, n.days, 0.8)
p_1.0 = sim.doctors(initial.doctors, n.doctors, n.days, 1.0)

count_sum = function(x){
  a = c()
  for (i in 1: ncol(x))
    a[i] = sum(x[,i])
  return(a)
}

sum_0.2 = count_sum(p_0.2)
sum_0.4 = count_sum(p_0.4)
sum_0.6 = count_sum(p_0.6)
sum_0.8 = count_sum(p_0.8)
sum_1.0 = count_sum(p_1.0)

plot(c(1:n.days), ylim = c(0, 100), sum_0.2, 
     main = "# doctors who adopted drug",
     xlab = "days",
     ylab = "# drugs adopted", "l",
     col = "red")

lines(c(1:n.days), sum_0.4, col = "blue")
lines(c(1:n.days), sum_0.6, col = "green")
lines(c(1:n.days), sum_0.8, col = "gold")
lines(c(1:n.days), sum_1.0, col = "black")

legend("bottomright", 
       fill = c("red", "blue", "green", "gold", "black"), 
       legend = c(0.2, 0.4, 0.6, 0.8, 1.0))


