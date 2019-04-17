#Global file for Iris Multiclassification Shiny app, STAT6969 HW2

# In the global file load up the model and prepare a function for generating a prediction table

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

#merge predictions with Iris dataframe so we can sort by feature
main <- merge(iris, preds2)

#create function for generating a prediction table
#takes a given sepal length, sepal width, petal length, and petal width and returns a table with the list of species possibilities,
#ordered by probability

pred_gen <- function(slength, swidth, plength, pwidth){
  #gets the appropriate case
  case <- main%>%
    #pick correct case based on values
    filter(Sepal.Length == slength & Sepal.Width == swidth & Petal.Length== plength & Petal.Width == pwidth)
  #make a new dataframe with the probabilities for given case
  species_probs <- case%>%
    select(setosa, versicolor, virginica)
  
}

pred_gen(5.1, 3.5,1.4,0.2)