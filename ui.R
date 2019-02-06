library(shiny)
library(ggplot2)
library(shinythemes)

shinyUI(fluidPage(
  
  theme = shinytheme("flatly"),
  
  titlePanel("Height Estimation for Black Cherry Trees"),
  
  sidebarPanel(
    
    sliderInput('sld_Girth', 'Tree Diameter', min=5, 21, 8.3),
    sliderInput('sld_Volume','Volume of Timber',min=10,77,10.2),
    htmlOutput("text1"),
    htmlOutput("text2")
  ),
  
  mainPanel(
    plotOutput("Plot", width = "80%")
  )
))