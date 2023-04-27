# R Code Written By Aubrey Vantiger

## First Section should display a number (the number of user ids that made at least one edit)

library(dplyr)
data <- data.frame(read.csv("data/guy-with-racecar.csv", header = TRUE)) ## Change path
datauser <- data.frame(unique(data$user_id))
count(datauser)

## Second section should display a plot ( edit frequency by user)

userdata <- data %>%
  group_by(user_id) %>%
  count()
userdata <- arrange(userdata, desc(n))
plot(userdata$n)