#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Loading library of required app packages
library(shiny)
library(colourpicker)
library(datateachr)
library(tidyverse)
library(dplyr)
library(DT)
library(scales)
library(markdown)
data(vancouver_trees)

ui <- fluidPage(
  # Feature 1 & 2:Add CSS to make the app look nicer. Image embedded to make the background looks nicer. 
  includeCSS("www/styles.css"),
  div(
    style = "text-align: center;",  # Center-align the contents
    tags$div(style = "height: 20px;"),
    titlePanel(
      h1("Explore Vancouver Trees!")
    ),
    HTML(markdown(
      "Visit [this website](https://opendata.vancouver.ca/explore/dataset/street-trees/information/) to get more information about the data source."
    ))
  ),
  sidebarLayout(
    sidebarPanel(
      # Add some space above the sidebar
      style = "margin-top: 100px; width = 80%",  
      
      # Feature 3 : Add dateRangeInput() for filtering date planted. Show the number of results found whenever the filters change.
      dateRangeInput('dateRange',
                     label = 'Select date planted: ',
                     start = as.Date("2000-01-01", "%Y-%m-%d"), end = as.Date("2023-01-01", "%Y-%m-%d"),
                     separator = "to",
                     width = "100%"
      ),
      
      # Feature 4(New feature 1): Add sliderInput() for filtering height_range_id.
      sliderInput("heightRange", "Select height_range_id of trees:",
                  min = 0, max = 10, value = c(0, 10)),
      
      # Feature 5(New feature 2): Add selectInput() for filtering boolean variable 'curb', 'assigned' and 'root_barrier'
      selectInput("curbFilter", "Filter by Curb:", c("All", "Y", "N")),
      selectInput("assignedFilter", "Filter by Assigned:", c("All", "Y", "N")),
      selectInput("root_barrierFilter", "Filter by Root_barrier:", c("All", "Y", "N")),
      
      # Feature 6: Use checkboxInput() to let users could decide whether they want to get data with NA values or not.
      checkboxInput("includeNA", "Include NA values", value = TRUE),
      textOutput("resultsCount")
      
    ),
    
    mainPanel(
      # Add some space above the main bar
      style = "margin-top: 50px; width = 60%;", 
      # Feature 7(New feature 3): Add tabsetPanel() to create an interface with multiple tabs.
      h3("View different features of vancouver trees through table or plot."),
      tabsetPanel(
        type = "tabs",
        tabPanel("Table",
                 # Feature 8(New feature 4): Allow the user to download table as a .csv file
                 downloadButton("downloadTable", "Download Table to CSV"),
                 # Feature 9(New feature 5): Use the DT package to turn a static table into an interactive table.
                 DT::dataTableOutput("id_table")
        ),
        tabPanel("Plot",
                 h4("View the number of trees with different diameters using your favorite color."),
                 # Feature 10: Add colourInput() to let the user decide on the colors of the bars in the plot.
                 colourInput("barColor", "Choose Bar Color", value = "lightblue"),
                 plotOutput("id_histogram")   
        )
      )
    ),
  )
)

server <- function(input, output){
  outputdata <- reactive({
    #users could decide whether they want to get data with NA values or not.
    filtered_data <- vancouver_trees %>%
      filter(date_planted <= input$dateRange[2],
             date_planted >= input$dateRange[1],
             height_range_id >= input$heightRange[1],
             height_range_id <= input$heightRange[2])
    
    if (!input$includeNA){
      filtered_data <- filtered_data %>%
        filter(complete.cases(.))
    }
    
    
    #users could decide whether they want to filter data with 'curb', 'assigned' and 'root_barrier'.
    if (input$curbFilter == "Y") {
      filtered_data <- filtered_data %>% filter(curb == 'Y')
    } else if (input$curbFilter == "N") {
      filtered_data <- filtered_data %>% filter(curb == 'N')
    }
    
    if (input$assignedFilter == "Y") {
      filtered_data <- filtered_data %>% filter(assigned == 'Y')
    } else if (input$assignedFilter == "N") {
      filtered_data <- filtered_data %>% filter(assigned == 'N')
    }
    
    if (input$root_barrierFilter == "Y") {
      filtered_data <- filtered_data %>% filter(root_barrier == 'Y')
    } else if (input$root_barrierFilter == "N") {
      filtered_data <- filtered_data %>% filter(root_barrier == 'N')
    }
    
    filtered_data
  })
  
  # Display the number of results found
  output$resultsCount <- renderText({
    paste("Number of results found: ", nrow(outputdata()))
  })
  
  plot_filtered <- reactive({
    outputdata() %>%
      ggplot(aes(diameter)) +
      geom_histogram(binwidth = 1,fill = input$barColor) +
      scale_x_continuous(limits = c(0, 60)) +
      scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), # Set scales to be 10^n
                    labels = trans_format("log10", math_format(10^.x))) 
    
  })
  
  output$id_histogram <- renderPlot({
    plot_filtered()
  })
  
  output$id_table <- DT::renderDataTable(DT::datatable({
    data <- outputdata() 
  })
  )
  
  output$downloadTable <- downloadHandler(
    filename = ("vancouver_trees.csv"),
    content = function(file) {
      write.csv(outputdata(), file)
    }
  )
  
  
}

# Run the application
shinyApp(ui = ui, server = server)