library(ggplot2)
library(plotly)
lung<-read.csv("/Users/narendraomprakash/Desktop/Narendra/Semester-VI-WINTER2021/Essentials of Data Analytics/JCOM/survey lung cancer.csv")

# Gender Distribution (Bar Chart)
genderTbl <- with(lung, table(GENDER))
#genderTbl # just to view the count
genderDf<-data.frame(name=c("F","M"),value=c(146,162))
ggplot(genderDf, aes(x=name,y=value)) + 
  geom_bar(stat = "identity")

genderFig <- plot_ly(
  x = c("F", "M"),
  y = c(146,162),
  type = "bar",
)%>%layout(plot_bgcolor = '#e5ecf6',title='Gender Distribution',xaxis=list(title='Gender'),yaxis=list(title='Count'))

genderFig

# Smoker Distribution (Bar Chart)
smokingTbl <- with(lung, table(SMOKING))
#smokingTbl # just to view the count
smokingDf<-data.frame(name=c("NO","YES"),value=c(135,174))

smokingFig <- plot_ly(
  x = smokingDf$name,
  y = smokingDf$value,
  type = "bar",
)%>%layout(plot_bgcolor = '#e5ecf6',title='Smoking Distribution',xaxis=list(title='Smoking'),yaxis=list(title='Count'))

smokingFig

# Yellow Fingers Distribution (Pie Chart)
yellowTbl <- with(lung, table(YELLOW_FINGERS))
yellowTbl # just to view the count
yellowDf<-data.frame(name=c("NO","YES"),value=c(133,176))


yellowFig <- plot_ly(
  yellowDf,
  labels=~name,
  values=~value,
  type = "pie"
)%>%layout(plot_bgcolor = '#e5ecf6',title='Yellow Fingers Distribution')

yellowFig

# Anxiety Distribution (Pie Chart)
anxietyTbl <- with(lung, table(ANXIETY))
anxietyTbl # just to view the count
anxietyDf<-data.frame(name=c("NO","YES"),value=c(155,154))


anxietyFig <- plot_ly(
  anxietyDf,
  labels=~name,
  values=~value,
  type = "pie"
)%>%layout(plot_bgcolor = '#e5ecf6',title='Anxiety Distribution')

anxietyFig

# Peer Pressure Distribution (Donut Chart)
peerPressureTbl <- with(lung, table(PEER_PRESSURE))
peerPressureTbl # just to view the count
peerPressureDf<-data.frame(name=c("NO","YES"),value=c(154,155))


peerPressureFig <- plot_ly(
  peerPressureDf,
  labels=~name,
  values=~value
)%>%add_pie(hole=0.6)%>%layout(plot_bgcolor = '#e5ecf6',title='Anxiety Distribution')

peerPressureFig
