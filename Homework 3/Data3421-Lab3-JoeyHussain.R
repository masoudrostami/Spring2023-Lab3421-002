############################################################################
### Install packages in R
############################################################################
install.packages("tidyverse")
library(tidyverse)

install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)

install.packages("ggplot2")
library(ggplot2)

install.packages("e1071")
library(e1071)

install.packages("nycflights13")
library(nycflights13)

##############################################################################
### 1. Creating a matrix with 3x12 columns and calculating
### the means for each column of the matrix?
##############################################################################
a <- matrix(1:36,3,12)
a
apply(a,2,mean) # 2 mean element by col

##############################################################################
### 2. Calculate sum, mean, median, standard deviation, skewness, quantile,
### kurtosis, and variance for variable “Balance” in the job dataset.
#############################################################################
df<-read.csv("job.csv")
sum(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
kurtosis(df$Balance)
quantile(df$Balance)
var(df$Balance)

##############################################################################
### 3. Recode the “Age” variable to three categories of “Young Adult”,
### “Middle-aged Adult”, and “Old Adult”, based on quantiles of 30%, 60%, and 80%.
#############################################################################
library(dplyr)
names(df)
unique(df$Age)
quantile(df$Age,probs=c(0.30,0.60,0.80))

df$Age[df$Age>=47] = "Old Adult"
df$Age[df$Age>33&df$Age<47] = "Middle-aged Adult"
df$Age[df$Age<=33] = "Young Adult"
View(df)

###############################################################################
### 4.Sort the “Balance”variable from high to low in the job dataset and create
### anew subset of the dataset with just Balance and Job Classification variables
###############################################################################
df <- df[order(-df$Balance),]
View(df)
df2 <- select(df,Balance,Job.Classification)
View(df2)

###############################################################################
### 5.Subset the job dataset with just the England region and with a balance of
### higher than 100,000
###############################################################################
unique(df$Region)
df3 <- subset(df, Region == "England"&Balance > 100000)
df3 <- select(df3,Region,Balance)
View(df3)

#############################################################################
### 6.Using the flights dataset, create a new variable using existing
### variables(arr_timeand sched_arr_time) and call it delay time.
#############################################################################
View(flights)

flights2<-mutate(flights,delay_time=arr_time-sched_arr_time)
View(flights2)



