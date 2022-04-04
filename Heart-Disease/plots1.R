library(plotly)
library(dplyr)
library(ggplot2)
library(tidyverse)

heart<-read.csv("D:/Sem-6/Essentials of Data Analytics/heart.csv")

data2 <- heart %>% 
  mutate(sex = if_else(sex == 1, "MALE", "FEMALE"),
         fbs = if_else(fbs == 1, ">120", "<=120"),
         exang = if_else(exang == 1, "YES" ,"NO"),
         cp = if_else(cp == 1, "ATYPICAL ANGINA",
                      if_else(cp == 2, "NON-ANGINAL PAIN", "ASYMPTOMATIC")),
         restecg = if_else(restecg == 0, "NORMAL",
                           if_else(restecg == 1, "ABNORMALITY", "PROBABLE OR DEFINITE")),
         slope = as.factor(slope),
         ca = as.factor(ca),
         thal = as.factor(thal),
         target = if_else(target == 1, "YES", "NO")
  ) %>% 
  mutate_if(is.character, as.factor) %>% 
  dplyr::select(target, sex, fbs, exang, cp, restecg, slope, ca, thal, everything())


## Counting the frequency of the values of the age
## histogram

data2 %>%  group_by(age) %>% 
  count() %>% 
  filter(n > 10) %>% 
  ggplot()+
  geom_col(aes(age, n), fill = "#009999")+
  ggtitle("Age Analysis") +
  xlab("Age")  +
  ylab("AgeCount")

# Representation of Cholestoral level 
## scatterplot

fig <- plot_ly(data2, x = ~age, y = ~chol, name = "Cholestoral level", type = 'scatter',
               mode = "markers", marker = list(color = "purple"))
fig <- fig %>% layout(
  title = "Cholestoral level",
  xaxis = list(title = "Age"),
  yaxis= list(title="Cholestoral level"),
  margin = list(l = 1)
)
fig


## stacked bar chart
## fbs vs target(YES or NO)
groupYES <- data2 %>% filter(target == "YES")
groupNO <- data2 %>% filter(target == "NO")
gBarChart <- data.frame(fbs = names(table(groupYES$fbs)),
                        GroupS= as.numeric(table(groupYES$fbs)),
                        GroupN= as.numeric(table(groupNO$fbs)))
head(gBarChart)
fig <- plot_ly(gBarChart, x = ~fbs, y=~GroupS, type = 'bar', name = 'yes')
fig <- fig %>% add_trace(y=~GroupN, name = 'no')
fig <- fig %>% layout(yaxis = list(title = 'target groups'), barmode = 'stack')

fig


## histogram
## oldpeak vs target
ggplot(data2)+
  geom_histogram(aes( x = oldpeak, y = ..density.., fill =  target), position = position_dodge2())+
  geom_density(aes( x = oldpeak), alpha =.3 ,fill = "blue")

##pie chart
## exang count
fig <- plot_ly()

fig2 <- fig %>% add_pie(data = count(data2, exang), labels = ~exang, values = ~n,
                       name = "Exercise induced angina", domain = list(x = c(0.25, 0.75), y = c(0, 0.6)))

fig2
