# Thomas Tran Lab3


library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(e1071)


#### Question 1 create a 3x12 matrix and calculate mean for each column

m = matrix(c(sample(100,36,replace=TRUE)),nrow=3,ncol=12)
m
apply(m,2,mean)

#### Question 2 Calculate sum, mean, median, standard deviation,
#### skewness, quantile, kurtosis, and variance for variable “Balance”in the job dataset.

df<-read.csv("job.csv")
summary(df$Balance)
sum(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)
var(df$Balance)

#### Question 3 Recode the “Age” variable to three categories of “Young Adult”,
#### “Middle-aged Adult”, and “Old Adult”, based on quantiles of 30%, 60%, and 80%.

quantile(df$Age,prob=c(0.3,0.6,0.8))
df$new_age[df$Age<=33]="Young Adult"
df$new_age[df$Age>33&df$Age<=40]="Middle-aged Adult"
df$new_age[df$Age>40]="Old Adult"
df$Age=df$new_age
df<-df[,-6]

#### Question 4 Sort the “Balance” variable from high to low in the job dataset
#### and create a new subset of the dataset with just Balance and Job Classification variables.

df<-df[order(df$Balance,decreasing=TRUE),]

df_sub = subset(df,select=c(4,5))

#### Question 5 Subset the job dataset
#### with just the England region and with a balance of higher than 100,000

df2<-subset(df,Region=="England"&Balance>100000)

#### Question 6 Using the flights dataset, create a new variable
#### using existing variables (arr_time and sched_arr_time) and call it delay time.

library(nycflights13)

flights<-mutate(flights,delay_time=arr_time-sched_arr_time)
