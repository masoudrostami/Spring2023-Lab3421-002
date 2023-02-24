# install.packages("tidyverse")
library(tidyverse)



#install.packages("dplyr") 
install.packages("dplyr")
library(dplyr)

#install.packages("tidyr")

library(tidyr)

#install.packages("ggplot2") 
library(ggplot2)  

## Question 1
new_matrix<- matrix(rnorm(36), nrow=3, ncol=12)
coloumn_means<- apply(new_matrix, 2, mean)
print(new_matrix)
print(coloumn_means)

###Question 2##
setwd("~/Downloads")
job_data <- read.csv("job.csv")

sum_balance <- sum(job_data$Balance)
print(sum_balance)
mean_balance <- mean(job_data$Balance)
print(mean_balance)
median_balance <- median(job_data$Balance)
print(median_balance)
sd_balance <- sd(job_data$Balance)
print(sd_balance)
skewness_balance <- skewness(job_data$Balance)
print(skewness_balance)
quantiles_balance <- quantile(job_data$Balance)
print(quantiles_balance)
kurtosis_balance <- kurtosis(job_data$Balance)
print(kurtosis_balance)
var_balance <- var(job_data$Balance)
print(var_balance)

#####Question 3###
job_data <- read.csv("job.csv")

quantiles <- quantile(job_data$Age, probs = c(0.3, 0.6, 0.8))

age_group <- cut(job_data$Age, breaks = c(-Inf, quantiles[1], quantiles[2], Inf),
                      labels = c("YoungAdult", "Middle-aged Adult", "OldAdult"))

job_data$Age_Group <- age_group


####Question 4###

job_data <- read.csv("job.csv")
job_data <- arrange(job, desc(Balance))
newdataset <- subset(job_data , select = c(Balance, Job.Classification))

###Question 5###
new_subset <- subset(job_data, Region == "England" & Balance > 100000)

####Question 6###
install.packages("nycflights13")
library(nycflights13)
View(flights)
###Delay in flight is going to be the difference between arrival time and scheduled arrival time
flights$delay_time <- flights$arr_time - flights$sched_arr_time

