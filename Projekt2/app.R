library(shiny)
library(plotly)


ui <- fluidPage(

    titlePanel("Projekt 2"),

    fluidRow(
      column(6, 

             checkboxGroupInput("plec",
                                "Którą płeć wybierasz?",
                                unique(nowiaktorzy$gender))

    ),
  ),
  
    fluidRow(
      column(12,
 
             plotlyOutput("pointPlot")
    )
  ),
  
  fluidRow(
    column(12,
           
           plotlyOutput("histPlot")
    )
  ),
  
  
  fluidRow(
    column(12,
           
           sliderInput("zakres",
                       "Rok",
                       value = c(min(filmy$yearn), max(filmy$yearn)),
                       min = min(filmy$yearn),
                       max = max(filmy$yearn),
                       step = 2)
    )
  ),
  
  
  h4("Zdjęcie"),
  uiOutput("img")
)


server <- function(input, output) {

  output$pointPlot <- renderPlotly({
    
    plot_ly(nowiaktorzy %>% 
              filter(nowiaktorzy$gender %in% input$plec), 
            x = ~date,
            y = ~ilosc_filmow,
            color = ~gender,
            colors = "Set1") %>% 
      layout(title = "Zależność między rokiem urodzenia a ilością zagranych filmów", 
             xaxis = list(title = 'Rok urodzenia', range=c(1940,2020)), 
             yaxis = list(title = 'Ilość filmów', range=c(0,250)),
             legend = list(orientation = "h", x = 0.35, y = -0.2))
    
  })
  
  output$histPlot <- renderPlotly({
    
    plot_ly(filmy %>% 
              filter(filmy$yearn >= input$zakres[1],
                     filmy$yearn <= input$zakres[2]) ,
            x = ~year,
            type = "histogram") %>% 
      layout(barmode="overlay",
             title = "Ilość wydanych filmów w danym roku",
             xaxis = list(title = "Rok", color ="black", tickangle = 45), 
             yaxis = list(title = 'Ilość filmów', range=c(0,450)))
    
  })

  
}


shinyApp(ui = ui, server = server)


