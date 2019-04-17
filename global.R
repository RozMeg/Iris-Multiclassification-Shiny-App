#Global file for Iris Multiclassification Shiny app, STAT6969 HW9

# In the global file load up the model and prepare a function for generating a prediction table

#import necessary libraries
library(tidyverse)
library(xgboost)


#load saved xgboost model
xgmodel <- xgb.load("IrisClassifier.model")

#I'm not sure what's going on with the order and labels in preds. I can see that new predictions are generated, but I don't
#think they're being made in setosa, versicolor, virginica order, which is what I had thought initially
#You'll see in the app that my graphs update based on input, but unfortunately, the table doesn't reorder species accordingly.

#create function to generate prediction table
pred_gen <- function(slength, swidth, plength, pwidth){
  #make prediction based on inputs
  preds <- predict(IrisClassifier, as.matrix(slength,swidth,plength,pwidth))
  # create data frame with probabilities
  # cbind and colnames threw errors when I wanted to chain, hence, the ugly code
  # had to throw in another column with the names since the labels wouldn't cooperate
  t <- as.data.frame(preds)
  #assuming these are in 1,2,3 label order? but that doesn't seem to be the case
  rownames(t) = c("setosa","versicolor","virginica")
  #give a label name so we can manipulate
  colnames(t) = c("probabilities")
  #arrange based on descending probabilities
  t%>%arrange(desc(probabilities))
  return(t)
}

#At first, I thought that the prompt meant we had to use the table and get the probabilities based on the predictions we got when we
#ran xgboost on the whole thing, which doesn't make any sense

# #setting up the dataset again
# #get iris species as y variable
# y = as.numeric(iris$Species) - 1
# 
# #set up features for training
# x <- iris %>% select(-Species)
# 
# #make matrix of predictor variables
# x <- as.matrix(x)
# 
# # get variable names of predictor variables
# var.names = names(x)
# 
# #get predictions
# preds <- predict(IrisClassifier, x)
# 
# #make predictions into dataframe
# preds2 <- as.data.frame(matrix(preds,nrow=150, ncol=3,byrow=TRUE))
# colnames(preds2) <- c("setosa","versicolor","virginica")
# 
# #merge predictions with Iris dataframe so we can sort by feature
# main <- cbind(iris, preds2)
# 
# #create function for generating a prediction table
# #takes a given sepal length, sepal width, petal length, and petal width and returns a table with the list of species possibilities,
# #ordered by probability
# 
# pred_gen <- function(slength, swidth, plength, pwidth){
#   #gets the appropriate case
#   case <- main%>%
#     filter(Sepal.Length == slength, Sepal.Width == swidth, Petal.Length == plength, Petal.Width == pwidth)%>%
#     #take average in case there are multiple with same value
#     summarize(
#       setosa = mean(setosa),
#       versicolor = mean(versicolor),
#       virginica = mean(virginica))
#   #had to mess with column names because they disappeared when I transposed
#   t<-as.data.frame(t(case))%>%
#     cbind(c("setosa","versicolor","virginica"))
#     colnames(t) = c("probability","species")
#     #sort by descending probability
#   ts<- t%>%
#     arrange(desc(probability))
#   #return dataframe
#   return(ts)
# }

# #Test
# d <- pred_gen(7,3,4,0.2)
# d