#################################################################################
#### BML Simulation Study

#### Put in this file the code to run the BML simulation study for a set of input parameters.
#### Save some of the output data into an R object and use save() to save it to disk for reference
#### when you write up your results.
#### The output can e.g. be how many steps the system took until it hit gridlock or
#### how many steps you observered before concluding that it is in a free flowing state.


#### Initialization function.
## Input : size of grid [r and c] and density [p]
## Output : A matrix [m] with entries 0 (no cars) 1 (red cars) or 2 (blue cars)
## that stores the state of the system (i.e. location of red and blue cars)

bml.init <- function(r, c, p){
  m <- matrix(sample(c(0, 1, 2), c * r, prob = c(1-p, p/2, p/2), replace = T), nrow = r)
  #return(m)
}

#### Function to move the system one step (east and north)
## Input : a matrix [m] of the same type as the output from bml.init()
## Output : TWO variables, the updated [m] and a logical variable
## [grid.new] which should be TRUE if the system changed, FALSE otherwise.

## NOTE : the function should move the red cars once and the blue cars once,
## you can write extra functions that do just a step north or just a step east.

bml.step <- function(m){
  initial_m1=m
  for (i in 1:nrow(m)) {
    for (j in 1:(ncol(m)-1)){
      if (initial_m1[i,j]==1 & initial_m1[i,j+1]==0){
        m[i,j+1]=1
        m[i,j]=0
      }
    }
    if (initial_m1[i,ncol(m)]==1 & initial_m1[i,1]==0){
      m[i,1]=1
      m[i,ncol(m)]=0
    }    
  }
  initial_m2=m
  for (j in 1:ncol(m)){
    for (i in nrow(m):2){
      if (initial_m2[i,j]==2 & initial_m2[i-1,j]==0){
        m[i-1,j]=2
        m[i,j]=0
      }
    }
    if (initial_m2[1,j]==2 & initial_m2[nrow(m),j]==0){
      m[nrow(m),j]=2
      m[1,j]=0
    }
  }  
  if(any(m!=initial_m1))
    grid.new=T
  else
    grid.new=F
  return(list(m, grid.new))  
}



#### Function to do a simulation for a given set of input parameters
## Input : size of grid [r and c] and density [p]
## Output : *up to you* (e.g. number of steps taken, did you hit gridlock, ...)

bml.sim <- function(r, c, p){
  initial_m=bml.init(r,c,p)
  new_m=list(initial_m,T)
  max_iteration=1000
  for (i in 1:max_iteration){
    new_m=bml.step(new_m[[1]])
    if (!(new_m[[2]]))
      break
  }
  return (list(i,new_m[[1]],new_m[[2]]))
}


###Simulation

bml.sim(50, 50, 0.4)
bml.sim(50, 50, 0.3)
bml.sim(50, 50, 0.35)

p = c(35:50/100)
p_gridlock = 35:50
num_steps_for_gridlock = 35:50

sim = function(r,c){
  for (i in 1:length(p)){
    print(p[i])
    results = bml.sim(r,c,p[i])
    p_gridlock[i] = results[[1]]
    num_steps_for_gridlock[i] = results[[2]]
  }
  
  jpeg(paste(r,"*", c, "_", 1,".jpg",sep = ""))
  
  plot(p, p_gridlock, main = paste("p vs. Probability of hitting a gridlock for matrix ", r, "*", c, sep=""), xlab = "p", ylab = "P(Gridlock|p)")
  text(p,p_gridlock,p_gridlock, pos  = 3)
  
  dev.off()
  jpeg(paste(r,"*", c, "_", 2,".jpg",sep = ""))
  
  plot(p, num_steps_for_gridlock, main = paste("p vs. Number of steps to reach gridlock", r, "*", c, sep=""), xlab = "p", ylab = "Number of steps to reach gridlock")
  text(p,num_steps_for_gridlock, ceiling(num_steps_for_gridlock), pos  = 2)
  
  dev.off()
}

sim(10, 10)

sim(30, 30)

sim(50, 50)

sim(70, 70)

sim(100, 100)

sim(20, 45)

sim(15, 60)

sim(10, 90)


