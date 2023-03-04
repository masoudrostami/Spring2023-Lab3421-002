library(tidyverse)
library(readxl)
library(here)
library(ggplot2)

winequality <- read_excel(here("winequality.xlsx"))
winequality

head(winequality,5)
str(winequality)
summary(winequality)
names(winequality)
unique(winequality)

###A###

## 1. Is there a relationship between alcohol content and wine quality?

#Correlation
cor(winequality$alcohol,winequality$quality,method = "pearson")
## Using the pearson correlation method, we can conclude that there is a moderate positive correlation between alcohol and quality giving us a value of ~0.4443185.

##2. How does red wine's sulfate concentration compare to white wine? A box plot can be created.
boxplot(sulphates~type, data=winequality, main="Type vs Sulphates",xlab='type',ylab='sulphates')
## White wine's sulphate concentration is realtively low compared to red wine's sulphate concentration. 

##3. What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.
hist(winequality$quality , main="Wine Quality Ratings", xlab='Quality', ylab ='Frequency')
## The distribution of wine quality ratings appears to be normally distributed.

##4 Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.

#Correlation:
cor(winequality$quality>=6,winequality$"fixed acidity",method = "spearman")
cor(winequality$quality>=6,winequality$"volatile acidity",method = "spearman")
cor(winequality$quality>=6,winequality$"citric acid",method = "spearman")
cor(winequality$quality>=6,winequality$"chlorides",method = "spearman")
cor(winequality$quality>=6,winequality$"free sulfur dioxide",method = "spearman")
cor(winequality$quality>=6,winequality$"total sulfur dioxide",method = "spearman")
cor(winequality$quality>=6,winequality$"density",method = "spearman")
cor(winequality$quality>=6,winequality$"pH",method = "spearman")
cor(winequality$quality>=6,winequality$"sulphates",method = "spearman")
cor(winequality$quality>=6,winequality$"alcohol",method = "spearman")
## According to the correlation matrix, we can conclude that specific chemical properties aren't strongly associated with higher-quality wine.Overall, they have a weak correlation.

###B###
#1. Is there a significant difference in alcohol content across different wine quality ratings?

#Uisng Pearson's Chi-squared Test:
chisq.test(winequality$alcohol,winequality$quality)
# The p-value is less than 0.05.Therefore, we reject our null hypothesis. We also conclude that there is significant difference in alcohol content across different wine quality ratings. 

#2. Is there a significant difference in alcohol content between red wine and white wine?

#Using t-test:
t.test(winequality$type=="red",winequality$type=="white", var.equal = TRUE)
# The p-value is less than 0.05.Therefore, we reject our null hypothesis. We also conclude that there is significant difference in alcohol content between red wine and white wine

#3. Is there a significant difference in pH levels between high-quality and low-quality wines?

winequality$quality[winequality$quality>=6] = "high"
winequality$quality[winequality$quality<6] = "low"

#Using t-test:
t.test(pH~quality,data = winequality,var.equal = TRUE)
## The p-value is grater than 0.05.Therefore, we reject our null hypothesis. We also conclude that there isn't significant difference in  pH levels between high-quality and low-quality wines.


