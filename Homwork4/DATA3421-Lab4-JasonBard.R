## I recommend turning word-wrap on by selecting Code > Soft Wrap Long Lines.

setwd("C:/Users/j4yb1/OneDrive - University of Texas at Arlington/Documents/spring2023/data3421")
getwd()

#install.packages('xlsx')
#install.packages('corrplot')
library(tidyverse);library(xlsx);library(ggplot2);library(corrplot)

wine = read.xlsx('Labs/Lab4/winequality.xlsx', sheetName='winequality')
View(wine)

## A1: Is there a relationship between alcohol content and wine quality?

# Plotting a 'scatter' plot of alcohol content and wine quality
plot(wine$alcohol, wine$quality, xlab = 'Alcohol', ylab = 'Quality')

## There does not visually appear to be any relationship between them given this simple scatter plot.

## A2: How does red wine's sulphate concentration compare to white wine? A box plot can be created.

#Taking red and white subsets
Red = subset(wine, type == "red"); White = subset(wine, type == "white")

#Making both boxplots
boxplot(Red$sulphates, White$sulphates, ylab = "Sulphates", names = c('Red','White'))

## There may be a relationship between the sulphate concentration and the color of the wine. Visually, it appears that red wine has more sulphates than white wine.

## A3: What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.

# Making a histogram of wine qualities
hist(wine$quality, xlab = "Wine Quality", main = "Frequency of Wine Qualities", freq = TRUE)

## While I can't get the histogram to line up exactly so that the ticks are at the center of the bars, I believe that it's safe to say that the wine qualities are about normally distributed.

## A4: Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.

# Subsetting the original dataset, removing 'type' to make it all numeric.
wine2 = subset(wine, select = 1:12)
View(wine2)

# Forming a correlation matrix using corrplot
cor_data = cor(wine2)
corrplot(cor_data, method="color")

## Visually, it appears like alcohol content has a positive correlation with the quality of the wine. On the other hand, it also appears that chlorides and volatile acidity have a negative correlation with wine quality, as does density.


## B1: Is there a significant difference in alcohol content across different wine quality ratings?

#Taking the chi-squared test of these two variables.
chisq.test(wine$alcohol, wine$quality)

## Since the p-value is less than 0.05, we will reject our null hypothesis. Since our null hypothesis is that there is no significant difference between these groups, we must conclude that there is a significant difference in alcohol content across different wine quality ratings.

## B2: Is there a significant difference in alcohol content between red wine and white wine?

# Checking the variance
var(Red$alcohol)
var(White$alcohol)

# Checking to see if they're normally distributed
shapiro.test(Red$alcohol)
shapiro.test(White$alcohol)

qplot(Red$alcohol)
qplot(White$alcohol)

#Running the t-test
t.test(Red$alcohol, White$alcohol, var.equal=TRUE)

# The p-value is less than 0,05, meaning we must reject our null hypothesis. In this case, our null hypothesis is that the variances are equal, which would mean that there is not a significant difference between types of wines. However, given the alternative, we should conclude that there is a significant difference in alcohol content between these two different types of wine.

## B3: Is there a significant difference in pH levels between high-quality and low-quality wines?

# Separating the two categories into two separate datasets
highqual = subset(wine, quality >= 6)
lowqual = subset(wine, quality < 6)

# Allowing the user to view these datasets
View(lowqual)
View(highqual)

# Running the t-test over these two groups
t.test(highqual$pH, lowqual$pH, var.equal = TRUE)

# Since the p-value is greater than 0.05, we fail to reject our null hypothesis. Therefore, we must conclude that, given this data, there is no significant difference in pH levels between high-quality and low-quality wines.