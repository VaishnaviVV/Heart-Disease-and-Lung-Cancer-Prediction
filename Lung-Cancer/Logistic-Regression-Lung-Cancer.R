# Installing the package
install.packages("caTools") # For Logistic regression
install.packages("ROCR")	 # For ROC curve to evaluate model

# Loading package
library(caTools)
library(ROCR)
library(caret)
data <- read.csv("C:/Users/Divyashree/Downloads/6th-semester/EDA-theory/lung.csv")
head(data)
sapply(data, class)
data <- transform(
  data,
  LUNG_CANCER=as.factor(LUNG_CANCER)
)
# Splitting dataset
split <- sample.split(data, SplitRatio = 0.8)
split

train_reg <- subset(data, split == "TRUE")
test_reg <- subset(data, split == "FALSE")

# Training model
logistic_model <- glm(LUNG_CANCER ~ GENDER +AGE+ SMOKING +YELLOW_FINGERS +ANXIETY +PEER_PRESSURE +CHRONIC.DISEASE +FATIGUE +ALLERGY+ WHEEZING +ALCOHOL.CONSUMING+ COUGHING+SHORTNESS.OF.BREATH+ SWALLOWING.DIFFICULTY +CHEST.PAIN, 
                      data = train_reg,
                      family = "binomial")
logistic_model

# Summary
summary(logistic_model)

# Predict test data based on model
predict_reg <- predict(logistic_model,
                       test_reg, type = "response")
predict_reg


# Evaluating model accuracy
# using confusion matrix
cm=table(factor(test_reg$LUNG_CANCER), factor(predict_reg))
cm

missing_classerr <- mean(predict_reg != test_reg$LUNG_CANCER)
print(paste('Accuracy =', 1 - missing_classerr))

# ROC-AUC Curve
ROCPred <- prediction(predict_reg, test_reg$LUNG_CANCER)
ROCPer <- performance(ROCPred, measure = "tpr",
                      x.measure = "fpr")

auc <- performance(ROCPred, measure = "auc")
auc <- auc@y.values[[1]]
auc

# Plotting curve
plot(ROCPer)
plot(ROCPer, colorize = TRUE,
     print.cutoffs.at = seq(0.1, by = 0.1),
     main = "ROC CURVE")
abline(a = 0, b = 1)

auc <- round(auc, 4)
legend(.6, .4, auc, title = "AUC", cex = 1)
