#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinycssloaders)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # App title ----
  titlePanel(strong("AFCAS section 1 (A008, A603, A001, A004, A002) dashboard")),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      helpText("All data is publicly available on gov.uk. This dashboard was created by an individual just messing around with RShiny"),
      # Input: select for choice ----
      selectInput(inputId = "code",
                  label = "Question code: ",
                  choices = c("A008", "A603", "A001", "A004", "A002"),
                  selected = "A008"
                  ),
      
      helpText(strong(p("Question text:")), textOutput("qText"))
      
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      div(
        style = "width: 95%;",
        fluidRow( 
          column(
            width = 4,
            selectInput(inputId = "timeResponse",label = "Question response:", choices = "", selected = 1)
          ),
          column(
            width = 4,
            selectInput(inputId = "timeService",label = "Service:", choices = c("Tri-Service", "Royal Navy", "Royal Marines", "Army", "RAF"), selected = "Tri-Service")
          ),
          column(
            width = 4,
            selectInput(inputId = "timeFrom",label = "From:", choices = "", selected = 1),
            selectInput(inputId = "timeTo",label = "To:", choices = "", selected = 1)
          )
        ),
        div(
          style = "width: 95%;",
          fluidRow(
            withSpinner(plotlyOutput(outputId = "timePlot"))
          )
        ),
        fluidRow(
          column(
            width = 2,
            offset = 9,
            # actionButton("timeDownload", "Dowload")
            downloadButton("download1")
          )
          
        )
      )
      
    )
  )
)
