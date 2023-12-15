#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(flexdashboard)
library(svglite)
library(shiny)
library(dplyr)
library(ggplot2)
source("R/utils.R")
source("R/time-series-graph.R")

server <- function(input, output, session) {
  
  dataInput <- reactive({
    data[[input$code]]
  })
  
  output$qText <- renderText({
    return(dataInput()$question)
  }) 
  
  observe({
    #Get the data
    data_input <- dataInput()
    # filter the data
    data_alter <- filter(data_input$data, !is.na(est))
    
    #Get unique responses
    responses <- unique(data_alter$Response)
    #update time series responses
    updateSelectInput(session, "timeResponse",
                      choices = responses,
                      selected = responses[1]
                      )
    
    #Get min max years
    minTime <- min(data_alter$Year)
    maxTime <- max(data_alter$Year)
    range = c(minTime:maxTime)
    
    #Update from and to
    updateSelectInput(session, "timeFrom",
                      choices = range,
                      selected = range[1]
    )
    
    updateSelectInput(session, "timeTo",
                      choices = range,
                      selected = range[length(range)]
    )
  })
  
  
  
  output$timePlot <- renderPlotly({
    validate(
      need(input$timeResponse %in% c(unique(dataInput()$data$Response)), 'Need a valid response option for the question'),
      need(input$timeService, 'Need a valid response option for the question')
    )
    
    data <- filter(
      dataInput()$data, 
      Response == input$timeResponse & Service == input$timeService
      & between(Year, input$timeFrom, input$timeTo)
    )
    
    plotly::ggplotly(time_series_graph(data, input$timeResponse, ""))
    
  })
  # 
  # observeEvent(input$timeDownload, {
  #   data <- filter(
  #     dataInput()$data, 
  #     Response == input$timeResponse & Service == input$timeService
  #     & between(Year, input$timeFrom, input$timeTo)
  #   )
  #   
  #   plot <- time_series_graph(data, input$timeResponse, "")
  #   
  #   ggsave(filename = "graph.svg", device = "svg", plot = plot)
  # })
  
  output$download1 <- downloadHandler(
    filename = "graph.svg",
    content = function(file) {
      data <- filter(
        dataInput()$data,
        Response == input$timeResponse & Service == input$timeService
        & between(Year, input$timeFrom, input$timeTo)
      )
      plot <- time_series_graph(data, input$timeResponse, "")
      print(file)
      ggsave(filename = file, device = "svg", plot = plot, height = 16.9, width = 25.4, units = "cm", dpi = 800)
    }
  )
  
}
