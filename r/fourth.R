# R Code Written By Aubrey Vantiger

library(dplyr)
library(tidyr)
library(ggplot2)

data <- data.frame(read.csv("data/bear.csv", header = TRUE))

df <- data %>%
  separate(timestamp, c('date', 'time', "zone"), sep = " ") %>%
  separate(time, c('hour', 'minute', 'sec'), sep = ":") %>%
  separate(date, c('year', 'month', 'day'), sep = "-") %>%
  separate(coordinate, c('x', 'y'), sep = ",")


df$hour <- as.numeric(df$hour)
df$day <- as.numeric(df$day)
df$minute <- as.numeric(df$minute)


df1 <- df %>%
  mutate(day = case_when(
    day == 2 ~ 0,
    day == 3 ~ 1,
    day == 4 ~ 2,
    day == 5 ~ 3
  )) %>%
  mutate(minute = case_when(
    minute >= 30 ~ 0.5,
    minute < 30 ~ 0,
  ))%>%
  mutate(time = (day*24)+(hour)+(minute))

ggplot(df1, aes(x=time, fill = pixel_color)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values=c('#000000','#00756F','#009EAA','#00A368',
                                      '#00CC78','#00CCC0','#2450A4',
                                      '#3690EA','#493AC1','#515252','#51E9F4',
                                      '#6A5CFF','#6D001A','#6D482F','#7EED56',
                                      '#811E9F','#898D90','#94B3FF','#9C6926',
                                      '#B44AC0','#BE0039','#D4D7D9','#DE107F',
                                      '#E4ABFF','#FF3881','#FF4500','#FF99AA',
                                      '#FFA800','#FFB470','#FFD635','#FFF8B8',
                                      '#FFFFFF'))