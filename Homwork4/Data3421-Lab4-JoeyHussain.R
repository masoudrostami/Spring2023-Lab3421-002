############ Install and Check Packages
library("tidyverse")
library("ggplot2")
library(Hmisc)
library(ggm)
library(polycor)
library(readxl)
library(car)
library(multcomp)
library(yarrr)
library("tidyr")
library(corrplot)

############# Import Datasets

df<-read_excel("winequality.xlsx")
head(df)


#A: Data Visualization: you have to use different data visualization 
# techniques to answer these questions. 


# Is there a relationship between alcohol content and wine quality?

# Check correlation
cor(df$alcohol,df$quality,method = "pearson")

cor(df$alcohol,df$quality,method = "spearman")

# 2x2 visualization grid
par(mfrow=c(2,2))

#plot three kinds of graphs to see relationship
boxplot(df$alcohol~df$quality,data=df,theme = 1,
        main = "alcohol vs quality",xlab = "alcohol",ylab= "quality",point.pch = 2,
        point.col = "red")

pirateplot(alcohol~quality,data=df,theme = 1,
           main = "alcohol vs quality",xlab = "alcohol",ylab= "quality",point.pch = 2,
           point.col = "red")

plot(df$alcohol,df$quality,main = "alcohol vs quality",xlab = "alcohol",ylab= "quality")


## 
## Looking at the graphs as well as the correlation there seems to be a fairly
## strong relationship between the alcohol content and the wine quality
##


# How does red wine's sulfate concentration compare to white wine? A box plot can be created.
# create a 1x1 grid
par(mfrow=c(1,1))
# create a box plot for sulfate and red and white wine
boxplot(df$sulphates~df$type,main = "red wine vs white wine sulfate",xlab = "Type",ylab= "Sulfate")

## 
## Red wine has a higher sulfate concentration compared to white wine.
##


# What is the distribution of wine quality ratings? A histogram or bar plot
# could be created to visualize the frequency of different quality ratings.
# 1x1 grid
par(mfrow=c(1,1))

# boxplot
boxplot(df$quality)

#histogram
h<-ggplot(data=df,aes(x=quality))
h+geom_histogram(binwidth = 1)


##
## Looking at the boxplot and the histogram graphs the distribution of wine quality
## appears to be normally distributed as the most common quality is in the middle of all
## of the variables
##


# Are specific chemical properties more strongly associated with higher-quality
# wines? A correlation or scatterplot matrix could explore the relationships
# between chemical properties and wine quality ratings.

# 1x1 grid
par(mfrow=c(1,1))

# code to get rid of non numeric values in df and plot
corrplot(cor(df[, unlist(lapply(df, is.numeric))]))

##
## From the scatter plot we can see that alcohol content, low density, low chloride, and
## low volatile acidity is where there is higher quality.
##



#B: Hypothesis Testing:

#Is there a significant difference in alcohol content across different wine quality ratings?

# Anova needs to be performed since we are seeing the relationship
# between  alcohol content (Continuous) and wine quality ratings(Multiple Categories).

#create anova model
names(df)
model<-aov(alcohol~quality,data=df)

# 1x1 grid
par(mfrow=c(1,1))

# boxplot
boxplot(alcohol~quality, data = df)

#create a summary to see hypothis test relationship
peg_aov<-aov(alcohol~quality,data=df)
summary(peg_aov)


##
## There appears to be a slight difference in alcohol content against wine ratings
## As shown from the hypothesis testing and graphs.
##

#Is there a significant difference in alcohol content between red wine and white wine?

# Independent samples t-test needs to be performed since we are seeing the relationship
# between  alcohol content (Continuous) and one categorical with two categories

t.test (alcohol ~ type, var.equal=TRUE, data = df)

##
## Since the p-value is less than normal alpha we can reject the null value that
## the true difference in means is equal to 0
##

#Is there a significant difference in pH levels between high-quality and low-quality wines?

# Independent samples t-test needs to be performed since we are seeing the relationship
# between  alcohol content (Continuous) and one categorical with two categories

var(df$pH)

#create two categorical variables for high and low quality wine based off quantile
quantile(df$quality)
df$quality[df$quality >= 6] = "High Quality"
df$quality[df$quality < 6] = "Low Quality"
View(df)

#perform the t-test
t.test (alcohol ~ quality, var.equal=TRUE, data = df)

##
## Since the p-value is less than normal alpha we can reject the null value that
## the true difference in means is equal to 0
##


















































