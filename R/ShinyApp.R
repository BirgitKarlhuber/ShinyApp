

library(shiny)
library(shinythemes)
library(Lab5)

ShinyApp <- function(){
  
  # Define UI
  ui <- fluidPage(theme = shinytheme("lumen"),
                  titlePanel("Thenmaps - Dataselection"),
                  sidebarLayout(
                    sidebarPanel(
                      
                      # Select version for request
                      dateInput(inputId = "Version", label = strong("Version"),
                                choices = c("v1","v2")),
                      
                      # Select dataset for request
                      selectInput(inputId = "Dataset", label = strong("Dataset"),
                                  choices = unique(train$Location)),
                      
                      # Select modules for request
                      numericInput(inputId = "Modules", label = strong("Modules"), 
                                   choices = c("data","geo")), 
                      
                      # Select date for request
                      numericInput(inputId = "Date", label = strong("Date ...."), 
                                   format = "yyyy-mm-dd", min = "2007-11-01", max = "2030-12-31")), 
                      
                      # Select language for request
                      numericInput(inputId = "Language", label = strong("Language"), 
                                   min = 0, max = 2000, verbatimTextOutput("value")),
                      
                      submitButton("Start")
                      
                    ),
                    
                    # Output: Description and reference
                    mainPanel(
                      textOutput(outputId = "prediction"),
                      tags$a(href = "http://www.bom.gov.au/",
                             "Source: Bureau of Meteorology of the Australian Government", 
                             target = "_blank")
                    )
                  )
  )
  
  # Define server function
  server <- function(input, output) {
    
    #   validate(need(input$MaxTemp < input$MinTemp, "Error: Minimum temperature have to be smaller than maximum temperature."))
    
    
    # get requested data from the Thenmaps API  
    data <- Lab5::request_API(input$version,input$dataset,input$modules,input$date,input$language)
      
    # depending on the modules create output (data - table, geo - plot)
    if(input$modules == "data"){
      
      # create table of data 
      output$table <- renderTable({
        
        
      })
    } else if(input$modules == "geo"){
      # create plot of geo-data
      output$graph <- renderPlot({
        Lab5::geo_plot(data)
      })
    }
    
  # Create Shiny object
  shinyApp(ui = ui, server = server)
}
