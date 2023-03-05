#Homework4
#In this homework assignment, you will use R to create visualizations and answer the questions related to hypothesis testing using the wine quality dataset. The wine quality dataset is located in Homework 4 folder in Teams.

#Installing required packages
library(ggplot2)
library(readxl)
library(corrplot)
library(GGally)


#Data visulalization

df <- read_excel("winequality.xlsx")  #read excel file_dataframe
df
#A

summary(df)   #reading data descriptive statistics 

#scatterplot
ggplot(df, aes(x=factor(alcohol), y=quality))+geom_boxplot()+xlab("Alcohol content") +ylab("Wine Qulaity")+ggtitle("Alcohol content Vs. Wine Quality")
#Found no relationship from here 

#A1
#Calculating correlation between alcohol content and wine quality
cor(df$alcohol, df$quality)
#The correlation was found to be 0.44 (from plot and correlation, we can tell both of them do not have a linearlity.)

#A2
#Boxplot for redWine's sulphate concentration to white one
boxplot(sulphates ~type, data = df,
        xlab = "Wine Type",
        ylab = "Sulphate Concentration",
        main = "Sulphate Concentration by Wine Type")
#from the above graph we can see that Red wine type has more Sulphate concentration than red wine type. 

#A3
#Bar plot to visualize the frequency of different quality ratings
count <- table(df$quality)
barplot(count, 
        main = "Distribution of Wine Quality Ratings",
        xlab = "Quality Rating",
        ylab = "Frequency")
#From the barplot here we can see that the distribution is normal as well as we can see that The highest count of quality rating is for 6.

#A4
#Finding correlation to see if any chemical properties is associated with higher quality wines
#Assuming higher quality wines if Quality score is greater than 5.
#Making subset of data of wines having Quality greater than 5
higher_quality_wine <- df[df$quality >5,]
higher_quality_wine

cor_matrix <- cor(higher_quality_wine[, 1:12])
corrplot(cor_matrix, method = "color", type = "upper",
         tl.col = "black", tl.srt = 45, 
         addCoef.col = "black", number.cex = 0.7,
         title = "Correlation Matrix of Chemical Properties with higher quality wine")

#From the correlation matrix we can tell that the density, chlorides, alcohol content has higher correlation with higher quality wines, these chemical properties are more strongly associated with higher qualty wines. 

#B: Hypothesis Testing:

chisq.test(df$alcohol,df$quality)
#From results we can see that the P-value is significantly less than 0.05. In this case we reject the null hypothesis.Hence, there is significant difference in alcohol content across different wine quality ratings. 

#2 making subsets first of red wine and white wine to perform t-test
red_wine<-subset(df,type == 'red')
white_wine<-subset(df,type == 'white')

t.test(red_wine$alcohol,white_wine$alcohol)
#The P-value is very less than 0.05, which we reject the null hypothesis.We conclude that there is significant differencce in alcohol contet between red wine and white wine.

#3 making subsets of quality wine
highquality_wines <- subset(df, df$quality >= 6)
lowquality_wines <- subset(df, df$quality < 6)

t.test(highquality_wines$pH, lowquality_wines$pH)

#From the results we can see that the p-value>> 0.05, hence we do not reject the null hypothesis. We conclude that there is a significant difference in pH levels between high-quality and low-quality wines.