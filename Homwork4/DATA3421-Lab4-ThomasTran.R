## Thomas Tran Lab 4

library(ggplot2)
library(readxl)
library(dplyr)

df = read_excel("winequality.xlsx")


## Data Visualization


###########################
## 1) Is there a relationship between alcohol content and wine quality?

names(df)
p<-ggplot(data=df,aes(x=alcohol,y=quality))

p+geom_point(colour="DarkGreen")

## Based on the scatterplot, there does not appear to be a relationship between alcohol content and wine quality

###########################
## 2) How does red wine's sulfate concentration compare to white wine?
## A box plot can be created.

boxplot(sulphates~type,data=df,pch=19)

## white wine appears to have a lower sulfate concentration compared to red wine

##########################
## 3) What is the distribution of wine quality ratings?

hist(df$quality)

## The distribution of wine quality appears to be normally distributed around 6.

##########################
## 4) Are specific chemical properties more strongly associated with higher-quality wines?

high_qual=filter(df,quality>7)
cor(high_qual[,-12:-13],high_qual[,12])

## There seems to be a low correlation between the chemical properties and high quality wines

## Hypothesis Testing


#########################
## 1) Is there a significant difference in alcohol content across different wine quality ratings?

low_qual = filter(df,quality<5)

t.test(low_qual$alcohol,high_qual$alcohol,var.equal=TRUE)

## With a p-value<0.05 there does seem to be a difference in alcohol content across different wine qualities

#########################
## 2) Is there a significant difference in alcohol content between red wine and white wine?
red = filter(df,type=='red')
white = filter(df,type=='white')
t.test(red$alcohol,white$alcohol,var.equal=TRUE)

## With p-value<0.05 we can reject the null hypothesis and say that there
## is a significant diffence between red and white wine with at least 95% confidence

#########################
## 3) Is there a significant difference in pH levels between high-quality and low-quality wines?

t.test(high_qual$pH,low_qual$pH,var.equal = TRUE)

## with p-value>0.05 there is not enough statistical evidence to suggest that
## there is a difference in pH levels between high and low quality wine we fail to reject the null-hypothesis