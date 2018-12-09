library(dplyr)
library(tidyr)

# 1
# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)

# brief psychiatric rating scale (BPRS)
# 
# The BPRS assesses the level of 18 symptom constructs such as hostility, 
# suspiciousness, hallucinations and grandiosity; each of these is rated 
# from one (not present) to seven (extremely severe). The scale 
# is used to evaluate patients suspected of having schizophrenia.
# Week 0 = treatment week 

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of BPRS
names(RATS)

# Look at the structure of BPRS
str(RATS)

# Print out summaries of the variables
summary(RATS)

# Nutrition study conducted in three groups of rats. The groups were 
# put on different diets, and each animal's body weight (grams) was 
# recorded repeatedly (approximately) weekly, except in week seven 
# when two recordings were taken) over a 9-week period.

# 2

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,6)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# 4 

names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

# Long story short: in long format there are more observations but less variables
# and in short form opposite. In long form there are different key-value
# pairs which makes it easier to use


setwd("C:/Users/Pedu/Documents/GitHub/IODS-project")
write.table(BPRSL, "data/BPRSL.txt")
write.table(RATSL, "data/RATSL.txt")
