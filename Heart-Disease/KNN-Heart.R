# Loading package
library(e1071)
library(caTools)
library(class)
library(caret)

heart<-read.csv("/Users/narendraomprakash/Desktop/Narendra/Semester-VI-WINTER2021/Essentials of Data Analytics/JCOM/heart.csv")

# Splitting data into training and test set
sampleSize <- floor(0.8*nrow(heart)) # 80-20 split

# Randomly generating indices for training set (i.e., 80%)
set.seed(123)
train_indices<-sample(seq_len(nrow(heart)), size = sampleSize)

# Train data (found through filtering by the train_indices)
train<-heart[train_indices,]

# Test data (found through filtering by EXCLUDING the train_indices)
test<-heart[-train_indices,]

# Feature Scaling
train_scale <- scale(train[, 1:13])
test_scale <- scale(test[, 1:13])

# Fitting KNN Model to training dataset
# K=1 78.69%
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$target,
                      k = 1)
classifier_knn

# Model Evaluation
cm <- table(test$target, classifier_knn)
cm
confusionMatrix(cm)

# K = 3 85.25%
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$target,
                      k = 3)
cm <- table(test$target, classifier_knn)
cm
confusionMatrix(cm)

# K = 5 81.97%
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$target,
                      k = 5)
cm <- table(test$target, classifier_knn)
cm
confusionMatrix(cm)

# K = 7 81.97% (probably can stop here since no change)
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train$target,
                      k = 7)
cm <- table(test$target, classifier_knn)
cm
confusionMatrix(cm)

