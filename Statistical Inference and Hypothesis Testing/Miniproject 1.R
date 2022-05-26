library(haven)
library(tigerstats)

df1= read.csv("C:/Users/User/Desktop/stats101/Week 3/qwe.csv")


mean.multiple.samples <- function(numsamples, n, variable) { 
  meanvector <- c() 
  meanonesample <- 0 
  for (i in 1:numsamples) { 
    meanonesample <- mean(sample(variable, n, replace=TRUE)) 
    meanvector[i] <- meanonesample 
  } 
  meanvector 
}

ch_n_1500 = mean.multiple.samples(1500, 50, df1$X1)
hist(ch_n_1500, main="Sample distribution of 1500 sample means", xlab = "Sample mean")

sample_mean = mean(ch_n_1500)
sample_se = sd(ch_n_1500)/sqrt(1500)

t_score = (mean(ch_n_1500)-2) / sample_se
qt(0.05, df=1499, lower.tail = T)

t.test(ch_n_1500, mu=2, alternative =c('less'))

#Second part
dataset= read_dta("../Week 3/hw3.dta")

unique(dataset$room_type)
library(tidyverse)
dataset %>%
  group_by(neighbourhood) %>%
  summarise(
    n=n(),
    mean=mean(price),
    sd=sd(price),
    se = sd/sqrt(n),
    #error = qnorm(0.975)*se,
    left_95 = mean - (qnorm(0.975)*se),
    right_95= mean + (qnorm(0.975)*se),
    range_95= right_95 - left_95
  )%>%
  ungroup()

errors=c(2.588677, 3.85, 4.38, 28.5, 6.39)
meansw = c(mean(dataset$price[dataset$neighbourhood=="Brooklyn"]), mean(dataset$price[dataset$neighbourhood=="Manhattan"]) ,mean(dataset$price[dataset$neighbourhood=="Queens"]),mean(dataset$price[dataset$neighbourhood=="Staten Island"]), mean(dataset$price[dataset$neighbourhood=="Bronx"]) )
errbar(unique(dataset$neighbourhood),  meansw, meansw+errors,meansw-errors, main = "Confidence interval by neighborhood", xlab="Price")


