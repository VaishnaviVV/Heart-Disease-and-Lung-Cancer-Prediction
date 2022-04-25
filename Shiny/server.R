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
shinyServer(function(input,output){
  
  output$Alignment<-renderImage({
    lung<-read.csv("C:/Users/Divyashree/Downloads/6th-semester/EDA-theory/lung.csv")
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
    classifier_knn <- knn(train = train_scale,
                          test = test_scale,
                          cl = train$LUNG_CANCER,
                          k = 1)
    
    
    cm <- table(test$LUNG_CANCER, classifier_knn)
    
    
    # Model Evaluation - Choosing K
    # Calculate out of Sample error
    misClassError <- mean(classifier_knn != test$LUNG_CANCER)
    
    
    # K = 5
    classifier_knn <- knn(train = train_scale,
                          test = test_scale,
                          cl = train$LUNG_CANCER,
                          k = 5)
    misClassError <- mean(classifier_knn != test$LUNG_CANCER)
    
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
    
    S1<-GENDER
    p<-as.numeric(match(S1,s1))
    Sex=s2[p]
    
    
    #x=c(Sex,Age,Height,Weight,Year,Season,Sport,Team)
    z<-knn(train=train[,1:15],test=x,cl=train$LUNG_CANCER,k=5)
    z1<-as.numeric(match(z,lung$CHEST.PAIN))
    #cat("Medal :",medal1[z1])
    if(l1[z1]=="NO"){
      return(list(src = "c:/NO.PNG",contentType = "image/png",width = 500,
                  height = 160,alt = "Alignment"))
    }
    else{
      return(list(src = "c:/YES.PNG",contentType = "image/png",width = 500,
                  height = 160,alt = "Alignment"))
    }
  })
})