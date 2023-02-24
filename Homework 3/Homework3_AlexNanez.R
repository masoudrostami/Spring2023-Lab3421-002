### Problem 1
### Create a matrix with 3 rows and 12 columns
### and calculate means for each column of matrix.

a<-matrix(1:36,nrow=3,ncol=12)
a

apply(a,2,mean)

### Problem 2
### Calculate sum, mean, median, standard deviation, skewness,
### quantile, kurtosis, and variance for 'Balance' variable in job dataset
df<-read_csv('job.csv')
View(df)

names(df)
summary(df)
sd(df$Age)
skewness(df$Age)
kurtosis(df$Age)

# Statistics for 'Balance' variable
sum(df$Balance)
mean(df$Balance)
median(df$Balance)
sd(df$Balance)
skewness(df$Balance)
quantile(df$Balance)
kurtosis(df$Balance)
var(df$Balance)

### Problem 3
### Recode 'Age' variable to 3 categories of 'Young Adult','Middle-aged Adult'
### , and 'Old Adult' based on quantiles of 30%, 60%, and 80%

quantile(df$Age, probs=c(.3,.6,.8))

df$Age[df$Age<33]='Young Adult'
df$Age[df$Age>=30&df$Age<40]='Middle-aged Adult'
df$Age[df$Age>=40&df$Age<=47]='Old Adult'
View(df)

### Problem 4
### Sort 'Balance' variable from high to low in job dataset and create a new
### new subset of the dataset with just Balance and Job Classification variables

df2<-df[order(-df$Balance),]
View(df2)

df3<-subset(df, select=c(4,5))
View(df3)

### Problem 5
### Subset job dataset with just England region and with
### balance of higher than 100,000

df4<-subset(df, Region=='England'&Balance>100000)
View(df4)

### Problem 6
### Using flights dataset, create a new variable using existing variables:
### (arr_time and sched_arr_time) and call it 'delay time.'

library(nycflights13)
View(flights)
mutate(flights, delay_time=sched_arr_time-arr_time)
View(flights)
