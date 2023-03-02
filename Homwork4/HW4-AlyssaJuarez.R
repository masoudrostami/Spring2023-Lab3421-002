
########################################### PART A

########### Installing packages

library(tidyverse)
library(ggplot2)

### Is there a relationship between alcohol content and wine quality?
str(winequality)

install.packages("Hmisc")
install.packages("ggm")
install.packages("polycor")
library(Hmisc)
library(ggm)
library(polycor)

cor(winequality$alcohol, winequality$quality, method = "pearson")

cor(winequality$alcohol, winequality$quality, method = "spearman")

#Response:
#the correlation is positive and low (~.4469255) 

###How does red wine's sulfate concentration compare to white wine? A box plot can be created.

par(mfrow=c(1,1))
boxplot(sulphates~type, data=winequality)

#Response:
# Red wine has more sulphates on average than white wine.

### What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.

qplot(winequality$quality)

#Reponse:
# There appears to be a fairly normal distribution. 


################################################# PART B

### Is there a significant difference in alcohol content across different wine quality ratings?
t.test(winequality$alcohol, winequality$quality, var.equal = TRUE)

#Response:
# There is a significant difference. Therefore we reject the null.



### Is there a significant difference in alcohol content between red wine and white wine?
t.test(alcohol~type, data = winequality, var.equal = TRUE)

#Reponse:
#There is a significant difference. Therefore we reject the null.



### Is there a significant difference in pH levels between high-quality and low-quality wines?
winequality$quality[winequality$quality>=5] = "high quality"
winequality$quality[winequality$quality<5] = "low quality"

t.test(pH~quality, data = winequality, var.equal = TRUE)

#Response: 
#We cannot conclude that a significant difference exists. Therefore we do not reject the null hypothesis.




