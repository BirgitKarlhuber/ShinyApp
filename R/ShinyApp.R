
# Load packages

# install.packages("shiny")
# install.packages("shinythemes")
# install.packages("dplyr")
# install.packages("ggplot2")
# devtools::install_github("BirgitKarlhuber/Lab5", force=TRUE)

library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(Lab5)

# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Thenmaps - Dataselection"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select dataset for request
                    selectInput(inputId = "dataset", label = strong("Dataset is a area-level"),
                                choices = c("world-2", "ch-8", "no-7", "no-4", "dk-7", "se-7", "se-4", "us-4", "gl-7")),
                    
                    # Select date for request
                    dateInput(inputId = "date", label = strong("Date"), 
                              format = "yyyy-mm-dd", min = "1900-01-01", max = "2030-12-31"), 
                    
                    submitButton("Start")
                  ),
                  
                  # Output: Visualization and reference
                  mainPanel(
                    plotOutput("visualization"),
                    tags$a(href = "https://www.thenmap.net/",
                           "Source: Thenmaps", 
                           target = "_blank")
                  )
                )
)

# Define server function
server <- function(input, output){
  
  # get requested data from the Thenmaps API (with the help of the Lab5 package)
  selected_data <- reactive({
    data <- Lab5::request_API(input$dataset, input$date)
  })
  
  output$visualization <- renderPlot({
    
    ggplot() +
      geom_sf(data = selected_data()) +
      theme_minimal() 
  })
}

# Create Shiny object
shinyApp(ui = ui, server = server)
