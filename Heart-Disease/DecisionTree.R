#importing required libraries
library(rpart)
library(rpart.plot)
library(caret) 
library(rminer)
set.seed(75)  
#Load the dataset
cancer <- read.csv("D:/Sem6/EDA/EDA_Project/heart.csv")
summary(cancer)
#Partition the dataset(80% Train,20% Test)
inTrain1 <- createDataPartition(cancer$target, p = 0.8, list = F)
cancer_train <- cancer[inTrain1,]
cancer_test <- cancer[-inTrain1,]
#Decision tree for the graph
names(cancer_train)[1]<-'age'
dtm<-rpart(target~sex+cp+trestbps+chol+fbs+restecg+thalach+exang+oldpeak+slope+ca+thal+age,cancer_train,method="class")
#Graphs for the model
rpart.plot(dtm)
rpart.plot(dtm,type=4,extra=101)
#Prediction
names(cancer_test)[1]<-'age'
p<-predict(dtm,cancer_test,type="class")
xtab <-table(cancer_test$target,p)
#Confusion Matrix
confusionMatrix(xtab)
