###Read in excel file
#install.packages("readxl")
#install.packages("car")
##install.packages("corrplot")
##install.packages("base")
library(base)
library(dplyr)
library(corrplot)
library(car)
library(tidyverse)
library(readxl)
library(ggplot2)
library(data.table)

wine_df <- read_excel("winequality.xlsx")
View(wine_df)

summary(wine_df)

###There are no missing values here
null_values <- is.na(wine_df)
missing_cols <- colSums(null_values)
print(missing_cols)

#####Data Visualization#####
####Question 1:
plot(wine_df$alcohol, wine_df$quality, xlab = "Alcohol Content", ylab = 'Wine Quality', col = 'purple', pch = 19, main = 'Scatter plot between Alcohol Content and Wine Quality')
###Based on the scatter there is no relationship between these two variables but let's try this with ggplot

hist(wine_df$alcohol)
hist(wine_df$quality)
###We can assume that each observation is independent from one another

###Visualize the relationship between 2 variables with ggplot
###Add a fitted check line to see if there is linearity
plot1 <- ggplot(wine_df, aes(x=alcohol,y=quality))
plot1 + geom_point(colour="Darkgreen") + geom_smooth(method = 'lm') + ggtitle("Alcohol vs. Quality") +
  theme(plot.title = element_text(hjust = 0.5))
###Based on the visualization, it seems like there are no relationships between 2 variables
###But let's also try different test for linearity assumptions, 

###let's use Z-score to detect if there are many Outliers in the dependent variable
###Use abs to check if y > |-3| or |3|
quality_s <- abs(scale(wine_df$quality, scale=TRUE))
#View(quality_s)
#sort(quality_s, decreasing = TRUE)
outliers_quality <- which(quality_s > 3)
print(outliers_quality)
###There are a few Outliers. However, this is not enough, we need to look at the residuals plot

###Residuals plot
linear_al_qua <- lm(quality ~ alcohol, data = wine_df)
linear_al_qua
hist(linear_al_qua$residuals, main = 'Distribution of residuals (Alcohol vs. Quality)')
qqPlot(linear_al_qua$residuals, id=FALSE, main = 'QQplot for residuals (Alcohol vs. Quality)')
###Based on qqplot, the center is hugging the lines but the tails are not. It's still symmetrical though.
###There are many outliers right at the end of the tails

##We will check for Homoscedasticity between the 2 variables
plot(linear_al_qua$fitted.values, linear_al_qua$residuals, xlab = "Fitted Values", ylab = "Residuals", main = 'Homoscedasticity (Alcohol vs. Quality)')
###Based on the plot, the variance of errors is not constant.

###Let's look at the correlation matrix to check if there is multicollinearity
numerical_columns <- wine_df %>% select_if(is.numeric) %>% colnames()
numerical_columns
correlation_matrix <- cor(wine_df[, numerical_columns])
View(correlation_matrix)
corrplot(correlation_matrix, type = "upper", method = "circle", tl.col = "black")
###The correlation between alcohol and quality is 0.44431852. Based on the correlation matrix, I noticed that there is a highly
###negative correlation between alcohol and density, moderately high between residual sugar and alcohol.
###Therefore, based on all the tests above there is no linear correlation between alcohol and quality.

###We will use Spearman to study the correlation between alcohol and quality
spearman_corr_matrix <- cor(wine_df[, numerical_columns], method = 'spearman')
View(spearman_corr_matrix)
corrplot(spearman_corr_matrix, type = "upper", method = "circle", tl.col = "black")
###Based on the spearman correlation (0.447), I conclude that these 2 variables are weakly correlated.

####Question 2:
###sulphates
unique(wine_df$type)
###There are only two types of wine, red and white
plot2 <- ggplot(wine_df, aes(x = type, y = sulphates, fill = type))
plot2 + geom_boxplot() + scale_fill_manual(values = c('red', 'white')) + ggtitle('Distribution of Sulphates between Red and White Wine') + 
  theme(plot.title = element_text(hjust = 0.5))
