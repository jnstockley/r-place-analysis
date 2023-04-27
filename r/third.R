# R Code Written By Aubrey Vantiger

library(dplyr)
library(tidyr)
library(ggplot2)

turkey <- data.frame(read.csv("data/turkey-flag.csv", header = TRUE))
mona <- data.frame(read.csv("data/mona-lisa.csv", header = TRUE))
man <- data.frame(read.csv("data/guy-with-racecar.csv", header = TRUE))
bear <- data.frame(read.csv("data/bear.csv", header = TRUE))


total <- nrow(turkey)
turkey <- cbind(1, total, turkey)
colnames(turkey)[1] ="region"

total <- nrow(bear)
bear <- cbind(2, total, bear)
colnames(bear)[1] ="region"

total <- nrow(man)
man <- cbind(3, total, man)
colnames(man)[1] ="region"

total <- nrow(mona)
mona <- cbind(4,total, mona)
colnames(mona)[1] ="region"

newData <- rbind(turkey, bear, man, mona)
newData$region <- as.factor(newData$region)


df <- newData %>%
  separate(timestamp, c('date', 'time', "zone"), sep = " ") %>%
  separate(time, c('hour', 'minute', 'sec'), sep = ":") %>%
  separate(date, c('year', 'month', 'day'), sep = "-") %>%
  separate(coordinate, c('x', 'y'), sep = ",")


df$hour <- as.numeric(df$hour)
df$day <- as.numeric(df$day)


df1 <- df %>%
  mutate(day = case_when(
    day == 2 ~ 0,
    day == 3 ~ 1,
    day == 4 ~ 2,
    day == 5 ~ 3
  )) %>%
  mutate(time = (day*24)+hour)

hourdata1 <- df1 %>%
  group_by(hour, region, total) %>%
  count()  %>%
  mutate(percentage = n/total)



ggplot(hourdata1, aes(x=hour, y = percentage, group = region)) +
  geom_line(aes(color = region))+
  scale_color_manual(values=c('#390099', "#9e0059", '#ffbd00', "#ff5400"))