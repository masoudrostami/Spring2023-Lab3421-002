setwd('/Users/Khoatruong/DATA3421/Homework 3')
getwd()
list.files()

###QUESTION 1:###
Matrix1 <- matrix(runif(36, min = 0, max = 30), nrow = 3, ncol = 12)
Matrix1
colMeans(Matrix1)

###Question 2:###

require(moments)
require(psych)
require(dplyr)
library(dplyr)

df<-read.csv("job.csv")
dim(df)
head(df, 3)
str(df)

sum(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)

###Question 3:###
quantile_df <- quantile(df$Age, probs = c(0.30, 0.60, 0.80))
quantile_df
str(quantile_df)
quantile_df["30%"]

df$AgeGroup[(df$Age <= quantile_df["30%"])] = "Young Adult"
df$AgeGroup[(df$Age > quantile_df["30%"]) & (df$Age < quantile_df["60%"])] = "Middle-aged Adult"
df$AgeGroup[(df$Age >= quantile_df["60%"]) & (df$Age < quantile_df["80%"])] = "Middle-aged Adult"
df$AgeGroup[(df$Age >= quantile_df["80%"])] = "Old Adult"

View(df)

##Question 4:###
dfsortedBalance<-df[order(-df$Balance),]
View(dfsortedBalance)

sub_cols <- c("Balance", "Job.Classification")
df_subset <- dfsortedBalance[sub_cols]
View(df_subset)

##Question 5:###
dfEngland <- filter(df, (Region == "England") & (Balance > 100000))
View(dfEngland)

##Question 6:###
##install.packages("nycflights13")
##library(nycflights13)

View(flights)
names(flights)
?flights

flights$delaytime <- (flights$arr_time - flights$sched_arr_time)
##Check if we did it correctly
View(flights[c("arr_delay", "delaytime")])
