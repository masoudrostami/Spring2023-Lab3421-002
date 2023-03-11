library(datasets)
data(iris)

iris_data <- iris
summary(iris)


# A) Data Visualization
#1)
sepal<- iris$Sepal.Length
print(sepal)

width <-iris$Sepal.Width
print(width)

plot(sepal, width, xlab="Sepal Length", ylab="Iris Width", 
     main ="Pepal Length vs Iris Width", col = "iris$Species")

install.packages("ggplot2")
library("ggplot2")

ggplot(iris,legend(x = 4.5, y = 7.5, legend = levels(iris$Species)))


#2)

#petal length for setosa
sepal_len <- iris$Sepal.Length
species <- iris$Species

boxplot(sepal_len ~ species, ylab= "Sepal Length", main="Boxplot of Sepal Length for Each Flower", 
        col= c("cadetblue1", "hotpink2", "lightgreen"))

#3)

hist(iris$Sepal.Width, xlab="Width of Sepal", ylab="Frequency", main = "Frequency of Sepal Width", col= 'palevioletred')



# B) Linear Regression 
library(datasets)
data(mtcars)
summary(mtcars)

#1) 
regression<- lm(mtcars$mpg~mtcars$hp)
regression
#Answer: Coefficients:
#         (Intercept)    mtcars$hp  
#          30.09886     -0.06823 
plot(regression)


#2)
mult_regrss<- lm(mtcars$hp + mtcars$wt ~ mtcars$mpg)
mult_regrss

# Answer Coefficients:
#        (Intercept)   mtcars$mpg  
#         330.130       -8.971
plot(mult_regrss)

#3) 


power <- lm(mtcars$hp ~ mtcars$wt + mtcars$hp)
power
#Coefficients:
# (Intercept)    mtcars$wt  
#   -1.821       46.160 

avona(power)




