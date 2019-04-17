#Server for iris multiclassification
library(DT)
library(tidyverse)
library(ggplot2)

#Define server logic
server <- function(input, output){
  #reactive data set that creates dataframe of species prediction probabilities in descending order
  pred_probs <- reactive({
    pred_gen(input$slength, input$swidth, input$plength, input$pwidth)
  })
  
  #create output table for prediction probabilities
  output$probTable <- DT::renderDataTable({pred_probs()})
  
  #create Scatterplot with Sepal Length and Sepal Width. Color based on the Species 
  #and add a red point on the plot that shows where the values are set for prediction
  
  #I made the point black instead because otherwise, you can't see it since setosa is already red
  output$scatter <- renderPlot({p <-
                                 ggplot(data = iris, aes(x=iris$Sepal.Width,y=iris$Sepal.Length))+
                                 geom_point(aes(color=Species, shape=Species)) + labs(x="Sepal Width",y="Sepal Length")+
                                 geom_point(aes(x=input$swidth, y=input$slength), colour="black")
                               print(p)})
  
  #create density plots for Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width that have a vertical line 
  #demonstrating where the sliders are set. For these plots, set the fill to Species to add additional context
  
  #density plot for sepal width
  output$swdensity <- renderPlot({sw <- 
                                   ggplot(data=iris, aes(x=iris$Sepal.Width, fill=iris$Species))+
                                   geom_density(stat = "density",alpha=I(0.2))+
                                   geom_vline(aes(xintercept = input$swidth), color = "red", linetype = "dashed")
  print(sw)})
  
  #density plot for sepal length
  output$sldensity <- renderPlot({sl <- 
    ggplot(data=iris, aes(x=iris$Sepal.Length, fill=iris$Species))+
    geom_density(stat = "density",alpha=I(0.2))+
    geom_vline(aes(xintercept = input$slength), color = "red", linetype = "dashed")
  print(sl)})
  
  #density plot for petal width
  output$pwdensity <- renderPlot({pw <- 
    ggplot(data=iris, aes(x=iris$Petal.Width, fill=iris$Species))+
    geom_density(stat = "density",alpha=I(0.2))+
    geom_vline(aes(xintercept = input$pwidth), color = "red", linetype = "dashed")
  print(pw)})
  
  #density plot for petal width
  output$pldensity <- renderPlot({pl <- 
    ggplot(data=iris, aes(x=iris$Petal.Length, fill=iris$Species))+
    geom_density(stat = "density",alpha=I(0.2))+
    geom_vline(aes(xintercept = input$plength), color = "red", linetype = "dashed")
  print(pl)})
}

  
  
  
  