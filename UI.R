library(shiny)

shinyUI(fluidPage(
  titlePanel("Ozone Prediction"),
  sidebarLayout(
    sidebarPanel(
      p("Please fill Wind and Temperature Values"),
      sliderInput("Wind", "Average Wind Speed in Miles per Hour", 
                  min = 0, max = 0.05, step = 0.01, value = 0.03),
      sliderInput("Temperature", "Temperature in Degrees F", 
                  min = 0.16, max = 0.29, step = 0.05, value = 0.23)
    ),
    mainPanel(
      h3("Air Ozone content in Parts per billion is:"),
      h4(textOutput("OzonePred")),
      p("The prediction is based on a multiple linear regression from the AirQuality data set.")
    )
  )
)
)