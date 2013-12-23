library(openair)
# Read in met data from two monitors
pete.ratts<-read.csv("PR_LocalMet_10m.csv")
evansville<-read.csv("EVV10mMET_11103.csv")

# Create a data frame
wind.df<-data.frame(month=pete.ratts$Month, day=pete.ratts$JulianDay,
                   pr.ws=pete.ratts$WindSpeed, pr.wd=pete.ratts$WindDirection,
                   ev.ws=evansville$WindSpeed, ev.wd=evansville$WindDirection)

# A windrose function that takes a date range and a site name
wR <- function(range, site){
  
  # subset wind speed and wind direction by day
  ws <- wind.df[wind.df$day %in% seq(range[1], range[2]), paste0(site, ".ws")]
  wd <- wind.df[wind.df$day %in% seq(range[1], range[2]), paste0(site, ".wd")]
  
  # create data frame
  w.df <- data.frame(ws,wd)
  
  # plot wind rose from openair package
  windRose(w.df,ws="ws",wd="wd",grid.line=5,annotate=FALSE,
             key.position="right",offset=3, breaks=5,paddle=FALSE,
             key.footer="Wind Speed (m/s)")  
      
}

################################################################################

# Define server logic 
shinyServer(function(input, output) {
  
  # Generate the plot 
  output$Plot <- renderPlot({
    wR(range = input$range, site = input$site)
    })
})
