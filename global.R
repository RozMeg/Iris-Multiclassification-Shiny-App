#Global file for Iris Multiclassification Shiny app, STAT6969 HW2

#import necessary libraries
library(tidyverse)
library(xgboost)

#load saved xgboost model
xgmodel <- xgb.load("inst/IrisClassifier.rdata")

#setting up the dataset again
#get iris species as y variable
y = as.numeric(iris$Species) - 1

#set up features for training
x <- iris %>% select(-Species)

#make matrix of predictor variables
x <- as.matrix(x)

# get variable names of predictor variables
var.names = names(x)

#get predictions
preds <- predict(IrisClassifier, x)

#make predictions into dataframe
preds2 <- as.data.frame(matrix(preds,nrow=150, ncol=3,byrow=TRUE))
colnames(preds2) <- c("setosa","versicolor","virginica")

