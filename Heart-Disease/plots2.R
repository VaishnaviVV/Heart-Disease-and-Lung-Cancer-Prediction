
library(caret)
library(gridExtra)
library(corrplot)
library(dplyr)
library(tidyverse)
library(plotly)
data <- read.csv("C:/Users/Divyashree/Downloads/6th-semester/EDA-theory/heart.csv")
##Presence and Absence of Heart disease
data2 <- data %>% 
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

#Analysis of the count of Heart Disease
#graph1
ggplot(data2, aes(x=data2$target, fill=data2$target)) + 
  geom_bar() +
  xlab("Heart Disease") +
  ylab("Count") +
  ggtitle("Analysis of the count of Heart Disease") +
  scale_fill_discrete(name = "Heart Disease", labels = c("Absence", "Presence"))
#graph2
df4<-data2%>% group_by(target) %>% summarise(n = n()) %>% arrange(desc(n))
fig <- plot_ly(df4,labels = ~target, values = ~n,type="pie")
fig


#Analysis of Heart disease by age

fig <- plot_ly(data2,
                 type='histogram',
                 x=~data2$ï..age,color=~sex)
fig <- fig %>% layout(
  barmode="stack",bargap=0.1)
fig


# Comparison of Blood pressure across pain type 
data2 %>%
  ggplot(aes(x=sex,y=trestbps))+
  geom_boxplot(fill="blue")+
  xlab("Sex")+
  ylab("BP")+
  facet_grid(~cp)

##correlation plot
cor_heart <- cor(data2[,10:14])
cor_heart

corrplot(cor_heart, method = "ellipse", type="upper",)

#Analysis of the count of types of heart Disease
df3<-data2 %>% group_by(cp,target) %>% summarise(n = n()) %>% arrange(desc(n))
fig <- plot_ly(df3,x=~cp, y=~n,color = ~target,type="bar")
fig

df5<-data2 %>% group_by(restecg,target) %>% summarise(n = n()) %>% arrange(desc(n))
fig <- plot_ly(df5,x=~restecg, y=~n,color = ~target,type="bar")
fig
# Analysis of Trestbps by age

ggplot(data2, aes(x = data$ï..age, y = trestbps, color = target, shape = target))+
  geom_point()+
  geom_smooth(se = FALSE)

