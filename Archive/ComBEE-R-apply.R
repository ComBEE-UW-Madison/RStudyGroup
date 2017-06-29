#ComBEE R Study Group 2017-03-14 Apply/For Loops

??apply

#base::apply
  #Description: "Returns a vector/array/list of values obtained by applying
    #function to margins of an array or matrix"
#"Applying the function to each individual value"

#Create matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol=2)
m

#Find mean of rows
apply(m, 1, mean)

#Find mean of the columns
apply(m, 2, mean)

#Divide values by 2
apply(m, 1:2, function(x) x/2)

#Examples from help guide
  #Compute row and column sums for a matrix
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
dimnames(x)[[1]] <- letters[1:8]
apply(x, 2, mean, trim = .2)
col.sums <- apply(x, 2, sum)
row.sums <- apply(x, 1, sum)
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))


#Apply Examples
  # lapply to write apply functions for running through a list

#Have list of numeric values:
ll <- list(a=rnorm(6,mean=1), b=rnorm(6,mean=4), c=rnorm(6,mean=6))
ll

#Calculate mean for each vector stored in the list
  #Empty vector for means
ll_means <- numeric(length(ll))
  #Loop over list element and calc mean
for (i in seq_along(ll)) { ll_means[i] <- mean(ll[[i]]) }
ll_means

#Instead of for loop, use lapply
lapply(ll,mean)

#Want to ignore NA values, two approaches:
  #add argument in lapply
ll$a[3] <- NA
lapply(ll,mean)
lapply(ll,mean,na.rm=TRUE)
  #Or make new function for lapply to run through
meanRemoveNA <- function(x) mean(x, na.rm=TRUE)
lapply(ll, meanRemoveNA)

#Another lapply example
  #Returns a list of the same length as X, each element of which is result of applying function to the corresponding element of X
#Create a list with 2 elements
l <- list(a=1:10, b=11:20)
#Mean of values in each element
lapply(l, mean)
#Sum of values in each element
lapply(l, sum)

#More applying list functions


#sapply simplifies results into vector, array or matrix
sapply(ll, function(x) mean(x, na.rm=TRUE))

#If lapply would have returned a list with element $a and $b, sapply will return either a vector, with:
#elements [['a']] and [['b']] or matrix with column names "a" and "b" 

#Create list with two elements
l <- list(a=1:10, b=11:20)
#Mean of values with sapply
l.mean <- sapply(l,mean)
#What type of object is returned?
class(l.mean)
#numeric vetor, so get element "a" in brackets
l.mean[['a']]
l.mean[['b']]

#vapply similar to sapply, has a pre-specified type of return value
#Third argument in vapply, kind of a template

#Make a list
l <- list(a=1:10, b=11:20)
#Fivenum of values using vapply
l.fivenum <- vapply(l, fivenum, c(Min.=0, "1st Qu." =0, Median=0, "3rd Qu." =0, Max.=0))
class(l.fivenum)
l.fivenum
  #vapply returned a matrix, where column names correspond ot the original list elements and row names to output template


#Replicate
#A wrapper for common use of sapply for repeated evaluation of an expression
#Give it two mandatory arguments, number of repliations and function to replicate
  #Third argument, simplify  = T, simplify to vector or matrix

#Simulate 10 normal distributions, each with 10 observations: 
replicate(10, rnorm(10))


#mapply is a multivariate version of sapply, uses multiple arguments
  #In this example, I have two genotypes, and I want to see how many alleles are shared by calling intersect
ind_1 <- list(loci_1=c("T", "T"), loci_2=c("T", "G"), loci_3=c("C", "G"))
ind_2 <- list(loci_1=c("A", "A"), loci_2=c("G", "G"), loci_3=c("C", "G"))
mapply(function(a,b) length(intersect(a,b)), ind_1, ind_2)

#mapply applies function to the first elements of each ... argument
l1 <- list(a=c(1:10), b=c(11:20))
l2 <- list(c=c(21:30), d=c(31:40))
  #Sum the corresponding elements of l1 and l2
mapply(sum, l1$a, l1$b, l2$c, l2$d)
l1
l2

#eapply applies a function to the named values from the environment and returns list
#An environment is a self-contained object with own variables and functions 

#New environment
e <- new.env()
#Two environment variables, a and b
e$a <- 1:10
e$b <- 11:20
#Find mean of the variables
eapply(e, mean)
  #Environments used often by packages such as Bioconductor

#rapply
#Recursive version of lapply
#Applies functions to lists in different ways
#list
l <- list(a=1:10, b=11:20)
#log2 of each value in list
rapply(l, log2)
#log2 of each value in each list
rapply(l, log2, how="list")
#Mean function
rapply(l,mean)
rapply(l, mean, how="list")

#Output of rapply depends on both the function and the how argument 
#How is list, the original list strucutre is preserved, otherwise default is unlist, gives as vector

#tapply
#Apply a function to each cell of a ragged array, to each group of values given by a unique combo of levels of certain factors
#tapply(X, INDEX, FUN = NULL...simplify=TRUE)
attach(iris)
#Mean petal length by species
tapply(iris$Petal.Length, Species, mean)
head(iris)
  #This seems to be similar to dplyr 
