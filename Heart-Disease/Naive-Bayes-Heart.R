library(e1071)
library(caTools)
library(caret)

# Please replace "" in line 5 with the path of heart dataset in your machine.
heart<-read.csv("")
sampleSize <- floor(0.8*nrow(heart)) # 80-20 split

# Randomly generating indices for training set (i.e., 80%)
set.seed(123)
train_indices<-sample(seq_len(nrow(heart)), size = sampleSize)

# Train data (found through filtering by the train_indices)
train<-heart[train_indices,]

# Test data (found through filtering by EXCLUDING the train_indices)
test<-heart[-train_indices,]

# Model
classifier<-naiveBayes(target~.,data=train)
classifier

# Prediction on test set
y_pred<-predict(classifier,newdata=test)

# Confusion Matrix
cm <- table(test$target, y_pred)
print(cm)

# Model Evaluation
confusionMatrix(cm)
