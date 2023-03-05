# install.packages("tidyverse")
library(tidyverse)



#install.packages("dplyr") 
install.packages("dplyr")
library(dplyr)

#install.packages("tidyr")

library(tidyr)

#install.packages("ggplot2") 
library(ggplot2)

### A####
setwd("~/Downloads")

df <- read.csv("winequality.csv")
head(df,10)
#####A: Data Visualization: you have to use different data visualization techniques to answer these questions. 
###Is there a relationship between alcohol content and wine quality? 
####We find correlation value to find an answer for this question
install.packages("Hmisc");install.packages("ggm");install.packages("polycor")

library(Hmisc);library(ggm);library(polycor)
cor(df$alcohol ,df$quality,method = "pearson")
####The correlation value was 0.4443185 which means they are moderately correlated#
###We can also plot scatter plot to see their correlation
plot(df$alcohol, df$quality, xlab= "Alcohol Content", ylab = "Wine Quality")
#############################################################################
###How does red wine's sulfate concentration compare to white wine? A box plot can be created.
###We plot box plot to compare concentration of sulfate in the red and white wine
red_type <- subset(df, type == "red")
white_type <- subset(df, type == "white")

boxplot(red_type$sulphates, white_type$sulphates,
        names = c("Red", "White"),
        xlab = "Type of Wine", ylab = "Sulfate concentration in the wine"
        )
###########################################################################
###What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings
#####We can use histogram to visualize the frequency of different quality ratings
wine_quality <- df$quality
hist(wine_quality, xlab = "Quality Ratings")
#################################################################################
###Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.

chemical_properties <- df[, c("fixed.acidity", "volatile.acidity", "citric.acid", "residual.sugar", "chlorides", "free.sulfur.dioxide", "total.sulfur.dioxide", "density", "pH", "sulphates", "alcohol")]
quality <- df$quality
#  scatterplot matrix
pairs(chemical_properties, main = "Scatterplot Matrix of Chemical Properties and Wine Quality Ratings")
#########################################################################
###B: Hypothesis Testing:
##Is there a significant difference in alcohol content across different wine quality ratings?
# Using ANOVA test for testing hypothesis
model <- aov(alcohol ~ quality, data = df)
summary(model)
###############################################################################
####Is there a significant difference in alcohol content between red wine and white wine?


red_type <- subset(df, type == "red")
white_type <- subset(df, type == "white")

shapiro.test(red_type$alcohol)
shapiro.test(white_type$alcohol)


t.test(red_type$alcohol, white_type$alcohol, var.equal = TRUE)
#################################################################################
###Is there a significant difference in pH levels between high-quality and low-quality wines?
###We perform ANOVA test

good_quality <- subset(df, df$quality >= 7)
bad_quality <- subset(df, df$quality < 7)

test_pH <- aov(pH ~ quality, data = df)
summary(test_pH)
