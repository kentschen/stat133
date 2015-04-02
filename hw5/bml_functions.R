#################################################################################
#### Functions for BML Simulation Study


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



