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

library(stringr)
library(shiny) # basic shiny related functions and features
library(shinydashboard) # for dashboard related functions and features
library(shinyBS) # for modal 
library(shinyjs) # easy javascript functionalities with shiny
library(DT) # for interactive data tables
library(ggplot2) # for ggplot plot
library(shinycssloaders)
library(dplyr)

# strsplit(actors$image.urls[1], "', '")[[1]][2]



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
    
    # galeria
    image_urls <- strsplit(actors$image.urls[i], "', '")[[1]]
    image_urls[1] <- str_sub(image_urls[1], 3)
    image_urls[length(image_urls)] <- str_sub(image_urls[length(image_urls)], 0, -3)
    images <- list()
    for(j in 1:10) {
      images[[j]] <- img(src = image_urls[j], width = 400, height = 400)
    }
    
    #filmy
    film_ids <- strsplit(actors$film.ids[i], "', '")[[1]]
    film_ids[1] <- str_sub(film_ids[1], 3)
    film_ids[length(film_ids)] <- str_sub(film_ids[length(film_ids)], 0, -3)
    current_films <- list()
    for(j in 1:length(film_ids)) {
      films %>% 
        filter(id == film_ids[j]) -> film
      current_films[[j]] <- div(
        class = "film",
        style="display:inline-block",
        h3(film$title),
        br()
      )
    }
    
    
    #nagrody
    act.id <- actors$id[i]
    nominations %>% 
      filter(actor.id == actor.id) -> nominations_df
    current_nominations <- list()
    for(j in 1:nrow(nominations_df)) {
      current_nominations[[j]] <- div(
        class = "nomination",
        style="display:inline-block",
        h3(nominations_df$event.name[j]),
        h4(nominations_df$category[j]),
        p(paste0("Won: ", current_nominations$is.winner[j])),
        p(paste0("Year: ", current_nominations$year[j])),
        br()
      )
    }
    
    
    
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
                      actionButton(paste0("gallery", actors$id[i]),  "gallery", class="button")
                  ),
                  bsModal(id = paste0("gallerymodal", actors$id[i]), title = paste0(actors$name[i], "'s gallery"), trigger = paste0("gallery", actors$id[i]), size="large",
    
                    images
                    
                  ),

                  div(class = "biography-button", style="display:inline-block",
                      actionButton(paste0("bio", actors$id[i]),"biography", class = "button")
                  ),
                  bsModal(id = paste0("biomodal", actors$id[i]), title = paste0(actors$name[i], "'s biography"), trigger = paste0("bio", actors$id[i]), size="large",
                          p(actors$bigraphy[i])
                  ),

                  
                  div(class = "films-button", style="display:inline-block",
                      actionButton(paste0("films", actors$id[i]),"films", class = "button")
                  ),
                  bsModal(id = paste0("filmsmodal", actors$id[i]), title = paste0(actors$name[i], "'s filmography"), trigger = paste0("films", actors$id[i]), size="large",
                          current_films
                  ),
                  

                  
                  div(class = "awards-button", style="display:inline-block",
                      actionButton(paste0("awards", actors$id[i]),"awards", class = "button")
                  ),
                  bsModal(id = paste0("awardsmodal", actors$id[i]), title = "Plot", trigger = paste0("awards", actors$id[i]), size="large",
                          current_nominations,
                          br()
                  ),
                  

                  
    )
                  
  }
  output$myboxes <- renderUI(boxes)

}

# Run the application 
shinyApp(ui = ui, server = server)