##Based on the look of boxplots, we can say that the mean sulfate concentration of red wine is greater than 
##the mean sulfate concentration of white wine. However, we should do a statistical test to confirm what we said
###Is there a significant different between red and white wine's sulphates concentration?
###We will use t-test to do this, but are these distributions meet the assumptions?

###Let's check for normality in these distributions
red_sulphates <- wine_df$sulphates[wine_df$type == 'red']
white_sulphates <-wine_df$sulphates[wine_df$type == 'white']
hist(red_sulphates)
hist(white_sulphates)

##These qqplots show that the data are not normally distributed
qqPlot(red_sulphates, id=FALSE, main = 'QQplot for Distribution of Sulphates (Red wine)')
qqPlot(white_sulphates, id=FALSE, main = 'QQplot for Distribution of Sulphates (White wine)')

##Shapiro tests: Since these p-values are smaller than 0.5, we can say that the data are not normally distributed
shapiro.test(red_sulphates)
shapiro.test(white_sulphates)

##Homogeneity. Checking for the equal of variance
df_sulphates <- wine_df %>% select(type, sulphates)
type_group <- as.factor(df_sulphates$type)
leveneTest(sulphates ~ type_group, data = df_sulphates)
##Since the p_value < 0.001, there is enough evidence that the variances are different.

##Therefore, we are unable to use the t-test. I will use Wilcoxon rank-sum to compare the two groups
wilcox.test(red_sulphates, white_sulphates)
##Based on the Wilcoxon rank-sum test, p-value < 0.0001, we can conclude that there is a significant different between 2 groups.

####Question 3:
##wine quality
hist(wine_df$quality, main = 'Distribution of wine quality')
##Is this distribution normal?
qqPlot(wine_df$quality, id=FALSE, main = 'QQplot for Distribution of Wine Quality')
##So the data distribution is not normal based on the qqplot

###Question 4:
##I will stick with the Spearman correlation matrix to answer this question
corrplot(spearman_corr_matrix, type = "upper", method = "circle", tl.col = "black")
pairs(wine_df[, numerical_columns])
##However, let's look at red wine and white wine separately to see the correlation
df_type_list <- split(wine_df, wine_df$type)
df_type_list

##We will use the spearman correlation again to check for the relationships between the independent variables and wine quality
red_corr_matrix <- cor(df_type_list$red[, numerical_columns], method = 'spearman')
View(red_corr_matrix)
corrplot(red_corr_matrix, type = "upper", method = "circle", tl.col = "black")
##For red wine, alcohol and sulphates are moderately positively correlated with wine quality.
##Volatile acidity is moderately negatively correlated with wine quality.

white_corr_matrix <- cor(df_type_list$white[, numerical_columns], method = 'spearman')
View(white_corr_matrix)
corrplot(white_corr_matrix, type = "upper", method = "circle", tl.col = "black")
##For white wine, alcohol is moderately positively correlated with wine quality.
##Density and chlorides are moderately negatively correlated with wine quality.

#####Hypothesis Testing#####
###Question 1:
##Let's treat wine quality ratings as categories this time
sort(unique(wine_df$quality))

##I will look at the boxplots and see the distributions of alcohol between all of these ratings.
plot3 <- ggplot(wine_df, aes(x = quality, y = alcohol, fill = factor(quality)))
plot3 + geom_boxplot() + scale_fill_manual(values = rainbow(length(sort(unique(wine_df$quality))))) + ggtitle('Distribution of Alcohol between Wine ratings') + 
  theme(plot.title = element_text(hjust = 0.5))
###Visually, if we looking at ratings between 6 to 9, we noticed that there is a median alcohol difference between those distributions
##Let's do an ANOVA test and see if there is actually a significant difference between these distributions
##We can assume that these observations are independent from one another
##Let's check for normality between all of these distributions
wine_df_copy <- copy(wine_df)
wine_df_copy$quality_string <- as.character(wine_df_copy$quality)
View(wine_df_copy)

quality_ANOVA <- aov(alcohol ~ quality_string, data = wine_df_copy)
summary(quality_ANOVA)

