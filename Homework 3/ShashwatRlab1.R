# install.packages("tidyverse")
library(tidyverse)


#install.packages("dplyr") 
library(dplyr)

#install.packages("tidyr")

library(tidyr)

#install.packages("ggplot2") 
library(ggplot2)  

# Q1

a<-matrix(1:36, nrow=3, ncol=12)
a 

apply(a,2,mean)

# Q2

install.packages("psych")
library(psych)
library(dplyr)
library(reshape2)
library(pastecs)

job <- read_csv("~/datasets/job.csv")
sum(job$Balance)
mean(job$Balance)
median(job$Balance)
sd(job$Balance)
skew(job$Balance)
quantile(job$Balance)
kurtosi(job$Balance)
var(job$Balance)
quantile(job$Age, probs = seq(0,1, 1/10))

# Q3
job$Age[job$Age>=47] <- "Old Adult"
job$Age[job$Age<= 33 ] <- "Young Adult"
job$Age[job$Age<47&job$Age>33] <- "Middle-Aged Adult"

# Q4
job<-job[order(job$Balance),]
job1<-subset(job,select=c('Balance','Job Classification'))
View(job1)

# Q5
job2<-subset(job,Region=='England'& Balance>100000,select=c('Region','Balance'))
View(job2)

# Q6
install.packages("nycflights13")
library(nycflights13)

View(flights)

flights<-mutate(flights, delay_time=arr_time-sched_arr_time)
View(flights)
