#Lasta Maharjan

library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(e1071)

#Question1 

a_matrix<- matrix(1:36, nrow=3, ncol=12)
a_matrix
apply(a_matrix,2,mean)

#Question2
#setwd("/C:/Users/Lasta Maharjan/Desktop/Spring 2023/Data Mining/Lab3")
df<-read.csv("job.csv")
summary(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)
var(df$Balance)

#Question3
quantile(df$Age,prob=c(0.3,0.6,0.8))
df$age_title[df$Age<=33]="Young Adult"
df$age_title[df$Age>33&df$Age<=40]="Middle-aged Adult"
df$age_title[df$Age>40]="Old Adult"

#chnaging_the categories 
df$Age=df$age_title
df
df <- df[, -ncol(df)]
df #new df

#Question 4
df <- df[order(-df$Balance),]
df
new_subset=subset(df,select=c(4,5))
new_subset

#Question 5
subset_df <- subset(df, Region == "England" & Balance > 100000)
subset_df


#Question 6
library(nycflights13)
flights$delay_time<- flights$arr_time - flights$sched_arr_time
flights
flights$delay_time






