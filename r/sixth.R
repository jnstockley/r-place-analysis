# R Code Written By Aubrey Vantiger

## First Plot

library(dplyr)
library(tidyr)
library(ggplot2)
data <- data.frame(read.csv("data/turkey-flag.csv", header = TRUE))


df <- data %>%
  separate(timestamp, c('date', 'time', "zone"), sep = " ") %>%
  separate(time, c('hour', 'minute', 'sec'), sep = ":") %>%
  separate(date, c('year', 'month', 'day'), sep = "-") %>%
  separate(coordinate, c('x', 'y'), sep = ",")


df$hour <- as.numeric(df$hour)
df$day <- as.numeric(df$day)
df$minute <- as.numeric(df$minute)

df1 <- df %>%
  mutate(time = ((day-1)*24)+(hour-12))

ggplot(df1, aes(x=time, fill = pixel_color)) +
  geom_bar(stat="count") +
  scale_fill_manual(values=c('#000000','#00756F','#009EAA','#00A368',
                                      '#00CC78','#00CCC0','#2450A4',
                                      '#3690EA','#493AC1','#515252','#51E9F4',
                                      '#6A5CFF','#6D001A','#6D482F','#7EED56',
                                      '#811E9F','#898D90','#94B3FF','#9C6926',
                                      '#B44AC0','#BE0039','#D4D7D9','#DE107F',
                                      '#E4ABFF','#FF3881','#FF4500','#FF99AA',
                                      '#FFA800','#FFB470','#FFD635','#FFF8B8',
                                      '#FFFFFF'))+
  theme(legend.position = "none") +
  xlab("Hour of the Event") + ylab("Number of Edits")+
  ggtitle("Turkey Flag Edit Distribution")




## Second Plot

userdata <- data %>%
  group_by(user_id) %>%
  count()
userdata <- arrange(userdata, desc(n))


ggplot(userdata, aes(x = log(1:nrow(userdata)), y = log(n))) +
  geom_point()+
  xlab("User_ID") + ylab("Number of Edits")+
  ggtitle("Turkey Flag User Edit Frequency (Log-Log Scale)")




## Third plot

data <- data.frame(read.csv("data/bear.csv", header = TRUE)) ## Change to all data path

userdata <- data %>%
  group_by(user_id) %>%
  count()
userdata <- arrange(userdata, desc(n))

ggplot(userdata, aes(x = 1:nrow(userdata), y = n)) +
  geom_point()+
  xlab("User_ID") + ylab("Number of Edits")+
  ggtitle("User Edit Frequency ")



## Fourth Plot

turkey <- data.frame(read.csv("data/turkey-flag.csv", header = TRUE))
mona <- data.frame(read.csv("data/mona-lisa.csv", header = TRUE))
man <- data.frame(read.csv("data/guy-with-racecar.csv", header = TRUE))
bear <- data.frame(read.csv("data/bear.csv", header = TRUE))


total <- nrow(turkey)
turkey <- cbind("Turkey Flag", total, turkey)
colnames(turkey)[1] ="region"

total <- nrow(bear)
bear <- cbind("Bear", total, bear)
colnames(bear)[1] ="region"

total <- nrow(man)
man <- cbind("Man with Baguette", total, man)
colnames(man)[1] ="region"

total <- nrow(mona)
mona <- cbind("Mona Lisa",total, mona)
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

hourdata1 <- df %>%
  group_by(hour, region, total) %>%
  count()  %>%
  mutate(percentage = n/total)

wescolor <- wes_palette("GrandBudapest1", type = "discrete")

ggplot(hourdata1, aes(x=hour, y = percentage, group = region)) +
  geom_line(aes(color = region))+
  xlab("Hour") + ylab("Percentage of Edits")+
  ggtitle("Percentage of Total Edits within a 24-Cycle")