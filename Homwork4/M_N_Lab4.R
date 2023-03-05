setwd("/Users/mn/Desktop/DATA3421/Labs/Lab4")


library("readxl")
df<-read_excel("winequality.xlsx")
head(df)

#### DATA VISUALIZATION


##########################################################################
# 1. Is there a relationship between alcohol content and wine quality?
##########################################################################
# Yes, there is correlation between the two.
# It is about 0.4443185 in pearson method and 0.4469255 in spearman method.

cor(df$alcohol, df$quality)

cor(df$alcohol,df$quality,method = "pearson")

cor(df$alcohol,df$quality,method = "spearman")

########################################################################
# 2. How does red wine's sulfate concentration compare to white wine?
########################################################################
# The red wine has high sulphate concentration than the white wine.

boxplot(df$sulphates ~ df$type)

###############################################################
# 3. What is the distribution of wine quality ratings?
#    A histogram or bar plot could be created to visualize the 
#    frequency of different quality ratings.
###############################################################
# Right skewed distribution to Normal distribution

hist(df$quality)

#####################################################################
# 4. Are specific chemical properties more strongly associated with
# higher-quality wines? 
# A correlation or scatterplot matrix could explore the relationships
# between chemical properties and wine quality ratings.
#####################################################################
# Yes

install.packages("corrplot")

library(corrplot)
df_subset <- subset(wine, select = 1:12)
df_subset <- subset(df, select = c("quality", "fixed acidity", 
                                   "volatile acidity", "citric acid", 
                                   "residual sugar", "chlorides", 
                                   "free sulfur dioxide", 
                                   "total sulfur dioxide", "density", 
                                   "pH", "sulphates", "alcohol"))

cor_matrix <- cor(df_subset)

corrplot(cor_matrix, method = "circle", type = "upper", 
         tl.cex = 0.8, number.cex = 0.8)


### HYPOTHESIS TESTING:

####################################################################
# 1. Is there a significant difference in alcohol content across 
# different wine quality ratings?
####################################################################
# p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0

library(pROC)

mean_alcohol <- aggregate(alcohol ~ quality, data = df, FUN = mean)

plot(mean_alcohol$quality, mean_alcohol$alcohol, 
     xlab = "Wine Quality", ylab = "Alcohol Content", type = "o",
     main = "Relationship between Wine Quality and Alcohol Content")

t_test <- t.test(df$quality, df$alcohol, var.equal = TRUE)
print(t_test)
#######################################################################
# 2. Is there a significant difference in alcohol content between red wine 
# and white wine?
#######################################################################
# p-value = 0.004278

library(dplyr)
df_subset <- select(df, type, alcohol)

red_wine <- filter(df_subset, type == "red")
white_wine <- filter(df_subset, type == "white")
t_test <- t.test(red_wine$alcohol, white_wine$alcohol)

print(t_test)


boxplot(df$alcohol ~ df$type)

#######################################################################
# Is there a significant difference in pH levels between high-quality 
# and low-quality wines?
#######################################################################
# p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0

library(pROC)

mean_alcohol <- aggregate(pH ~ quality, data = df, FUN = mean)

plot(mean_alcohol$quality, mean_alcohol$pH, 
     xlab = "Wine Quality", ylab = "pH", type = "o",
     main = "Relationship between Wine Quality and Alcohol Content")

t_test <- t.test(df$quality, df$pH, var.equal = TRUE)
print(t_test)


