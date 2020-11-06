library("datasets")
data("airquality")

# Data Pre-processing

str(airquality)
head(airquality)

col1<- mapply(anyNA,airquality) # apply function anyNA() on all columns of airquality dataset
col1

# Ozone and Solar.R attributes have NA

# Impute monthly mean in Ozone
for (i in 1:nrow(airquality)){
  if(is.na(airquality[i,"Ozone"])){
    airquality[i,"Ozone"]<- mean(airquality[which(airquality[,"Month"]==airquality[i,"Month"]),"Ozone"],na.rm = TRUE)
  }
  # Impute monthly mean in Solar.R
  if(is.na(airquality[i,"Solar.R"])){
    airquality[i,"Solar.R"]<- mean(airquality[which(airquality[,"Month"]==airquality[i,"Month"]),"Solar.R"],na.rm = TRUE)
  }
  
}

col1<- mapply(anyNA,airquality) # apply function anyNA() on all columns of airquality dataset
col1

#Normalize the dataset so that no particular attribute has more impact on clustering algorithm than others.
normalize<- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
airquality<- normalize(airquality) # replace contents of dataset with normalized values
airquality <- airquality[,c("Ozone","Wind","Temp")]
str(airquality)
head(airquality)
class(airquality)
airquality

# Shiny App

library(shiny)

aqFit <- lm(Ozone ~ Wind + Temp, data = airquality)

shinyServer(function(input, output) {
  aqPred <- reactive({
    WindInput <- input$Wind
    TempInput <- input$Temperature
    predict(aqFit, newdata = data.frame(
      Wind = WindInput,
      Temp = TempInput
    ))
  })
  output$OzonePred<- renderText({
    aqPred()
  })
})