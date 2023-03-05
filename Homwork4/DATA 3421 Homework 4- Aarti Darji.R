install.packages('car')
install.packages("corrplot")
library(corrplot)
library(readxl)
library(car)
library(multcomp)
library(yarrr)
library(tidyr)
library(tidyverse)

wq<-read_excel("winequality.xlsx")
head(wq)
colnames(wq)

cor(wq$alcohol,wq$quality,method = "pearson")
#there is a positive correlation between alcholo and quality

boxplot(sulphates~type, data=wq,main="Sulphates VS Type", xlab = "Type", ylab = "Sulphates")
#white wine has a lower concentration of sulphates

hist(wq$quality,main="Wine Quality", xlab = "Quality Rating", ylab = "Frequency")
#the ditrubution looks normal

wq2 = subset(wq, select = 1:12)
View(wq2)

cordata = cor(wq2)
corrplot(cordata)

#q1 for hyposthesis testing
chisq.test(wq$alcohol,wq$quality)
# we reject null hypothesis

#q2 
t.test(alcohol~type, data = wq, var.equal = TRUE)
#there is significant difference between red and white wine

#q3 
wq$quality[wq$quality>=5] = "high quality"
wq$quality[wq$quality<5] = "low quality"

t.test(pH~quality, data = wq, var.equal = TRUE)
#there is no significant difference so we don't reject null hypothesis


