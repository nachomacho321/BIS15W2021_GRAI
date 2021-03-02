#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
library(shinydashboard)
library(ggthemes)
options(scipen = 999)
UC_admit <- readr::read_csv("UC_admit.csv")
UC_admit<- UC_admit %>% 
    filter(Ethnicity!="All")
ui <- dashboardPage(
    dashboardHeader(title = "UC Enrollment Statistics"),
    dashboardSidebar(disable = F),
    dashboardBody(
        fluidRow(
            box(title = "Plot Options", width = 3,
                radioButtons("x", "Select Ethnicity", choices = c("International", "Unknown", "White", "Asian", "Chicano/Latino", "American Indian", "African American"),
                             selected = "International"),
                selectInput("y", "Select Campus", choices = c("Davis", "Irvine", "Berkeley", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"),
                            selected = "Irvine"),
                selectInput("z", "Select Admit Category", choices = c("Applicants", "Admits", "Enrollees"),
                            selected = "Enrollees"),
            ), # close the first box
            box(title = "UC Enrollment By Campus", width=7,
                plotOutput("plot", width = "600px", height = "500px")
            ) # close the second box
        ) # close the row
    ) # close the dashboard body
) # close the ui

server <- function(input, output, session) { 
    
    output$plot <- renderPlot({
        UC_admit %>% 
            filter(Ethnicity==input$x & Campus==input$y & Category==input$z) %>% 
            ggplot(aes(x=Academic_Yr, y=FilteredCountFR)) + 
            geom_col(color="black", fill="slateblue2", alpha=1)+
            theme_gdocs()+
            theme(axis.text.x = element_text(angle = 60, hjust = 1))+
            labs(x = "Academic Year", y = "Number of Students")+
            scale_x_continuous(breaks = scales::pretty_breaks(n = 10))
        
    })
    
    # stop the app when we close it
    session$onSessionEnded(stopApp)
}

shinyApp(ui, server)