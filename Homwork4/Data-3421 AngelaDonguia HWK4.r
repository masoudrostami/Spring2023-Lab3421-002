################
# Used Libraries
################
## readxl    | Read Excel Files
## ggplot2   | Data Visualization
## corrplot  | Heatmap # nolint

########################
# Q1. Data Visualization
########################

# Importing Liberaries
install.packages("readxl")
install.packages("ggplot2")

library(readxl)
library(ggplot2)

# Loading it in a varialbe
winequality <- read_excel("winequality.xlsx")
head(winequality)

############# Main Program #############
# --------------
# 1. Is there a relationship between alcohol content and wine quality?
# --------------
ggplot(data = winequality, aes(x = alcohol, y = quality)) +
    geom_point() + xlab("Alcohol Content") + ylab("Wine Quality") +
    ggtitle("Scatter Plot of Alcohol Content vs. Wine Quality")

# Calculates correlation coefficient
cor(winequality$alcohol, winequality$quality)
# Outputs: 0.4443185

# ------
# Answer
# ------
## The correlation output of 0.4443185 shows a moderate positive relationship between alcohol content and wine quality.
## Therefore, we can say that there is a relationship between alcohol content and wine quality, but the strength of the relationship is moderate.



# --------------
# 2. How does red wine's sulfate concentration compare to white wine? A box plot can be created. 
# --------------
boxplot(winequality$sulphates ~ winequality$type,
    xlab = "Wine Type", ylab = "Sulphate Concentration",
    main = "Box Plot of Sulphate Concentration by Wine Type")

# ------
# Answer
# ------
## Based on the box plot, we can see that the median sulphate concentration of red wine is higher than that of white wine.



# --------------
## 3. What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.
# --------------
ggplot(data = winequality, aes(x = quality)) +
    geom_bar() + xlab("Wine Quality") + ylab("Frequency") +
    ggtitle("Histogram of Wine Quality Ratings")

# ------
# Answer
# ------
# Based on the histogram, we can see that the most common wine quality rating is 6, followed by 5 and 7.



# --------------
## 4. Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings
# --------------
# Correlation Matrix
correlation_matrix <- cor(winequality[, 1:11])
print(correlation_matrix)

# Heatmap
install.packages("corrplot")
library(corrplot)
corrplot(correlation_matrix, method = "color", type = "upper", order = "hclust")
corrplot(cor(winequality[, 1:11]), method = "color")

# Scatterplot Matrix of chemical properties and wine quality ratings
pairs(winequality[, 1:11], pch = 19, cex = 0.5)

# Creating a correlation matrix with respect to wine quality
cor_matrix <- cor(winequality[, c("fixed acidity", "volatile acidity", "citric acid", "residual sugar", "chlorides", "free sulfur dioxide", "total sulfur dioxide", "density", "pH", "sulphates", "alcohol", "quality")])
print(cor_matrix)

# ------
# Answer
# ------

## Based on the correlation matrix:
### -0.077 | Fixed Acidity        | Weak Negative Correlation
### -0.266 | Volatile Acidity     | Weak Negative Correlation
### +0.086 | Citric Acid          | Weak Positive Correlation
### -0.037 | Residual Sugar       | Weak Negative Correlation
### -0.201 | Chlorides            | Weak Negative Correlation
### +0.055 | Free Sulfur Dioxide  | Weak Positive Correlation
### -0.041 | Total Sulfur Dioxide | Weak Negative Correlation
### -0.306 | Density              | Weak Negative Correlation
### +0.020 | pH                   | Weak Positive Correlation
### +0.038 | Sulphates            | Weak Positive Correlation
### +0.444 | Alcohol              | Moderate Positive Correlation

## We can see that alcohol has the strongest correlation with wine quality, followed by density, volatile acidity, and chlorides.
### However, the correlation between alcohol and wine quality is moderate, while the correlation between density, volatile acidity, and chlorides is weak.




########################
# Q2. Hypothesis Testing
########################
# --------------
## 1. Is there a significant difference in alcohol content across different wine quality ratings?
# --------------
# Conducting a one-way ANOVA to compare the means of alcohol content across different wine quality ratings
anova_results <- aov(alcohol ~ type, data = winequality)
summary(anova_results)

# ------
# Answer
# ------
## Based on the ANOVA results, we can see that the p-value is 0.00787, which is less than 0.05.
## Therefore, we can reject the null hypothesis and conclude that there is a significant difference in alcohol content across different wine quality ratings.



# --------------
## 2. Is there a significant difference in alcohol content between red wine and white wine?
# --------------
# Conducting a two-sample t-test to compare the means of alcohol content between red wine and white wine
t_test_results <- t.test(winequality$alcohol ~ winequality$type)
t_test_results

# ------
# Answer
# ------
## Based on the t-test results, we can see that the p-value is 0.004278, which is less than 0.05.
### we can reject the null hypothesis and conclude that there is a significant difference in alcohol content between red wine and white wine.



# --------------
## 3. Is there a significant difference in sulphate concentration between red wine and white wine?
# --------------
# Creating a binary variable indicating whether the wine is high-quality or low-quality 
winequality$quality_binary <- ifelse(winequality$quality >= 7, "high", "low")

# Conducting a t-test to compare the means of pH levels between high-quality and low-quality wines
t_test_results_2 <- t.test(winequality$sulphates ~ winequality$quality_binary)
t_test_results_2

# ------
# Answer
# ------
## There seems to be a significant difference in sulphate levels between high-quality and low-quality wines as the p-value is less than 0.05 (p-value = 0.01023).
## Therefore, we reject the null hypothesis that there is no difference in sulphate levels between high-quality and low-quality wines.
