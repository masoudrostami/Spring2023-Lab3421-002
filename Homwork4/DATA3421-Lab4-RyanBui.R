## Problem 1a. Is there a relationship between alcohol content and wine quality? ##
install.packages("Hmisc");install.packages("ggm");install.packages("polycor")
library(Hmisc);library(ggm);library(polycor)
df <- read_xlsx( "/users/buiry/downloads/winequality.xlsx")
cor(df$alcohol,df$quality,method = "pearson") # Correlation using pearson method
cor(df$alcohol,df$quality,method = "spearman") # Correlation using spearman method
qqplot(df$alcohol, df$quality, main = "Alcohol vs. Quality", xlab = "Alcohol", ylab = "Quality") # qq plot between alcohol concentration and quality
## I believe there is a positive correlation between alcohol and quality but it is not very linear.


## Problem 2a. How does red wine's sulfate concentration compare to white wine? A box plot can be created ##
white_wine_df <- subset(data.frame(df$sulphates, df$type), df$type == "white") # creating a subset of the data that only includes the sulphate feature and wines that are white.
boxplot(white_wine_df$df.sulphates, main = "Boxplot of White Whine Sulphates", ylab = "Sulphate Concentration")

red_wine_df <- subset(data.frame(df$sulphates, df$type), df$type == "red")# creating a subset of the data that only includes the sulphate feature and wines that are red.
boxplot(red_wine_df$df.sulphates, main = "Boxplot of Red Whine Sulphates", ylab = "Sulphate Concentration")

mean(white_wine_df$df.sulphates)
mean(red_wine_df$df.sulphates)

## On average red wine has a higher sulpher concentration.


## Problem 3a. What is the distribution of wine quality ratings? A histogram or bar plot could be created to visualize the frequency of different quality ratings.
library(e1071)

hist(df$quality, main = "Histogram of Quality", xlab = "Quality")
skewness(df$quality)
kurtosis(df$quality)

## Looking at the skewness and the histogram it seems like the distribution is mostly normal and not very skewed.


##Problem 4a. Are specific chemical properties more strongly associated with higher-quality wines? A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.

df_subset <- select(df, -type) # creating a subset of the data that includes everything excpet the type of wine.
correlations <- cor(df_subset[, -12], df_subset[, 12]) # looking at the correlations between all of the variables with quality.

## Looking at the Correlation table made we can see that most chemical properties havea very low correlation with quality however it seems that alcohol concentration, density and volatile, acidity have the most correlation with quality of wine.


## 1b. Is there a significant difference in alcohol content across different wine quality ratings?
chisq.test(df$alcohol,df$quality)# Using the chi-square test to test if alcohol concentration and wine quality are independent of each other
# We get a very low p-value so we can reject our null hypothesis that alcohol content and quality are indpendent.
low_quality <- subset(data.frame(df$alcohol, df$quality), df$quality <= 4)
high_quality <- subset(data.frame(df$alcohol, df$quality), df$quality >= 8)
# the code above will take a look at the alcohol content of wine quality greater than or equal to 8 and less than or equal to 4.
n <- min(length(low_quality$df.alcohol), length(high_quality$df.alcohol))
# Randomly select subset of group1
group1_sub <- sample(low_quality$df.alcohol, n)
t.test(high_quality$df.alcohol, group1_sub, paired = TRUE)
# looking at the paired t-test we can see that the difference in means is definitely not 0.

##2b. Is there a significant difference in alcohol content between red wine and white wine?
hist(df$alcohol)
sample_alcohol <- sample(df$alcohol, size = 5000, replace = FALSE)#We need to take a sample of 5000 in order to use the shapiro test of normality.
shapiro.test(sample_alcohol)
# Since we know our data is normal and our samples are independent we can perform a t-test.

alcohol_white <- subset(data.frame(df$alcohol, df$type), df$type == "white")
alcohol_red <- subset(data.frame(df$alcohol, df$type), df$type == "red")

t.test(alcohol_red$df.alcohol, alcohol_white$df.alcohol)
# Since our p-value is less than 0.05 we can reject our null hypothesis that there is no difference in the alcohol content between red and white wine with 95% confidence.

#3b. Is there a significant difference in pH levels between high-quality and low-quality wines?

sample_pH <- sample(df$alcohol, size = 5000, replace = FALSE)#We need to take a sample of 5000 in order to use the shapiro test of normality.
shapiro.test(sample_pH)

low_quality <- subset(data.frame(df$pH, df$quality), df$quality <= 4)
high_quality <- subset(data.frame(df$pH, df$quality), df$quality >= 8)

t.test(low_quality$df.pH, high_quality$df.pH)

# Since our p-value is greater than 0.05 then we can not reject the null hypothesis that there is a difference in pH levels between high quality and low-quality wines.