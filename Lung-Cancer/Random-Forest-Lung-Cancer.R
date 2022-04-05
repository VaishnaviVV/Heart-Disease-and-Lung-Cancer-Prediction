# Installing package
install.packages("caTools")	 # For sampling the dataset
install.packages("randomForest") # For implementing random forest algorithm

# Loading package
library(caTools)
library(randomForest)
library(caret)
data <- read.csv("C:/Users/Divyashree/Downloads/6th-semester/EDA-theory/lung.csv")
data <- transform(
  data,
  LUNG_CANCER=as.factor(LUNG_CANCER)
)
sapply(data, class)
sample = sample.split(data$LUNG_CANCER, SplitRatio = .75)
train = subset(data, sample == TRUE)
test  = subset(data, sample == FALSE)
dim(train)
dim(test)
rf <- randomForest(
  LUNG_CANCER ~ .,
  data=train
)
rf
pred = predict(rf, newdata=test[-16])
cm = table(test[,16], pred)
cm
confusionMatrix(cm)
