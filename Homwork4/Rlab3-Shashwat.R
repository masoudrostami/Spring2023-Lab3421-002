# A
# Install Packages
install.packages("Hmisc")
install.packages("ggm")
install.packages("polycor")
library(Hmisc)
library(ggm)
library(polycor)
## 1.
install.packages("readxl")
library("readxl")
dfw<-read_excel("winequality.xlsx")
str(dfw)
View(dfw)
names(dfw)
head(dfw)
# creating correlation matrix
cor(dfw$alcohol,dfw$quality,method = "spearman")
## The relationship between alcohol content and winequality is weak as the correlation value is 0.44.
## It does not have a linear relationship.

## 2. 
# creating a boxplot
boxplot(sulphates~type, data=dfw,main="Sulphates VS Type", xlab = "Type", ylab = "Sulphates")
## white wine has overall less sulphate concentration than red wine. Also, it can be seen that red wine has a large variation in sulphate concentration than white wine.

## 3.
install.packages("car")
library(car)
# creating a histogram
hist(dfw$quality,main="Wine Quality", xlab = "Quality Rating", ylab = "Frequency")
head(dfw)
## The distribution of wine quality ratings is approximately normal. 

## 4. 
# creating subsets of dfw dataset
names(dfw)
dfw1<-subset(dfw,quality>6,select=c('quality','fixed acidity'))
dfw2<-subset(dfw,quality>6,select=c('quality','volatile acidity'))
dfw3<-subset(dfw,quality>6,select=c('quality','pH'))
dfw4<-subset(dfw,quality>6,select=c('quality','chlorides'))
dfw5<-subset(dfw,quality>6,select=c('quality','free sulfur dioxide'))
dfw6<-subset(dfw,quality>6,select=c('quality','sulphates'))
dfw7<-subset(dfw,quality>6,select=c('quality','citric acid'))
dfw8<-subset(dfw,quality>6,select=c('quality','total sulfur dioxide'))
dfw9<-subset(dfw,quality>6,select=c('quality','alcohol'))
dfw10<-subset(dfw,quality>6,select=c('quality','residual sugar'))
dfw11<-subset(dfw,quality>6,select=c('quality','density'))
par(mfrow=c(4,3))
# c reating scatterplot matrix
plot(dfw1$quality,dfw1$`fixed acidity`,pch=16,main="Quality VS Fixed Acidity", xlab = "Quality", ylab = "fixed acidity")
plot(dfw2$quality,dfw2$`volatile acidity`,pch=16,main="Quality VS Volatile Acidity", xlab = "Quality", ylab = "volatile acidity")
plot(dfw3$quality,dfw3$pH,pch=16,main="Quality VS pH", xlab = "Quality", ylab = "pH")
plot(dfw4$quality,dfw4$chlorides,pch=16,main="Quality VS Chlorides", xlab = "Quality", ylab = "Chlorides")
plot(dfw5$quality,dfw5$`free sulfur dioxide`,pch=16,main="Quality VS Free Sulfur Dioxide", xlab = "Quality", ylab = "Free Sulfur Dioxide")
plot(dfw6$quality,dfw6$sulpahtes,pch=16,main="Quality VS Sulphates", xlab = "Quality", ylab = "Sulphates")
plot(dfw7$quality,dfw7$`citric acid`,pch=16,main="Quality VS Citric Acid", xlab = "Quality", ylab = "Citric Acid")
plot(dfw8$quality,dfw8$`total sulfur dioxide`,pch=16,main="Quality VS Total Sulfur Dioxide", xlab = "Quality", ylab = "Total Sulfur Dioxide")
plot(dfw9$quality,dfw9$`alcohol`,pch=16,main="Quality VS Alcohol", xlab = "Quality", ylab = "Alcohol")
plot(dfw10$quality,dfw10$`residual sugar`,pch=16,main="Quality VS Residual Sugar", xlab = "Quality", ylab = "Residual Sugar")
plot(dfw11$quality,dfw11$density,pch=16,main="Quality VS Density", xlab = "Quality", ylab = "Density")
# creating correlation matrix
cor(dfw1$quality,dfw1$`fixed acidity`,method = "spearman")
cor(dfw2$quality,dfw2$`volatile acidity`,method = "spearman")
cor(dfw3$quality,dfw3$pH,method = "spearman")
cor(dfw4$quality,dfw4$chlorides,method = "spearman")
cor(dfw5$quality,dfw5$`free sulfur dioxide`,method = "spearman")
cor(dfw6$quality,dfw6$sulphates,method = "spearman")
cor(dfw7$quality,dfw7$`citric acid`,method = "spearman")
cor(dfw8$quality,dfw8$`total sulfur dioxide`,method = "spearman")
cor(dfw9$quality,dfw9$alcohol,method = "spearman")
cor(dfw10$quality,dfw10$`residual sugar`,method = "spearman")
cor(dfw11$quality,dfw11$density,method = "spearman")
## From the scatter plot and correlation we can see that the relationship between the chemical properties and higher wine quality rating greater than 6 is weak.
## Only alcohol content has better positive correlation than other properties with quality rating.

# B
## 1.
# Using Chi Squared Test
chisq.test(dfw$alcohol,dfw$quality)
## The p-value is less than 0.05, so we reject the null hypothesis.Therefore, there is significant difference in alcohol content across different wine quality ratings.

## 2. 
# creating subsets of dfw dataset
dfw12<-subset(dfw,type == 'red',select=c('alcohol','type'))
dfw13<-subset(dfw,type == 'white',select=c('alcohol','type'))
View(dfw12)
# Using a t-test
t.test(dfw12$alcohol,dfw13$alcohol,var.equal = TRUE)
## The p-value is less than 0.05. So, we reject the null hypothesis. Therefore, there is significant difference in alcohol content between red wine and white wine.

## 3. 
# creating subsets of dfw dataset
dfw14<-subset(dfw,quality >=6 ,select=c('quality','pH')) # high quality
dfw15<-subset(dfw,quality < 6,select=c('quality','pH')) # low quality
# Using a t-test
t.test(dfw14$pH,dfw15$pH,var.equal = TRUE)
## The p-value is greater than 0.05, So, we cannot reject the null hypothesis. Therefore, there is not significant difference  in pH levels between high-quality and low-quality wines.
