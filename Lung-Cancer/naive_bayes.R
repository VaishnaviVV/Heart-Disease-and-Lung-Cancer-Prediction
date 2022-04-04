library(e1071)
library(caTools)
library(caret)

lung<-read.csv("D:/Sem-6/Essentials of Data Analytics/Heart-Disease-and-Lung-Cancer-Prediction-main/Datasets/survey lung cancer.csv")

# Splitting data into train and test data
split <- sample.split(lung, SplitRatio = 0.7)
train <- subset(lung, split == "TRUE")
test <- subset(lung, split == "FALSE")

# Fitting Naive Bayes Model to training dataset
set.seed(120)  # Setting Seed
classifier <- naiveBayes(LUNG_CANCER ~ ., data = train)
classifier

# Predicting on test data'
y_pred <- predict(classifier, newdata = test)

# Confusion Matrix
cm <- table(test$LUNG_CANCER, y_pred)
cm

# Model Evaluation
confusionMatrix(cm)