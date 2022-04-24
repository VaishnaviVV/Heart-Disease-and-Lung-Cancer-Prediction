#Load the Required data Packages
library(corrplot)
library(caret)
#Load the dataset
data<-read.csv("D:/Sem6/EDA/EDA_Project/heart.csv", col.names=c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang","oldpeak","slope","ca","thal","target"))
head(data) # # visualize the header of  data
str(data)
#Check the number of null values in each column
sapply(data, function(x) sum(is.na(x)))
#Draw the correlation plot
corrplot(cor(data[, -9]), type = "lower", method = "number")
# Preparing the DataSet
set.seed(123)
n <- nrow(data)
n
#Training and testing dataset
train <- sample(n, trunc(0.80*n))
data_training <- data[train, ]
data_testing <- data[-train, ]
# Training The Model(2 models(one with all parameters and the other with significant values))
model<- glm(target ~., data = data_training, family = binomial)
summary(model)
model2 <- update(model, ~. - sex - cp - exang -ca -thal )
summary(model2)
par(mfrow = c(2,2))
plot(model2)
# Testing the Model wit significant factors
#Model 1 accuracy with all parameters
model_probs <- predict(model2, newdata = data_testing, type = "response")
model_pred <- ifelse(model_probs > 0.5, 1, 0)
model_pred = as.factor(model_pred)
print("Confusion Matrix for logistic regression"); table(Predicted = model_pred, Actual = data_testing$target )
confusionMatrix(model_pred, as.factor(data_testing$target ))
confusionMatrix(model_pred, as.factor(data_testing$target  ))$overall['Accuracy']
#Model 2 accuracy with all parameters
model_probs <- predict(model, newdata = data_testing, type = "response")
model_pred <- ifelse(model_probs > 0.5, 1, 0)
model_pred = as.factor(model_pred)
print("Confusion Matrix for logistic regression"); table(Predicted = model_pred, Actual = data_testing$target )
confusionMatrix(model_pred, as.factor(data_testing$target ))
confusionMatrix(model_pred, as.factor(data_testing$target  ))$overall['Accuracy']
