# install.packages("tidyverse")
library(tidyverse)

#install.packages("dplyr") 
library(dplyr)
 
#install.packages("tidyr")
 
library(tidyr)

#install.packages("ggplot2") 
library(ggplot2)  

#install.packages("psych")
library(psych)
library(dplyr)
library(reshape2)
library(pastecs)

df<-read.csv("job.csv") 
head(df)

names(df)
dim(df)
str(df)
summary(df)

# 1) create a 3x12 matrix and calculate the means for each column

firstmat<-matrix(sample(10,36,replace=TRUE),ncol=12,nrow=3)
firstmat

apply(firstmat,2,mean)

# 2)

sum(df$Balance)
describe(df$Balance)
var(df$Balance)
quantile(df$Balance)

# 3)
quantile(df$Age, probs=c(0.3,0.6,0.8))

df$AgeRange[df$Age<33]="Young Adult"
df$AgeRange[df$Age>=33 & df$Age<47]="Middle-aged Adult"
df$AgeRange[df$Age>=47]="Old Adult"

head(df)

# 4)
df<-df[order(df$Balance),]
View(df)

colnames(df)

df2 <- subset(df, select=c(Balance,Job.Classification))
view(df2)

# 5)
df3 <- subset(df, Balance>100000&Region=="England")
view(df3)

# 6)
# install.packages("nycflights13")
library(nycflights13)
view(flights)

flights2 <- flights
flights2$delay_time <- (flights$sched_arr_time - flights$arr_time)

view(flights2)
