#Petteri Salo
#14.11.2018
##################### add some comment ##########################
#########################################

#3
math <- read.table("data/student-mat.csv", sep="\t", header=TRUE)
por <- read.table("data/student-por.csv", sep="\t", header=TRUE)
               
str(math) #The data contains  observations of  variables. 
dim(math) #and it means that there is  rows and  colums
               
str(por) #The data contains 183 observations of 60 variables. 
dim(por) #and it means that there is 183 rows and 60 colums

#4
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

str(math_por) 
dim(math_por)

#5


