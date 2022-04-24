library(shiny)
library(plotly)
library(dplyr)
library(shinythemes)
library(data.table)
library(ggplot2)
library(shinydashboard)
library(knitr)
library(bslib)
shinyUI(
  
  dashboardPage(
    dashboardHeader(title = "Lung Cancer DashBoard"),
    
    dashboardSidebar(sidebarMenu(
      menuItem("LevelOfRisk",tabName="LevelOfRisk",icon=icon("temperature-high")),
      menuItem("Distribution_Of_Anomalies",tabName="Distribution_Of_Anomalies",icon=icon("money")),
      menuItem("prediction",tabName="prediction",icon=icon("snowflake"))
      
    )),
    dashboardBody(  
      tabItems(
        tabItem("Distribution_Of_Anomalies",
                fluidPage(
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot"), 
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    ),
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot1"), 
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                  ),
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot2"), 
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    ),
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot3"), 
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                  ),
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=12,
                      box(plotlyOutput("plot20"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                    
                  )
                )
        ),
        tabItem("LevelOfRisk",
                fluidPage(
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot4"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    ),
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot5"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                    
                  ),
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot6"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    ),
                    column(# width should be between 1 and 12
                      width=6,
                      box(plotlyOutput("plot7"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                    
                  ),
                  fluidRow(
                    column(# width should be between 1 and 12
                      width=12,
                      box(plotlyOutput("plot21"), 
                          
                          # For column based layouts, we can set box width to NULL
                          # This overrides the default value
                          width=NULL) 
                    )
                    
                  )
                )
        ),
        tabItem("prediction",
                fluidPage(
                  
                  theme = shinytheme("cerulean"),
                  title = "Probability of winning the Medal",
                  
                ),
                fluidRow(
                  column(# width should be between 1 and 12
                    width=4,
                    
                  ),
                  column(# width should be between 1 and 12
                    
                    width=8,
                    box(##textOutput("textoutput1"),
                      height = "220vh", title = "Probability of getting Lung Cancer",theme = shinytheme("cerulean"),
                      selectInput("GENDER", "GENDER", choices = c("M","F")),
                      numericInput("AGE", "AGE",  10, min = 1, max = 100),
                      selectInput("SMOKING", "SMOKING", choices = c(1,2)),
                      selectInput("YELLOW_FINGERS", "YELLOW_FINGERS", choices = c(1,2)),
                      selectInput("ANXIETY", "ANXIETY", choices = c(1,2)),
                      selectInput("PEER_PRESSURE", "PEER_PRESSURE", choices = c(1,2)),
                      selectInput("CHRONIC.DISEASE", "CHRONIC.DISEASE", choices = c(1,2)),
                      selectInput("FATIGUE", "FATIGUE", choices = c(1,2)),
                      selectInput("YELLOW_FINGERS", "YELLOW_FINGERS", choices = c(1,2)),
                      selectInput("ANXIETY", "ANXIETY", choices = c(1,2)),
                      selectInput("ALLERGY", "ALLERGY", choices = c(1,2)),
                      selectInput("WHEEZING", "WHEEZING", choices = c(1,2)),
                      selectInput("ALCOHOL.CONSUMING", "ALCOHOL.CONSUMING", choices = c(1,2)),
                      selectInput("COUGHING", "COUGHING", choices = c(1,2)),
                      selectInput("SHORTNESS.OF.BREATH", "SHORTNESS.OF.BREATH", choices = c(1,2)),
                      selectInput("SWALLOWING.DIFFICULTY", "SWALLOWING.DIFFICULTY", choices = c(1,2)),
                      selectInput("CHEST.PAIN", "CHEST.PAIN", choices = c(1,2)),
                      br(),
                      submitButton("Submit", icon("refresh")),
                      imageOutput("Alignment", height = "auto")
                    )
                    
                  )
                )
        )
      )
    )
  )
  
)
