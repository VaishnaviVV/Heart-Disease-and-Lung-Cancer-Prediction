library(shiny)
library(plotly)
library(dplyr)
library(shinythemes)
library(data.table)
library(ggplot2)
shinyUI(
  
  dashboardPage(
    dashboardHeader(title = "OLYMPIC GAMES"),
    
    dashboardSidebar(sidebarMenu(
      menuItem("prediction",tabName="prediction",icon=icon("snowflake"))
      
    )),
    dashboardBody(  
      tabItems(
        
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
                      height = "180vh", title = "Probability of getting Lung Cancer",theme = shinytheme("cerulean"),
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





