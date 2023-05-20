#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

actors <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/actors.csv", sep = ";")
films <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/films.csv", sep =";")
nominations <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/nominations.csv", sep = ";")

library(shinydashboard)
library(shiny)


# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(title = "render Boxes"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Test", tabName = "Test")
    )
  ),
  
  dashboardBody(
    includeCSS("./style.css"),
    tabItems(
      tabItem(tabName = "Test",
              fluidRow(
                tabPanel("Boxes",uiOutput("myboxes"))
              )  
      )
    )   
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  boxes <- list()
  for (i in 1:nrow(actors)){
    boxes[[i]] <- box(
                  width = 3,
                  class = "actor",
                  h3(actors$name[i]),
                  br(),
                  p(paste("full name:",actors$full.name[i])),
                  br(),
                  p(paste0("born: ", actors$birth.date[i],", ", actors$birth.place[i])),
                  br(),
                  div(class = "gallery-button", style="display:inline-block",
                      actionButton(paste("gallery", actors$id[i]),  "gallery", class="button")
                  ),
                  div(class = "biography-button", style="display:inline-block",
                      actionButton(paste("bio", actors$id[i]),"biography", class = "button")
                  ),
                  div(class = "films-button", style="display:inline-block",
                      actionButton(paste("bio", actors$id[i]),"films", class = "button")
                  ),
                  div(class = "awards-button", style="display:inline-block",
                      actionButton(paste("bio", actors$id[i]),"awards", class = "button")
                  ),
                  
    )
                  
  }
  output$myboxes <- renderUI(boxes)

}

# Run the application 
shinyApp(ui = ui, server = server)
