#Global file for Iris Multiclassification Shiny app, STAT6969 HW9

# In the global file load up the model and prepare a function for generating a prediction table

#import necessary libraries
library(tidyverse)
library(xgboost)

#At first, I thought that the prompt meant we had to use the table and get the probabilities based on the predictions we got when we
#ran xgboost on the whole thing. I didn't realize we were supposed to just run the xgboost model on the new inputs. I commented out
#the previous code and added the correct code above.

#load saved xgboost model
xgmodel <- xgb.load("inst/IrisClassifier.rdata")

#create function to generate prediction table
pred_gen <- function(slength, swidth, plength, pwidth){
  
  preds <- predict(IrisClassifier, as.matrix(slength,swidth,plength,pwidth))
  #create data frame with probabilities
  #cbind and colnames threw errors when I wanted to chain, hence, the ugly code
  #had to throw in another column with the names since the labels wouldn't cooperate
  t <- cbind(preds,c("setosa","versicolor","virginica"))
  prob_df <- as.data.frame(t)
  colnames(prob_df)=c("Probabilities","Species")
  arrange(prob_df,desc("Probabilities"))
  return(prob_df)
}

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
# b <- pred_gen(5.1, 3.5,1.4,0.2)
# b