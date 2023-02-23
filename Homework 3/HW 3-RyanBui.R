#install.packages("tidyverse")
library(tidyverse)
#install.packages("dpylyr")
library(dplyr)
#install.packages("tidyr")
library(tidyr)
#install.packages("ggplot2") 
library(ggplot2)  
#install.packages("psych")
library(psych)
#install.packages("dplyr")
library(dplyr)
#install.packages("reshape2")
library(reshape2)
#install.packages("pastecs")
library(pastecs)
#install.packages("e1071")
library(e1071)

## Problem 1 ##
a <- matrix(c(1,3,5,7,8,12), nrow = 3, ncol = 12)
means <- colMeans(a)
print(means)

## Problem 2 ##
df <- read.csv(file = "/users/buiry/downloads/job.csv")

mean(df$Balance)
median(df$Balance)
sd(df$Balance)
sum(df$Balance)
quantile(df$Balance)
var(df$Balance)
skewness(df$Balance)
kurtosis(df$Balance)

## Problem 3 ##
quantile(df$Age, probs = c(0.30, 0.60, 0.80))
df$Age[df$Age<=33]="Young Adult"
df$Age[df$Age>33 & df$Age<47]="Middle-Aged Adult"
df$Age[df$Age>=47]="Old Adult"

## Problem 4 ##
df2<-df[order(-df$Balance),]
df3<-subset(df2, select = c(Balance, Job.Classification))

View(df3)


##Problem 5 ##

df4<-subset(df2, select = c(Balance, Region))

            