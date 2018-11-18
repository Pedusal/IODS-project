#Petteri Salo
#14.11.2018
#Creating new dataset by combining math and Portugueses 
#students performance datas from UCI Machine Learning Repository 
#(https://archive.ics.uci.edu/ml/datasets/Student+Performance)

#3
math <- read.table("data/student-mat.csv", sep=";", header=TRUE)
por <- read.table("data/student-por.csv", sep=";", header=TRUE)
               
str(math) #The data contains 395 observations of 33 variables 
#with datatypes: int and factor. 
dim(math) #and it means that there is 395 rows and 33 colums
               
str(por) #The data contains 649 observations of 33 variables (int, factor). 
dim(por) #and it means that there is 649 rows and 33 colums

#4
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

str(math_por) #382 obs. 53 variabs (int and factor).
dim(math_por) # 382 row and 53 column

#5
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)


#6
# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#7
# glimpse at the alc data
glimpse(alc)

setwd("C:/Users/Pedu/Documents/GitHub/IODS-project")
write.table(alc, file = "data/alc.txt")

######################################## testing
# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
gather(alc) %>% glimpse()

# draw a bar plot of each variable
gather(alc) %>% ggplot(aes(value)) + geom_bar() + facet_wrap("key", scales = "free")

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill=sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use))

# draw a bar plot of high_use by sex
g2 + geom_bar()
g2 + facet_wrap("sex")