hist(quality_ANOVA$residuals, main = 'Distribution of the ANOVA-test residuals')
qqPlot(quality_ANOVA$residuals, id=FALSE)
##Based on the visualizations, the residuals are normally distributed
##Let's check the homogeneity of variances in residuals look like
plot(fitted(quality_ANOVA), resid(quality_ANOVA))
##Based on the plot, there is a pattern between the residuals and fitted value
##Let's use leveneTest to check
group_quality <- as.factor(wine_df_copy$quality_string)
leveneTest(alcohol ~ group_quality, data = wine_df_copy)
##Based on the leveneTest, the variances are different between these samples.
##Therefore, I will not use ANOVA to compare the distributions. I will stick with non-parametric test.
##Kruskal-Wallis_test
kruskal.test(alcohol ~ group_quality, data = wine_df_copy)
##Based on the Kruskal-Wallis test, the medians alcohol is different between the wine quality.
##Then, I use pairwise wilcox test to compare the distributions the ratings specifically.
pairwise.wilcox.test(wine_df_copy$alcohol, wine_df_copy$quality_string, p.adjust.method = "bonferroni")
#So, the median alcohol with quality = 4 is significantly different than the ones with 5-8. The distributions between the low-quality alcohol (3-5) 
##and between (7-9) are not significantly different.

###Question 2:
##Alcohol between red and white wine
plot2 <- ggplot(wine_df, aes(x = type, y = alcohol, fill = type))
plot2 + geom_boxplot() + scale_fill_manual(values = c('red', 'white')) + ggtitle('Distribution of Alcohol between Red and White Wine') + 
  theme(plot.title = element_text(hjust = 0.5))

##Let's check if we can use t-test on this one
##Check normality of the distributions of the types of wines
hist(df_type_list$red$alcohol, main = 'Distribution of alcohol (Red)')
hist(df_type_list$white$alcohol, main = 'Distribution of alcohol (White)')
qqPlot(df_type_list$red$alcohol, id=FALSE)
qqPlot(df_type_list$white$alcohol, id=FALSE)

##Visually, the data is not normally distributed
##Let's use Shapiro test to check for normality
shapiro.test(df_type_list$red$alcohol)
shapiro.test(df_type_list$white$alcohol)
##Based on both shapiro tests, these data are not normally distributed

leveneTest(alcohol ~ as.factor(wine_df$type), data = wine_df)
##The variances are not equal => we can't use t-test.

##I will use wilcox.test() to compare these 2 distributions
wilcox.test(alcohol ~ as.factor(wine_df$type), data = wine_df)
##Based on p-value if we look at significant level 0.05, then we conclude that there is no significant difference in alcohol
##between red wine and white wine

###Question 3:
##High quality: 7-9
##Low quality: 3-6
breaks <- c(0, 6, 9)
wine_df$rating <- cut(wine_df$quality, breaks, labels = c('low', 'high'))

plot2 <- ggplot(wine_df, aes(x = rating, y = pH, fill = rating))
plot2 + geom_boxplot() + scale_fill_manual(values = c('orange', 'green')) + ggtitle('Distribution of pH between High and Low Quality Wine') + 
  theme(plot.title = element_text(hjust = 0.5))

df_rating_list <- split(wine_df, wine_df$rating)
df_rating_list

hist(df_rating_list$low$pH, main = 'Distribution of pH (Low)')
hist(df_rating_list$high$pH, main = 'Distribution of pH (High)')
qqPlot(df_rating_list$low$pH, id=FALSE)
qqPlot(df_rating_list$high$pH, id=FALSE)

##Visually based on the looks, the center of these distributions look normally distributed, only the tails are deviated from the line.
leveneTest(pH ~ as.factor(wine_df$rating), data = wine_df)
##Based on the p-value, we can assume equality of variance between these 2 distributions
##Moreover, Observations here are independent from one another. Therefore, we will use a t-test
##Since we conclude that there is equality of variance. Therefore, we will use t-test with equal variance
t.test(df_rating_list$low$pH, df_rating_list$high$pH)

##So if we look at significant level = 0.05, since p-value = 0.0223, we can conclude that there is a significant difference
##in pH between low quality and high quality wine.
##But if we look at significant level = 0.01, then we can't accept the conclusion above.

#rm(list = ls())





