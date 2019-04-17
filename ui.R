#User interface for iris multiclassification

# 1. add numericInputs and/or sliderInputs for your predictors (Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width) 
# and pass those values into your server to generate a table of probabilities of each Species. 
# Sort this so the highest probability is on top

#call shinydashboard library
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Iris Multiclassification"),
  dashboardSidebar(
    tabItems(
      #First tab is inputs
      tabItem(tabName = "Input values",
              fluidPage(
                numericInput("swidth",
                             "Sepal Width:",
                             min = min(main$Sepal.Width),
                             max = max(main$Sepal.Width),
                             value=0))))
    #                         value = 3.5),
    #             numericInput("slength",
    #                          "Sepal Length:",
    #                          min = min(main$Sepal.Length),
    #                          max=max(main$Sepal.Length),
    #                         value = 5.0),
    #             numericInput("pwidth",
    #                          "Petal Width:",
    #                          min = min(main$Petal.Width),
    #                          max = max(main$Petal.Width),
    #                         value=0.2),
    #             numericInput("plength",
    #                         "Petal Length:",
    #                         min=min(main$Petal.Length),
    #                         max=max(main$Petal.Length),
    #                         Value=0.1)
    #           ))
    # )
  ),
  dashboardBody()
)