### Lab3 - Canyu Hankins

### 1. Creating a matrix with (3*12) and calculating the means for each column of the matrix?

# 3*12 matrix
a = matrix(1:36, 3, 12, byrow = TRUE)
a

# sum of each column
colSums(a)
# 39 42 45 48 51 54 57 60 63 66 69 72


### 2. Calculate sum, mean, median, standard deviation, skewness, quantile, kurtosis, and variance for variable “Balance” in the job dataset.
data = read.csv("job.csv")
head(data)
bal = data$Balance
head(bal)

sum(bal)
mean(bal)
median(bal)
sd(bal)

#install.packages("psych")
library(psych)

describe(data)
describe(bal)

describe(data, na.rm = TRUE)

#install.packages("e1071")
library(e1071)

skewness(bal)
quantile(bal)
kurtosis(bal)
var(bal)

## sum: 159622523
## mean: 39766.45
## median: 33567.33
## sd: 29859.49
## skewness: 0.9755534
## quantile: min=11.52, Q1=16115.37, median=33567.33, Q3=57599.93, max=183467.7
## kurtosis: 0.7675059
## variance: 891589095


### 3. Recode the “Age” variable to three categories of “Young Adult”, “Middleaged Adult”, and “Old Adult”, based on quantiles of 30%, 60%, and 80%.
View(data)
age=data$Age
quantile(age, probs = c(0.3,0.6,0.8))

# 30%, below 33
data$AgeGroup[age<=33]="Young Adult"
View(data)

#60% between 33 and 40
data$AgeGroup[age<=40&age>33]="Middleaged Adult"
View(data)

# 80%, between 40 and 47
data$AgeGroup[age<47&age>40]="Old Adult"
View(data)

data$AgeGroup[age>=47]="Older Adult"
View(data)

### 4. Sort the “Balance” variable from high to low in the job dataset and create a new subset of the dataset with just Balance and Job Classification variables. sort by balance from high to low
# sorting from high to low
data_bal = data[order(-bal),]
View(data_bal)

# creating a new dataset just contain balance and job classification
data_baljob = subset(data, select = c("Balance","Job.Classification"))
View(data_baljob)


### 5. Subset the job dataset with just the England region and with a balance of higher than 100,000
data1 = subset(data,Region=="England"&Balance>100000)
View(data1)


# 6. Using the flights dataset, create a new variable using existing variables
# (arr_time and sched_arr_time) and call it delay time.
install.packages("dplyr")
library(dplyr)

install.packages("nycflights13")
library(nycflights13)
View(flights)
head(flights)
summary(flights)

delay_time=select(flights,arr_time,sched_arr_time,)
View(delay_time)

delay_time1 = mutate(delay_time,diff_time=arr_time-sched_arr_time)
View(delay_time1)

