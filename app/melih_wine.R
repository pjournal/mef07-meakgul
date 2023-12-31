
pti <- c("shiny", "tidyverse", "ggplot2")
pti <- pti[!(pti %in% installed.packages()[,"Package"])]
if(length(pti) > 0) {
  install.packages(pti)
}

##########
### Shiny starter code
##########
library(shiny)
library(tidyverse)
library(ggplot2)


myData <- read.csv("winequalityN.csv")
myData

ui <- fluidPage(
  titlePanel("Wine Quality Explorer"),
  
  sidebarLayout(
    sidebarPanel(

      sliderInput("quality_range", "Select Quality Range", min = 1, max = 10, value = c(5, 8))
    ),
    
    mainPanel(

      plotOutput("winePlot")
    )
  )
)


server <- function(input, output) {


  output$winePlot <- renderPlot({
    ggplot(filtered_data(), aes(x = alcohol, y = pH, color = factor(quality))) +
      geom_point() +
      labs(title = "Wine Quality Scatter Plot", x = "Alcohol Content", y = "pH Level")
  })
}


shinyApp(ui, server)

