##setwd("C:/Users/j4yb1/OneDrive - University of Texas at Arlington/Documents/spring2023/data3421")
getwd()
##install.packages("tidyverse")
##install.packages("dplyr")
##install.packages("tidyr")
##install.packages("ggplot2")
##install.packages("psych")
##install.packages("e1071")
##install.packages("nycflights13")

library(tidyverse); library(dplyr); library(tidyr); library(ggplot2); library(psych); library(reshape2); library(pastecs); library(e1071); library(nycflights13)

## 1. Create a matrix with three rows and 12 columns, and calculate the mean of each column.

a = matrix(1:36, nrow=3)
a

apply(a,2,mean)

## 2. Calculate the sum, mean, median, standard deviation, skewness, quantile, kurtosis, and variance for the variable “Balance” in the job dataset.

df<-read.csv("Labs/Lab3/job.csv")
View(df)

df$Balance

sum(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)
var(df$Balance)

## 3. Recode the “Age” variable to three categories of “Young Adult”,“Middle-aged Adult”, and “Old Adult” based on quantile thresholds of 30%, 60%, and 80%.

## I'm going to add a fourth category, "Older Adult", that goes from the 80% percentile to the max.

b = unname(quantile(df$Age, probs=c(0.3,0.6,0.8,1.0)))
df$Age[df$Age<b[1]] = "Young Adult"
df$Age[df$Age<b[2]] = "Middle-aged Adult"
df$Age[df$Age<b[3]] = "Old Adult"
df$Age[df$Age<b[4]] = "Older Adult"
View(df)

## 4. Sort the “Balance” variable from high to low in the job dataset and create a new subset of the dataset with just Balance and Job Classification variables.

df4 = df[order(df$Balance),]
View(df4)

df42 = subset(df4, select = c(4,5))
View(df42)

## 5. Subset the job dataset with just the England region and with a balance of higher than 100,000.

df5 = subset(df, Region == "England" & Balance > 100000)
View(df5)

## 6. Using the flights dataset, create a new variable using existing variables (arr_time and sched_arr_time) and call it delay time.

View(flights)

flights$delay_time = flights$arr_time - flights$sched_arr_time
View(flights)

## Of course, this variable is exactly equal to df$arr_delay.