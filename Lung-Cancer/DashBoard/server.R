library(shiny)
library(plotly)
library(DT)
library(naivebayes)
library(dplyr)
library(ggplot2)
library(psych)
library(class)
library(e1071)
library(caTools)
library(ROCR)
library(shinydashboard)
shinyServer(function(input,output){
  output$plot<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
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
  })
  output$plot1<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
    genderTbl <- with(lung, table(GENDER))
    genderDf<-data.frame(name=c("F","M"),value=c(146,162))
    ggplot(genderDf, aes(x=name,y=value)) + 
      geom_bar(stat = "identity")
    
    genderFig <- plot_ly(
      x = c("F", "M"),
      y = c(146,162),
      type = "bar",
    )%>%layout(plot_bgcolor = '#e5ecf6',title='Gender Distribution',xaxis=list(title='Gender'),yaxis=list(title='Count'))
    
    genderFig
    
  })
  output$plot2<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
    smokingTbl <- with(lung, table(SMOKING))
    smokingDf<-data.frame(name=c("NO","YES"),value=c(135,174))
    smokingFig <- plot_ly(
      x = smokingDf$name,
      y = smokingDf$value,
      type = "bar",
    )%>%layout(plot_bgcolor = '#e5ecf6',title='Smoking Distribution',xaxis=list(title='Smoking'),yaxis=list(title='Count'))
    smokingFig
  })
  output$plot3<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
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
  })
  output$plot4<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungDataSet.csv')
    HighW <- with(High, table(ShortnessofBreath))
    #HighW
    y1=c(79,177,109)
    BreathFig <- plot_ly(
      labels= c("Normal","Mediocre","Extreme"),
      values =y1,
      type = "pie",
    )%>%layout(title='Shortness of breath risk as a percentage of lung cancer risk')
    BreathFig
  })
  
  output$plot20<-renderPlotly({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
    peerPressureTbl <- with(lung, table(PEER_PRESSURE))
    peerPressureTbl # just to view the count
    peerPressureDf<-data.frame(name=c("NO","YES"),value=c(154,155))
    peerPressureFig <- plot_ly(
      peerPressureDf,
      labels=~name,
      values=~value
    )%>%add_pie(hole=0.6)%>%layout(plot_bgcolor = '#e5ecf6',title='Peer Pressure')
    peerPressureFig
  })
  output$plot5<-renderPlotly({
    lung<- read.csv("D:/Sem6/EDA/EDA_Project/LungDataSet.csv")
    High <- lung %>% filter(Level == "High")
    Low <- lung %>% filter(Level == "Low")
    Medium <- lung%>% filter(Level == "Medium")
    HighW <- with(High, table(WeightLoss))
    #HighW
    y1=c(158,97,110)
    LowW <- with(Low, table(WeightLoss))
    #LowW
    y2=c(202,81,20)
    MediumW <- with(Medium, table(WeightLoss))
    #MediumW
    y3=c(81,135,120)
    WeightLossFig <- plot_ly(
      x = c("Glycogen Depletion","Fat Loss","Extreme WeightLoss"),
      y =y1,
      type = "bar",
      marker = list(color = 'rgba(235, 52, 52,1)'),
      name="High"
    )%>%layout(title='Correlation between weightloss and Cancer Risk',xaxis=list(title='WeightLoss'),yaxis=list(title='Count'))
    WeightLossFig <- WeightLossFig %>% add_trace(y = ~y3, name = 'Medium', marker = list(color = 'rgba(226, 235, 52,0.8)'))
    WeightLossFig <- WeightLossFig %>% add_trace(y = ~y2, name = 'Low', marker = list(color = 'rgba(52, 235, 58,1)'))
    WeightLossFig
    
    
  })
  output$plot6<-renderPlotly({
    lung<- read.csv("D:/Sem6/EDA/EDA_Project/LungDataSet.csv")
    HighObesity <- with(High, table(Obesity))
    #HighObesity
    y1=c(19,20,326)
    ObesityFig <- plot_ly(
      x= c("Normal","Overweight","high-risk"),
      y =y1,
      type = "bar",
      marker = list(color = 'rgba(235, 52, 52,1)'),
      name="High"
    )%>%layout(title='Risk of Obesity',xaxis=list(title='Obesity'),yaxis=list(title='Count'))
    ObesityFig
    
  })
  output$plot7<-renderPlotly({
    lung<- read.csv("D:/Sem6/EDA/EDA_Project/LungDataSet.csv")
    High <- lung %>% filter(Level == "High")
    Low <- lung %>% filter(Level == "Low")
    Medium <- lung%>% filter(Level == "Medium")
    LowS <- with(Low, table(SwallowingDifficulty))
    HighS <- with(High, table(SwallowingDifficulty))
    MediumS <- with(Medium, table(SwallowingDifficulty))
    y1=list(71,91,61,40,20,10,10,0)
    y2=list(70,39,19,99,29,30,29,50)
    y3=list(80,30,10,50,61,51,50,0)
    fig <- plot_ly(y = y1, type = "box", quartilemethod="linear", name="Low Risk of Cancer")
    fig <- fig %>% add_trace(y = y2, quartilemethod="linear", name="High Risk of Cancer")
    fig <- fig %>% add_trace(y = y3, quartilemethod="linear", name="Medium Risk of Cancer")
    fig <- fig %>% layout(title = "Boxplot wrt to swallowing and level of risk of cancer")
    fig
    
  })
  output$plot21<-renderPlotly({
    lung<- read.csv("D:/Sem6/EDA/EDA_Project/LungDataSet.csv")
    fig <- lung %>%plot_ly(type = 'violin') 
    fig <- fig %>%
      add_trace(
        y = ~AirPollution[lung$Level == 'Low'],
        legendgroup = 'L',
        scalegroup = 'L',
        name = 'Low',
        box = list(
          visible = T
        ),
        meanline = list(
          visible = T
        ),
        color = I("blue"),
        y0="AirPollution"
      ) 
    fig <- fig %>%
      add_trace(
        y = ~AirPollution[lung$Level == 'Medium'],
        legendgroup = 'M',
        scalegroup = 'M',
        name = 'Medium',
        box = list(
          visible = T
        ),
        meanline = list(
          visible = T
        ),
        color = I("red")
      ) 
    fig <- fig %>%
      add_trace(
        y = ~AirPollution[lung$Level == 'High'],
        legendgroup = 'H',
        scalegroup = 'H',
        name = 'High',
        box = list(
          visible = T
        ),
        meanline = list(
          visible = T
        ),
        color = I("yellow")
      ) 
    fig <- fig %>%
      layout(
        xaxis = list(
          title = "Level"
        ),
        yaxis = list(
          title = "Effect of AirPollution in High Risk of Lung Cancer",
          zeroline = F
        ),
        title="Effect of AirPollution in Various Levels of Risks"
      )
    fig
    
  })
  
  output$Alignment<-renderImage({
    lung<- read.csv('D:/Sem6/EDA/EDA_Project/LungData.csv')
    b<-lung
    
    lung$GENDER= as.numeric(as.factor(lung$GENDER))
    lung$LUNG_CANCER= as.numeric(as.factor(lung$LUNG_CANCER))
    
    
    # Splitting data into train
    # and test data
    split <- sample.split(lung, SplitRatio = 0.7)
    train <- subset(lung, split == "TRUE")
    test <- subset(lung, split == "FALSE")
    
    # Feature Scaling
    train_scale <- scale(train[, 1:15])
    test_scale <- scale(test[, 1:15])
    #Prediction
    l1<-levels(factor(b$LUNG_CANCER))
    #input1 categorical:
    GENDER <- input$GENDER
    AGE<-input$AGE
    SMOKING <-input$SMOKING
    YELLOW_FINGERS <- input$YELLOW_FINGERS
    ANXIETY <- input$ANXIETY
    PEER_PRESSURE <- input$PEER_PRESSURE
    CHRONIC.DISEASE <- input$CHRONIC.DISEASE
    FATIGUE<- input$FATIGUE
    ALLERGY <- input$ALLERGY
    WHEEZING<-input$WHEEZING
    ALCOHOL.CONSUMING<- input$ALCOHOL.CONSUMING
    COUGHING <- input$COUGHING
    SHORTNESS.OF.BREATH <-input$SHORTNESS.OF.BREATH
    SWALLOWING.DIFFICULTY <- input$SWALLOWING.DIFFICULTY
    CHEST.PAIN <- input$CHEST.PAIN
    
    l1<-levels(factor(b$LUNG_CANCER))
    l2<-as.numeric(levels(factor(lung$LUNG_CANCER)))
    s1<-levels(factor(b$GENDER))
    s2<-as.numeric(levels(factor(lung$GENDER)))
    S1<-GENDER
    p<-as.numeric(match(S1,s1))
    GENDER=s2[p]
    
    
    #x=c(Sex,Age,Height,Weight,Year,Season,Sport,Team)
    x=data.frame(GENDER=GENDER,AGE=AGE,SMOKING=SMOKING,YELLOW_FINGERS=YELLOW_FINGERS,ANXIETY=ANXIETY,PEER_PRESSURE=PEER_PRESSURE,FATIGUE=FATIGUE,ALLERGY=ALLERGY,ALCOHOL.CONSUMING=ALCOHOL.CONSUMING,CHEST.PAIN=CHEST.PAIN,CHRONIC.DISEASE=CHRONIC.DISEASE,WHEEZING=WHEEZING,COUGHING=COUGHING,SHORTNESS.OF.BREATH=SHORTNESS.OF.BREATH,SWALLOWING.DIFFICULTY=SWALLOWING.DIFFICULTY)
    z<-knn(train=train[,1:15],test=x,cl=train$LUNG_CANCER,k=5)
    z1<-as.numeric(match(z,l2))
    if(l1[z1]=="NO"){
      return(list(src = "D:/Sem6/EDA/EDA_Project/NO.PNG",contentType = "image/png",width = 300,
                  height = 160,alt = "Alignment"))
    }
    else{
      return(list(src = "D:/Sem6/EDA/EDA_Project/YES.PNG",contentType = "image/png",width = 300,
                  height = 160,alt = "Alignment"))
    }
  })
})
