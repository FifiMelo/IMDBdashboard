#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
  
  
    titlePanel("Projekt 2"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("hist")
        )
    ),
    
    sliderInput("zakres",
                "Wybierz zakres lat:",
                value = c(1954, 1979),
                min = min(new_aktorzy$date),
                max = max(new_aktorzy$date),
                step = 1),
    
    plotlyOutput("piechart"),
    
    # fluidRow(
    #   column(6, 
    #          
    #          checkboxGroupInput("plec",
    #                             "Którą płeć wybierasz?",
    #                             unique(new_aktorzy$gender)),
    #   ),
    # ),
    
    plotlyOutput("barplot"),
    
    fluidRow(
      column(6,
             
      )
    )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$hist <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- new_aktorzy$date
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Rok urodzenia aktorów',
             ylab = 'Ilość aktorów',
             xlim = c(min(x), max(x)),
             ylim = c(0,12),
             main = 'Histogram urodzeń aktorów')
    })
    
    output$piechart <- renderPlotly({
      
      df <- new_aktorzy %>% 
        filter(date >= input$zakres[1],
               date <= input$zakres[2])  %>% 
        count(gender)
        
      
      plot_ly(df, labels = ~gender, values = ~n, text = ~n, type = 'pie')%>% 
        layout(title = paste('Procentowa ilość aktorów i aktorek urodzonych w latach', input$zakres[1], '-',input$zakres[2]),
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
    })
    
    
    output$barplot <- renderPlotly({
      
      plot_ly(df_nom, x = ~name, y = ~n, type = "bar", text = ~n, textposition = 'auto', 
              marker = list(color = 'rgb(158,202,225)', line = list(color = 'rgb(8,48,107)', width = 1.5))) %>% 
        layout(title = 'Wygrane nagrody na poszczególnych aktorów')
      
      
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
