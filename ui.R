#User interface for iris multiclassification

# 1. add numericInputs and/or sliderInputs for your predictors (Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width) 
# and pass those values into your server to generate a table of probabilities of each Species. 
# Sort this so the highest probability is on top

#call shinydashboard library
library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Iris Multiclassification"),
  dashboardSidebar(
                sliderInput("slength",
                             "Sepal Length:",
                             min=min(iris$Sepal.Length),
                             max=max(iris$Sepal.Length),
                             value=5.0,
                             step=0.1),
                sliderInput("swidth",
                             "Sepal Width:",
                             min = min(iris$Sepal.Width),
                             max = max(iris$Sepal.Width),
                             value=3.0,
                             step=0.1),
                sliderInput("plength",
                            "Petal Length:",
                            min=min(iris$Petal.Length),
                            max=max(iris$Petal.Length),
                            value=1.5,
                            step=0.1),
                sliderInput("pwidth",
                             "Petal Width:",
                             min = min(iris$Petal.Width),
                             max = max(iris$Petal.Width),
                             value=0.2,
                             step=0.1)),
          
  dashboardBody(
    fluidRow(
      box("Species Prediction Probability",DT::dataTableOutput("probTable"))
    ),
    fluidRow(
      box("Scatterplot of Petal Length vs. Petal Width",plotOutput("scatter"))
    ),
    fluidRow(
      box("Sepal Length Density",plotOutput("sldensity")),
      box("Sepal Width Density",plotOutput("swdensity")),
      box("Petal Length Density",plotOutput("pldensity")),
      box("Petal Width Density",plotOutput("pwdensity"))
    )
  )
)