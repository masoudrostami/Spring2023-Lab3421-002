
##Question:1 Creating a matrix with three 12 and 8 columns and calculating the means for each column of the matrix?

b<-matrix(1:36, 3, 12)
b

apply(b,2,mean) 

##Question:2 Calculate sum, mean, median, standard deviation, skewness, quantile,kurtosis, and variance for variable “Balance” in the job dataset.

df<-read.csv("/Users/meghabista/job.csv")
df

#install.packages("moments")
#library(moments)

sum(df$Balance)
mean(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)
var(df$Balance)

##Question:3 Recode the “Age” variable to three categories of “Young Adult”, “Middle-aged Adult”, and “Old Adult”, based on quantiles of 30%, 60%, and 80%.


quantile(df$Age,prob=c(0.3,0.6,0.8))
df$New_Age[df$Age<=33]="Young Adult"
df$New_Age[df$Age>33&df$Age<=40]="Middle-aged Adult"
df$New_Age[df$Age>40]="Old Adult"
df


##Question:4 Sort the “Balance” variable from high to low in the job dataset and create a new subset of the dataset with just Balance and Job Classification variables.

df[order(df$Balance,decreasing=TRUE),]

df_subset <- df[, c("Balance", "Job.Classification")]
df_subset

##Question:5 Subset the job dataset with just the England region and with a balance of higher than 100,000

df_subset2 <-df[df$Region == "England", ]

df_subset2_Eng <- df_subset2[df_subset2$Balance > 100000, ]
df_subset2_Eng

##Question:6 Using the flights dataset, create a new variable using existing variables(arr_time and sched_arr_time) and call it delay time.

install.packages("nycflights13")
library(nycflights13)
View(flights)

#install.packages("dplyr")
#library(dplyr)

flights<-mutate(flights,delay_time=arr_time-sched_arr_time)
View(flights)


