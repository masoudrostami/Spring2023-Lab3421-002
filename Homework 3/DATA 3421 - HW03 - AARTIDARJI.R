getwd()

m<-matrix(1:36, nrow=3, ncol=12)
m

colMeans(m)

job<-read.csv("C:\\Users\\Aarti Darji\\OneDrive\\Documents\\job.csv")

install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
install.packages('psych')
library(psych)

sum(job$Balance)
mean(job$Balance)
median(job$Balance)
sd(job$Balance)
skew(job$Balance)
quantile(job$Balance)
kurtosi(job$Balance)
var(job$Balance)

quantile(job$Age, probs = seq(0,1, 1/10))
job$Age[job$Age>=47] <- "Old Adult"
job$Age[job$Age<= 33 ] <- "Young Adult"
job$Age[job$Age<47&job$Age>33] <- "Middle-Aged Adult"

job<-job[order(job$Balance),]
job1<-subset(job,select=c('Balance','Job Classification'))
job1

job_2<-job[job$Region == "England", ]

job_2_Eng <- job_2[job_2$Balance > 100000, ]
job_2_Eng

install.packages("nycflights13")
library(nycflights13)
View(flights)

flights<-mutate(flights,delay_time=arr_time-sched_arr_time)
View(flights)
