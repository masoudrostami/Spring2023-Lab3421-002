library(tidyverse)
library(ggplot2)
library(ggpubr)
library("readxl")
library(Hmisc);library(ggm);library(polycor)
library(multcomp)
library(plyr)

winequal <- read_excel("winequality.xlsx")

head(winequal)
str(winequal)
names(winequal)

# A)
# 1)
cor.test(winequal$alcohol, winequal$quality, method = "pearson")

p<-ggplot(data=winequal, aes(x=quality,y=alcohol))
p+geom_col()+ stat_cor(method="pearson")

# the pearson corr coeff between alcohol and wine quality
# is greater than 0.44, therefore they are highly

# 2)
winequal_white <- filter(winequal, winequal$type=="white")
view(winequal_white)

winequal_red <- filter(winequal, winequal$type=="red")
view(winequal_red)

boxplot(winequal_white$sulphates, winequal_red$sulphates)

# 3)
h <- ggplot(data=winequal, aes(x=quality,y=..density..))
h+geom_histogram(binwidth = 0.5)

# according to the histogram above, quuality is relatively normal

# 4)
winequalchems <- subset(winequal, select=c("fixed acidity", "volatile acidity","density","pH","quality"))
cor(winequalchems)

pairs(winequalchems)

# higher quality wines do not seem to have outcomes of higher valued chemical properties according to the correlation
# and scatter plot matricies. There is a slight negative correlation between both aciditys and density with quality
# while approximately 0 correlation between qual and pH.

# B)
# 1)
alc_qual <- subset(winequal, select=c("quality", "alcohol"))
alc_qual <- alc_qual[order(alc_qual$quality),]
view(alc_qual)

levels(alc_qual$quality)

# shows that there are 7 unique categories in "quality" meaning df = 7 - 1 = 6
unique(alc_qual$quality)

# using the quality as a character to create distinct categories, we use
# one way anova to check f ratio to test hypothesis 
# H0: mu0 = mu1 = mu2 = mu3 = mu4 = mu5 = mu6
# vs. Ha: there is at least one mu != the rest
qual_aov <- aov(data=alc_qual, alcohol~as.character(quality))
summary(qual_aov)
# f test finds in the summary above that the F-value p value is <0.05, 
# therefore we reject the null hypothesis.



# 2)
color_cont <- subset(winequal, select=c("type","alcohol"))
color_cont <- color_cont[order(color_cont$alcohol),]
view(color_cont)

levels(color_cont$type)

color_aov <- aov(data=color_cont, alcohol~as.character(type))
summary(color_aov)
# F test p value yields results of <0.05, therefore we reject the null hypothesis
# that there is no statistically significant difference between red and white wine.

# 3)
unique(winequal$quality)

# defining high quality as above 6, and low as 6 and below
ph_qual <- subset(winequal, select=c(pH,quality))
ph_qual$qualr[ph_qual$quality<=6] = "Low"
ph_qual$qualr[ph_qual$quality>6] = "High"

ph_qual <- subset(ph_qual, select=c(pH,qualr))
view(ph_qual)

ph_aov <- aov(data=ph_qual, pH~as.character(qualr))
summary(ph_aov)
# p-value of fstatistic is <0.05, therefore we reject the null hypothesis that
# there is no difference in ph between high and low quality wines.