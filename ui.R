library(shiny)

# Define UI 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Wind Rose, 2010"),
  
  # Sidebar with controls to select the date range and monitor
  sidebarPanel(
    sliderInput("range", "Range (Julian Day):",
                min = 1, max = 365, value = c(1, 365)),
    
    selectInput("site", "Site:",
                list( "Petersburg/Ratts" = "pr",
                      "Evansville" = "ev"))
),
  
  mainPanel(
    plotOutput("Plot")
    )
))
