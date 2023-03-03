# changing to correct working directory
getwd()

#install.packages
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2) 



# importing csv. file to Global Environment
jobs <- read.csv("job.csv", header = TRUE, sep = ",")
jobs


# QUESTION 1 ##########################################################################

# the matrix syntax is (min num : max num, nrow = how many rows you want)
mb <- matrix(1:36, nrow = 3)
mb


# QUESTION 2 ########################################################################


# separating the Balance data to work on
balance <- jobs[, c("Balance")]
print(balance)

# Sum 
balance_sum <-sum(balance)
balance_sum
#Answer: 159622523


# Mean
balance_mean <-mean(balance)
balance_mean
#Answer: 39766.45


# Median
balance_median <- median(balance)
balance_median
#Answer: 33567.3


# Standard Deviation
balance_sd <- sd(balance)
balance_sd
#Answer: 29859.49


# Skewness
balance_skew <- rnorm(balance)
balance_skew 
#Answer:[1]  1.5754842573 -0.8938117888  1.2183690704 -0.7540924129 -0.0211654250  2.2174734997
#[7] -0.1953742469  1.6647943669 -0.5442140279  1.2718482322 -0.6972560434  1.1410367563
# -1.6985623331  0.3939109182 -0.7537036586 -0.1047236948  0.2263536142  0.5846450466
#[19]  1.2680972302 -1.5514993966 -0.7500131532  1.7615811619  0.0218545779 -0.6611960714
#And more


# Quantile
balance_quant <- quantile(balance)
balance_quant
#Answer:
#0%       25%       50%       75%      100% 
#11.52  16115.37  33567.33  57533.93 183467.70 


# Kurtosis
install.packages("e1071")
library(e1071) 
balance_kurt <- kurtosis(balance)
balance_kurt
#Answer: 0.7675059

# Variance for variable

CV <- function(balance) { sd(balance) / mean(balance) }





#QUESTION 3##################################################################

# Pulling the variables from Age
age <- jobs[, c("Age")]
age
# Answer: [1] 21 34 46 32 38 30 34 48 33 42 40 39 24 46 36 42 31 42 40 46 37 58 41 52 38 55 37 33 50
#[30] 42 25 30 58 26 34 36 33 31 35 59 27 35 49 22 53 47 32 19 27 39 29 31 37 32 24 40 33 44
#[59] 39 47 35 47 47 39 50 43 47 61 53 45 49 51 36 45 30 44 38 36 23 34 36 20 31 42 38 39 41

#Classifying the ages

#The categories: Young Adult =< 30, Middle Aged Adult 31-50, Old Adult => 50

age_Categories <- cut(age, breaks = c(0,30,50,100), labels = c("Young Adult","Middle Age Adult", "Old Adult"))
table(age_Categories)
#Answer: [1] Young Adult      Middle Age Adult Middle Age Adult Middle Age Adult Middle Age Adult
#[6] Young Adult      Middle Age Adult Middle Age Adult Middle Age Adult Middle Age Adult
#[11] Middle Age Adult Middle Age Adult Young Adult      Middle Age Adult Middle Age Adult
#[16] Middle Age Adult Middle Age Adult Middle Age Adult Middle Age Adult Middle Age Adult



age_quantile <-quantile(age, probs = c(0.3,0.6,0.8))
# Answer: 30% 60% 80% 
#         33  40  47



#QUESTION 4 #################################################################

balance <- jobs[, c("Balance")]
balance

high_low <- c(balance)
sort(high_low)
# Answer:  [1]    11.52    21.03    69.01    69.78    77.46    96.26    98.68   114.69   133.75
#[10]   134.94   152.91   168.18   177.28   239.45   242.49   245.46   251.67   267.38
#[19]   279.01   311.26   339.23   342.64   354.04   361.64   368.53   399.51   401.13
#[28]   422.94   466.01   614.71   625.07   640.91   655.36   675.08   677.88   680.55
#[37]   682.97   690.99   699.42   701.13   704.83   717.13   740.20   743.29   747.35
#[46]   781.84   837.33   840.88   875.27   879.78   899.97   916.89   918.56   919.10
#[55]   919.39   919.95   920.31   920.87   926.29   964.10   988.73   997.01  1009.69


job_subsets <- subset(jobs, select = c("Balance","Job.Classification"))
job_subsets

#QUESTION 5 #################################################################

engalnd=subset(jobs,Region=='England',select=c(Balance>100000))
engalnd


#QUESTION 6 #################################################################

library(nycflights13)
fl =flights
fl

sched_time <- fl[, c("sched_arr_time")]
air_time <- fl[, c("arr_time")]

delay_time <- sched_time - air_time

del_time <- cbind(fl, delay_time)



