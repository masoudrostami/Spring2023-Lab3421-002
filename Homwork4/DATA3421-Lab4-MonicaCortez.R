library(ggplot2)
library(tidyverse)
library(readxl)
library(here)

wine <- read_excel(here("winequality.xlsx"))
wine

summary(wine)
head(wine,10)
names(wine)
unique(wine)
str(wine)

###A: Data Visualization: use different data visualization techniques to answer these questions.

##1. Is there a relationship between alcohol content and wine quality?
cor(wine$alcohol,wine$quality,method="pearson")
#there is a moderately positive correlation, pearson method showing it being 0.4443185, meaning there is a relationship between alcohol content and wine quality. 

##2. How does red wine's sulfate concentration compare to white wine? A box plot can be created.
boxplot(sulphates~type,data=wine, main="Wine Type vs Sulphates",xlab='wine type',ylab='sulphates')
#red wine sulfate concentration is relatively higher compared to white wine.

##3. What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.
hist(wine$quality,main="Wine Quality Ratings", xlab='Quality', ylab ='Frequency')
#the distribution of the wine quality appears to be normally distributed, with the a large distribution of rating of quality falling between 5.5-6.0

##4. Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.
cor(wine$quality>=6,wine$"fixed acidity",method = "spearman")
cor(wine$quality>=6,wine$"volatile acidity",method = "spearman")
cor(wine$quality>=6,wine$"citric acid",method = "spearman")
cor(wine$quality>=6,wine$"chlorides",method = "spearman")
cor(wine$quality>=6,wine$"free sulfur dioxide",method = "spearman")
cor(wine$quality>=6,wine$"total sulfur dioxide",method = "spearman")
cor(wine$quality>=6,wine$"density",method = "spearman")
cor(wine$quality>=6,wine$"pH",method = "spearman")
cor(wine$quality>=6,wine$"sulphates",method = "spearman")
cor(wine$quality>=6,wine$"alcohol",method = "spearman")
#There is not a chemical properties that has a stong association with higher quality wines. It could potentially be said that alcohol content may be associated with higher quality wine, but the correlation is not strong enough. 



###B:Hypothesis Testing


##1. Is there a significant difference in alcohol content across different wine quality ratings?
chisq.test(wine$alcohol,wine$quality)
#Pearson chi-squared test indicates a p-value less then 0.05, meaning that there is a difference in alcohol content across different wine quality ratings. 

##2. Is there a significant difference in alcohol content between red wine and white wine?
t.test(wine$type=="red",wine$type=="white", var.equal = TRUE)
#In the two sample t-test we get a p-value less than 0.05, meaning that there is a difference in alcohol content between red and white wine.

##3. Is there a significant difference in pH levels between high-quality and low-quality wines?
#set the marker for differences in the ratings at 6 quality rating
winequality$quality[winequality$quality>=6] = "high"
winequality$quality[winequality$quality<6] = "low"
t.test(pH~quality,data = winequality,var.equal = TRUE)
#In the two sample t-test the p-value is larger than 0.05 meaning there is there is no significant difference in pH levels between low and high quality wines.









