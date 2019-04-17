#Creates an xgboost model to predict Iris species 

# Model
# 1. Create a folder "inst" and add a model script that builds and saves a model
# 2. Build a multi-class classification model predicting the Species. I recommend using xgboost but you have the freedom to use whatever method you would like
# 3. If you use xgboost use objective = multi:softprob and eval_metric = mlogloss

#import libraries
library(xgboost)
library(tidyverse)

#get iris species as y variable
y = as.numeric(iris$Species) - 1

#set up features for training
x <- iris %>% select(-Species)

#make matrix of predictor variables
x <- as.matrix(x)

# get variable names of predictor variables
var.names = names(x)


#set up parameter list
param <- list(
  "objective" = "multi:softprob"
  ,"eval_metric" = "mlogloss"
  ,"num_class" = length(table(y))
  ,"eta" = .5
  ,"max_depth" = 10
  ,"lambda" = 1
  ,"alpha" = .8
  ,"min_child_weight" = 3
  ,"subsample" = .9
  ,"colsample_bytree" = .6
)

#number of rounds for cross-validation
cv.nround = 150

#set up cross-validation
bst.cv <- xgb.cv(param = param, data = x, label = y
                 ,nfold = 3, nrounds = cv.nround
                 ,missing = NA, prediction = TRUE)

#get number of rounds based on logloss on test set from cross validation
nround = which(bst.cv$evaluation_log$test_mlogloss_mean == min(bst.cv$evaluation_log$test_mlogloss_mean))

#build classifier
IrisClassifier <- xgboost(params = param, data = x, label = y
                          ,nrounds = nround, missing = NA)

#get predictions
preds <- predict(IrisClassifier, x)

#makepredictions into dataframe
preds2 <- as.data.frame(matrix(preds,nrow=150, ncol=3,byrow=TRUE))
colnames(preds2) <- c("setosa","versicolor","virginica")



