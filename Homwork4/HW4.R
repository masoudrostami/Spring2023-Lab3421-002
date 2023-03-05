# setwd("D:/Downloads")
# install.packages("tidyverse")

library(tidyverse)
library(ggplot2)

# import data set
## library("readxl")
## wine=red_excel("path")


file.choose()

wine = readxl::read_xlsx(path = "D:\\Downloads\\winequality.xlsx")

View(wine)
head(wine,3)
summary(wine)

### Part 1
### A: Data Visualization: you have to use different data visualization techniques to answer these questions. 
### 1. Is there a relationship between alcohol content and wine quality?
cor.test(wine$alcohol,wine$quality)
cor(wine$alcohol,wine$quality,method = "pearson")
qplot(wine$alcohol)
qplot(wine$quality)

# the correlation between alcohol and wine quality is 0.44, it means there is a moderate relationship between these two variables


### 2. How does red wine's sulfate concentration compare to white wine? A box plot can be created.
unique(wine$type)

red = subset(wine, type =="red", select=c(sulphates,type))
View(red)
boxplot(red$sulphates, main="Red wine's sulfate concentration", ylab="sulfate concentration")
summary(red)

white = subset(wine, type =="white", select=c(sulphates,type))
View(white)
boxplot(white$sulphates, main="white wine's sulfate concentration", ylab="sulfate concentration")
summary(white)

# the average sulfate concentration for red wine is 0.6581, and white wine is 0.4898. The median for red wine = 0.62, for white wine = 0.47. Based off the mean and median, the red wine have a higher sulfate concentration.


### 3. What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.
qplot(wine$quality)
hist(wine$quality, main = "Histogram of the wine quality", xlab = "Wine quality", ylab = "Frequency")
shapiro.test(wine$quality[0:5000])
qqnorm(wine$quality)
qqline(wine$quality, col="red")


# Based off the histogram, the distribution of the wine quality appeared to be a normal distribution. 
# And in the shapiro test, w=0.885, p-value is < 2.2 x 10 ^-16, which the p-value<0.05, so that there is a significant different from normal distribution, so we cannot assume the normality.
# And based of the qqnorm graph, the scatterplot does not appeared to form a straight linear line, so our assumption of normality does not meet.


### 4. Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.
# import car library for scatter plotmatrix
# install.packages("car")
library(car)

# subsetting only chemical varaibles and quality
chemical = subset(wine, select=c(1:12))
View(chemical)
# scatterplotMatrix(chemical)
cor(chemical)

# could not run scartterplot matrix because it will break the kernel.
# so I used correlation matrix instead. 
# based on the correlation matrix, alcohol appeared to have a correlation of 0.44 with wine quality, some the other variables like fixed acidity,residual sugar have negative correlation, and others like citric acid and pH tend to be very small positive correlation. 


### Part 2
### B: Hypothesis Testing:
### 1. Is there a significant difference in alcohol content across different wine quality ratings?
# Null Hypothesis: there is no significant difference in alcohol content and different wine quality rating. 
# Alternative Hypothesis : there is a significant difference 

# checking the variance
var(wine$alcohol)
var(wine$quality)
shapiro.test(wine$alcohol[0:5000])
shapiro.test(wine$quality[0:5000])
# not normally distributed

qplot(wine$alcohol)
# the plot seems right skewed

qplot(wine$quality)
t.test(wine$alcohol, wine$quality, var.equal = TRUE)
# since the p-value is very small, 2.2x10^-16, meaning the alcohol content and wine quality are dependent of each other 

### 2. Is there a significant difference in alcohol content between red wine and white wine?
# Null Hypothesis: there is no significant difference in alcohol content between red wine and white wine. 
# Alternative Hypothesis : there is a significant difference.
red_alcohol = subset(wine, type =="red", select=c(alcohol,type))
View(red_alcohol)
qplot(red_alcohol$alcohol)
summary(red_alcohol$alcohol)
shapiro.test(red_alcohol$alcohol)

white_alcohol = subset(wine, type =="white", select=c(alcohol,type))
View(white_alcohol)
qplot(white_alcohol$alcohol)
shapiro.test(white_alcohol$alochol)

t.test(red_alcohol$alcohol, white_alcohol$alcohol, var.equal = TRUE)
# Since the p-value = 0.0078, it is less than 0.05, therefore we can reject the null hypothesis, and there's a significant difference in alcohol content between red and white wine. 


### 3. Is there a significant difference in pH levels between high-quality and low-quality wines?
unique(wine$quality)
summary(wine$quality)
max(wine$quality) #9
min(wine$quality) #3
# wine quality:  3 4 5 6 7 8 9

# subseting low and high quality. low quality is less than 6, high quality if greater and including 6
low = subset(wine, quality < 6)
low_ph_quality = subset(low, select=c(pH, quality))
View(low_ph_quality)

high = subset(wine, quality >= 6)
high_ph_quality = subset(high, select=c(pH, quality))
View(high_ph_quality)

t.test(low_ph_quality$pH, high_ph_quality$pH, var.equal = TRUE)

# The p-value = 0.1289, and this value is greater than 0.05, therefore we cannot reject the null hypothesis and conclude there's no significant difference between pH level in different wine quality.



