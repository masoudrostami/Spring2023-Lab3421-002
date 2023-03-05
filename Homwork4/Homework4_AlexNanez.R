### Loading Packages
library(tidyverse)
library(ggplot2)
library('readxl')

### Loading dataset
df<-read_excel('winequality.xlsx')
View(df)
summary(df)
names(df)
str(df)
unique(df$type)

### A: Data Visualization
### 1. Is there a relationship between alcohol content and wine quality?

cor(df$alcohol,df$quality)

cor.test(df$alcohol,df$quality)

# Based on these correlation tests, it appears that alcohol content and wine
# quality are moderately positively correlated. However, with a moderate r value,
# it is unlikely that the relationship is significant.

### 2. How does red wine's sulfate concentration compare to white wine? 
### A box plot can be created.

boxplot(sulphates~type,data=df)

# From the box plot, we can see that red wine's distribution has a higher
# sulfate concentration compared to white wine's distribution.

### 3. What is the distribution of wine quality ratings? 
### A histogram or bar plot could be created to visualize the frequency of different quality ratings.

hist(df$quality)

# The histogram helps us see the distribution of wine quality ratings. We can see
# that 5, 6, and 7 seem to be the ratings with the highest frequency.

### 4. Are specific chemical properties more strongly associated with higher-quality wines? 
### A correlation or scatterplot matrix could explore the relationships between chemical properties and wine quality ratings.

# help(pairs)
pairs(df[,1:12])

### B: Hypothesis Testing

### 1. Is there a significant difference in alcohol content across different wine quality ratings?

t.test(df$alcohol,df$quality)

### 2. Is there a significant difference in alcohol content between red wine and white wine?

t.test(df$alcohol,df$type)

### 3. Is there a significant difference in pH levels between high-quality and low-quality wines?

t.test(df$pH,df$quality)
