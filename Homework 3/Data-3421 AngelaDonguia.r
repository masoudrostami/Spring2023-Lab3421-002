job <- read.csv("job.csv")

# 1. Creating a matrix with three rows and 12 columns and calculating the means for each column of the matrix?
matrix <- matrix(1:36, nrow = 3, ncol = 12)
colMeans(matrix)

# 2. Calculate sum, mean, median, standard deviation, skewness, quantile, kurtosis, and variance for variable "Balance" in the job dataset.
summary(job$Balance)
sd(job$Balance)
library(moments)
skewness(job$Balance)
kurtosis(job$Balance)
quantile(job$Balance, probs = c(0.25, 0.5, 0.75))

# 3. Recode the "Age" variable to three categories of "Young Adult", "Middleaged Adult", and "Old Adult", based on quantiles of 30%, 60%, and 80%:
job$age_category <- ifelse(job$Age <= quantile(job$Age, 0.3), "Young Adult", ifelse(job$Age <= quantile(job$Age, 0.6), "Middleaged Adult", "Old Adult"))
job$age_category <- factor(job$age_category, levels = c("Young Adult", "Middleaged Adult", "Old Adult"))
job$age_category

# 4. Sort the "Balance" variable from high to low in the job dataset and create a new subset of the dataset with just Balance and Job Classification variables:
job <- job[order(-job$Balance),]
job_balance <- job[,c("Balance", "Job.Classification")]
job_balance

# 5. Subset job dataset for England region and balance greater than 100,000
job_england <- job[job$Region == " England" & job$Balance > 100000,]
job_england

# 6. Create new variable "DelayTime" from existing variables in flights dataset
library(nycflights13)
flights$DelayTime <- flights$dep_delay + flights$arr_delay
flights$DelayTime
