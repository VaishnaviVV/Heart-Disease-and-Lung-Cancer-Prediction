# Loading package
library(e1071)
library(caTools)
library(class)

lung<-read.csv("D:/Sem-6/Essentials of Data Analytics/Heart-Disease-and-Lung-Cancer-Prediction-main/Datasets/survey lung cancer.csv")

lung$GENDER= as.integer(as.factor(lung$GENDER))
lung$LUNG_CANCER= as.integer(as.factor(lung$LUNG_CANCER))


# Splitting data into train
# and test data
split <- sample.split(lung, SplitRatio = 0.7)
train <- subset(lung, split == "TRUE")
test <- subset(lung, split == "FALSE")

# Feature Scaling
train_scale <- scale(train[, 1:15])
test_scale <- scale(test[, 1:15])

# Fitting KNN Model 
# to training dataset
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 1)
classifier_knn

cm <- table(test$LUNG_CANCER, classifier_knn)
cm

# Model Evaluation - Choosing K
# Calculate out of Sample error
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))


# K = 3
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 3)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))

# K = 5
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 5)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))

# K = 7
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 7)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))

# K = 9
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 9)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))


# K = 15
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 15)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))


# K = 19
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$LUNG_CANCER,
                      k = 19)
misClassError <- mean(classifier_knn != test$LUNG_CANCER)
print(paste('Accuracy =', 1-misClassError))

