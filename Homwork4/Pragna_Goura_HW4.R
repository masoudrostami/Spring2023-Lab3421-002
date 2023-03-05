install.packages("xlsx")
library(readxl)


wine<-read_excel("winequality.xlsx")
wine

#PART A:

#1)
#cor= correlation syntax
cor(wine[, "alcohol"], wine["quality"])
#Answer:           quality
#        alcohol 0.4443185

#2) 
#separated white wine from data and created box plot only using the sulfates variable
white_wine <- subset(wine, type== 'white', select = c (sulphates))
red_wine <- subset(wine, type== 'red', select = c (sulphates))
boxplot(white_wine)
boxplot(red_wine)
boxplot(white_wine, red_wine)


#3) 
ratings <- subset(wine[,'quality'])
numeric_rating <- as.numeric(wine$quality)
numeric_rating
hist(numeric_rating, plot=TRUE)



#4)

#Higher quality of wine is 7-9

high_white_wine <- subset(wine, type =='white', select= c(quality>6))
high_red_wine <-subset(wine, type =='red', select= c(quality>6))


frame_wine <- wine.frame()

quality_white <- subset(high_white_wine[, 'quality'])

citric_acid_white <- subset(high_white_wine[,'citric acid'])
chlorides_white <-subset(high_white_wine[,'chlorides'])
tot_sulf_white <-subset(high_white_wine[,'total sulfur dioxide'])

plot(quality_white,citric_acid_white)



#PART 2

#1) 
#alc content 

t.test(wine$'alcohol')
