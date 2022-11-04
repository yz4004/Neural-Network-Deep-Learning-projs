library(tidyverse)
library(readxl)
library(dplyr)
xlsx_1<-read_excel("C:\\Users\\31557\\Documents\\R_file\\MRI - Digital Transaction Breakdown by Store Territory 1Q21.xlsx")

data1 <- xlsx_1%>%
  select(...1, 
         #
         "Store Name", 
         "Stream Ad-Supp, Stream Prem, Download, Physical, Locker, Other",
         "Gross Revenue USD",
         "Continent",
         "Country Code")%>%
  rename(source = "Stream Ad-Supp, Stream Prem, Download, Physical, Locker, Other",
         store = "Store Name",
         revenue = "Gross Revenue USD")
  # group_by("Statement Month")




data1_by_income <- data1%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
data1_by_income
  # mutate(total_revenue = sum("Gross Revenue USD"))




p <- ggplot(data = data1_by_income, 
       mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = '5 types of income')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(data1_by_income$revenue/sum(data1_by_income$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(data1_by_income$source, label_value, sep = ''); label

p + scale_fill_discrete(labels = label)
  
  
# 
# ggplot(data = data1_by_income)+
#   geom_point(mapping = aes(x = income_way, y = revenue))
# 
# 
# 
# type <- c('A','B','C','D','E','F','G')
# 
# nums <- c(10,23,8,33,12,40,60)
# 
# df <- data.frame(type = type, nums = nums)
# 
# p <- ggplot(data = df, mapping = aes(x = 'Content', y = nums, fill = type)) + geom_bar(stat = 'identity', position = 'stack')
# 
# p







data1_by_store <- data1%>%
  group_by(store)%>%
  summarise(revenue = sum(revenue))%>%
  arrange(desc(revenue))
  
data1_by_store_other <- data1_by_store%>%
  filter(revenue<10000)%>%
  group_by()%>%                # 如果填写什么 可以充当 label 神奇操作
  summarise(store = "other",revenue = sum(revenue)) # 这块精髓

data1_by_store_other

data1_by_store_head <- data1_by_store%>%
  filter(revenue>10000)
data1_by_store_head

data1_by_store <- full_join(data1_by_store_head, data1_by_store_other, by = c("store", "revenue"))
data1_by_store


p1 <- ggplot(data = data1_by_store, 
            mapping = aes(x = "Content", y = revenue, fill = store) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = '47 stores revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value1 <- paste('(', 
                     round(data1_by_store$revenue/sum(data1_by_store$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label1 <- paste(data1_by_store$store, label_value1, sep = ''); label1

label1 <-c("Amazon Unlimited(7.9%)", "iTunes/Apple(20.7%)", "other(3.8%)",
           "Pandora(27%)", "Spotify(30.5%)"  , "YouTube(4.5%)",
           "YouTube Subscription(5.6%)" )

p1 + scale_fill_discrete(labels = label1)

#### income way by store

spotify <- data1%>%
  filter(store=="Spotify")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))

p_spotify <- ggplot(data = spotify, 
            mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'Spotify Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(spotify$revenue/sum(spotify$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(spotify$source, label_value, sep = ''); label

p_spotify + scale_fill_discrete(labels = label)




Pandora <- data1%>%
  filter(store=="Pandora")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
Pandora

p_pandora <- ggplot(data = Pandora, 
                    mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'Pandora Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(Pandora$revenue/sum(Pandora$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(Pandora$source, label_value, sep = ''); label

p_pandora + scale_fill_discrete(labels = label)



iTunes <- data1%>%
  filter(store=="iTunes/Apple")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
iTunes


p_iTunes <- ggplot(data = iTunes ,
                    mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'iTunes Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(iTunes$revenue/sum(iTunes$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(iTunes$source, label_value, sep = ''); label

p_iTunes + scale_fill_discrete(labels = label)




Amazon  <- data1%>%
  filter(store=="Amazon Unlimited"|store == "Amazon Music")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
Amazon


p_amazon <- ggplot(data = Amazon, 
                    mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'Amazon Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(Amazon_Unlimited$revenue/sum(Amazon$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(Amazon$source, label_value, sep = ''); label

p_amazon + scale_fill_discrete(labels = label)






YouTubeSub <- data1%>%
  filter(store=="YouTube Subscription")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
YouTubeSub


p_youtubeSb <- ggplot(data = YouTubeSub, 
                    mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'YouTube Subscription Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(YouTubeSub$revenue/sum(YouTubeSub$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(YouTubeSub$source, label_value, sep = ''); label

p_youtubeSb + scale_fill_discrete(labels = label)



YouTube <- data1%>%
  filter(store=="YouTube")%>%
  group_by(source)%>%
  summarise(revenue = sum(revenue))
YouTube

p_youtube <- ggplot(data = YouTube, 
                    mapping = aes(x = "Content", y = revenue, fill = source) )+
  geom_bar(stat = 'identity', position = 'stack')+
  coord_polar(theta = "y")+
  labs(x = '', y = 'revenue', title = 'YouTube Revenue')+
  theme(axis.text = element_blank())+
  theme(axis.ticks = element_blank())

label_value <- paste('(', 
                     round(YouTube$revenue/sum(YouTube$revenue) * 100, 1),
                     '%)', 
                     sep = '')
label <- paste(YouTube$source, label_value, sep = ''); label

p_youtube + scale_fill_discrete(labels = label)













