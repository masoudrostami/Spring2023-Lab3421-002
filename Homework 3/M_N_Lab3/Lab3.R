setwd("/Users/mn/Desktop/DATA3421/Labs/Lab3")

#Question1:

matrix <-matrix(1:36, 3, 12, byrow=TRUE)
matrix

data_mean = apply(matrix,2,mean)
data_mean

#Question2:

data <- read.csv("job.csv")
data

data_Balance_sum = sum(data$Balance)
data_Balance_mean = mean(data$Balance)
data_Balance_median = median(data$Balance)
data_Balance_sd = sd(data$Balance)

library(moments)
data_Balance_skewness = skewness(data$Balance)
data_Balance_quantile = quantile(data$Balance)
data_Balance_kurtosis = kurtosis(data$Balance)
data_Balance_var = var(data$Balance)

#Question3:

sub_data = unname(quantile(data$Age, probs=c(0.30,0.60,0.80)))
data$Age[data$Age<=sub_data[1]] = "Young Adult"
data$Age[data$Age>sub_data[1]&data$Age<sub_data[3]] = "Middle-aged Adult"
data$Age[data$Age>=sub_data[3]] = "Old Adult"
data

#Question4:

### data_sorted = sort(data$Balance, decreasing = TRUE)

data_sorted <- data[order(data$Balance, decreasing = TRUE),]

data_subset <- data_sorted[, c("Balance", "Job.Classification")]
data_subset

#Question5

data_england <- data[data$Region == "England", ]

data_england_subset <- data_england[data_england$Balance > 100000, ]

data_england_subset

#Question6

library(nycflights13)
flights
data(flights)

flights$delay_time <- flights$arr_time - flights$sched_arr_time

View(flights)
