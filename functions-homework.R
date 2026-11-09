# Aylin Luna
#PSYC 259 Homework - Writing functions and iteration
#For full credit, answer at least 5/7 questions

#List names of students collaborating with: 
# Megan Richardson
# Krista Bebis
# Madeline Hoorn

### SETUP: RUN THIS BEFORE STARTING ----------
library(tidyverse)
set.seed(1)
id <- rep("name", 30)
x <- runif(30, 0, 10)
y <- runif(30, 0, 10)
z <- runif(30, 0, 10)
ds <- tibble(id, x, y, z)

### Question 1 ---------- 

#Vectors x, y, and z contain random numbers between 1 and 10. 
#Write a function called "limit_replace" that replaces values less than 2 or greater than 8 with NA
#The function should take a vector as input and return the replaced-vector as an output
#Then, run the function on x and save the results to a new vector "x_replace" to show it worked
limit_replace <- function(al) { #named it my initials
   ifelse(al<2 | al>8, NA, al)
  }

x_replace <- limit_replace(x)


### Question 2 ---------- 

#Make a new version of limit_replace includes arguments for a lower boundary and an upper boundary
#so that the limits can be specified (instead of being hard coded as 2 and 8)
#Run the function on vector y with boundaries 4 and 6, saving the results to a new vector "y_replace"
new_limit_replace <- function(al, lower, upper) { #named it my initials
  ifelse(al<lower | al>upper, NA, al)
}

y_replace <- new_limit_replace(y, lower = 4, upper = 6)

### Question 3 ----------

#Write a function called "plus_minus_SD" that can take one of the vectors (x/y/z) as input
#and "num_of_SDs" as an input and returns the boundaries +/- num_of_SDs around the mean.
#plus_minus_SD(x, 1) would give +/- 1SD around the mean of x, plus_minus_SD(y, 2) would give +/- 2SDs around the mean 
#Make num_of_SDs default to 1
#The output should be a named list two values, lower and upper.
#Running plus_minus_SD(x) should produce: $lower 2.142724 $upper 8.048324
plus_minus_SD <- function(vec, num_of_SDs) {
  lower <- mean(vec)-num_of_SDs*sd(vec)
  upper <- mean(vec)+num_of_SDs*sd(vec)
  return(list(lower = lower, upper = upper))
}
plus_minus_SD(x, 1)
plus_minus_SD(y, 2)

### Question 4 ----------
# Use a map function to run the new function on x, y, and z with 1 SD
map_vectors <- list(x, y, z)
map(map_vectors, plus_minus_SD, 1)

### Question 5 ----------

# Write an another new version of limit_replace
# This time, make the upper and lower boundaries optional arguments
# If they are not given, use +/- 1 SD as the boundaries (from your plus_minus_SD function)
# Apply the function to each column in ds, and save the results to a new tibble called "ds_replace"
# Hint: you will need an if() statement to handle what to do if boundaries are not given

#skipped :(

### Question 6 ----------
# Question 6 will use the iris dataset
# Write a species_summary function that takes in a tibble and a species name
# For example, species_summary(ds_iris, species_name = "setosa")
# The function should filter to the named species and then calculate  
# the min, mean, max, and sd for every numeric variable
# Before returning the summary stats, the function should also write the 
# summary stats to a file named "SPECIESNAME_summary.csv"

ds_iris <- iris
glimpse(iris)
species_summary <- function(data, species_name) {
  data %>% filter(Species == species_name) %>% 
  summarize(across(where(is.numeric),
            list(min = ~min(.x, na.rm = T),
                 mean = ~ mean(.x, na.rm = T),
                 max = ~max(.x, na.rm = T),
                 sd = ~sd(.x, na.rm = T))))
}

setosa <- species_summary(ds_iris, "setosa")                 
write.csv(setosa, "setosa_summary.csv")     
#not sure how to get the function to create the csv
            

### Question 7 ----------
# Use some type of iteration to run the species_summary() function 
# on each of the species in ds_iris, capturing the resulting summary data
# into a tibble
all_species <- unique(ds_iris$Species)
summary_data <- map_dfr(all_species, ~species_summary(ds_iris, .x))
  #almost there just missing the csv part

# If correct, you will have a 3 observation by 16 variable tibble (first 3 columns below)
# Sepal.Length_min Sepal.Length_mean  Sepal.Length_max 
# 4.3              5.006              5.8       
# 4.9              5.936              7.0       
# 4.9              6.588              7.9       
# And 3 separate CSV files saved as output