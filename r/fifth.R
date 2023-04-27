# R Code Written By Aubrey Vantiger

library(dplyr)
library(tidyr)
data <- data.frame(read.csv("data/bear.csv", header = TRUE))
df <- data %>%
  separate(timestamp, c('date', 'time', "zone"), sep = " ") %>%
  separate(time, c('hour', 'minute', 'sec'), sep = ":") %>%
  separate(date, c('year', 'month', 'day'), sep = "-")
dfreduced<- df[,c(3:6,9:10)]
dfreduced<- dfreduced[,c(1,2,3,4,6,5)]
dfreduced$hour <- as.numeric(dfreduced$hour)
dfreduced$day <- as.numeric(dfreduced$day)
dfreduced$minute <- as.numeric(dfreduced$minute)
dfreduced$sec <- as.numeric(dfreduced$sec)
dfreduced$sec <-round(dfreduced$sec, digits = 2)


dftest2 <- dfreduced %>%
  mutate(day = case_when(
    day == 1 ~ 0,
    day == 2 ~ 1,
    day == 3 ~ 2,
    day == 4 ~ 3,
    day == 5 ~ 4)) %>%
  mutate(time = (((((day*24)+hour)*60)+minute)*60)+sec)

dftest2<- dftest2[ ,c(7,5,6)]
this <- dftest2 %>%
  arrange(time,coordinate)%>%
  filter(time <= 336757.5)
write.csv(this, "data/bear_reduced.csv")