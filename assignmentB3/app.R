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
library(shinyjs)
library(colourpicker)
library(datateachr)
library(tidyverse)
library(dplyr)
library(DT)
library(scales)
library(markdown)
data(vancouver_trees)

ui <- fluidPage(
  # Feature 1 :Add CSS to make the app look nicer. The styles.css files set the background color to light blue.
  includeCSS("www/styles.css"),
  div(
    style = "text-align: center;",  # Center-align the contents
    titlePanel("Explore Vancouver Trees!"),
    
    # Feature 2 : Add an image to the UI.
    img(src = "img1.jpg")
  ),
  sidebarLayout(
    sidebarPanel(
      # Add some space above the sidebar
      style = "margin-top: 50px; width = 80%",  
      
      # Feature 3 : Show the number of results found whenever the filters change.
      dateRangeInput('dateRange',
                     label = 'Please select Time period: ',
                     start = as.Date("2000-01-01", "%Y-%m-%d"), end = as.Date("2023-01-01", "%Y-%m-%d"),
                     separator = "to",
                     width = "100%"
      ),
      
      
      # Feature 4: Use checkboxInput() to let users could decide whether they want to get data with NA values or not.
      checkboxInput("includeNA", "Include NA values", value = TRUE),
      
      # Feature 5: Add colourInput() to let the user decide on the colors of the bars in the plot.
      colourInput("barColor", "Choose Bar Color", value = "lightgreen"),
      textOutput("resultsCount"),
      
    ),
    
    mainPanel(
      h4("This plot shows the number of trees with different diameter within your selected time period."),
      plotOutput("id_histogram"),
      HTML(markdown(
        "Visit [this website](https://opendata.vancouver.ca/explore/dataset/street-trees/information/) to get more information about the data source."
      ))
      
    )
  )
)


server <- function(input, output){
  outputdata <- reactive({
    #users could decide whether they want to get data with NA values or not.
    if (input$includeNA) {
      vancouver_trees %>%
        filter(date_planted <= input$dateRange[2],
               date_planted >= input$dateRange[1])
    } else {
      vancouver_trees %>%
        filter(complete.cases(.),
               date_planted <= input$dateRange[2],
               date_planted >= input$dateRange[1])
    }
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
  
}

# Run the application
shinyApp(ui = ui, server = server)

