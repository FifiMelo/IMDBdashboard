library(shiny)
library(plotly)


ui <- fluidPage(


    titlePanel("Projekt 2"),

    fluidRow(
      column(6, 

             checkboxGroupInput("plec",
                                "Którą płeć wybierasz?",
                                unique(nowiaktorzy$gender)),
    ),
  ),
  
    fluidRow(
      column(6,
 
             plotlyOutput("pointPlot")
    )
  )
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
             yaxis = list(title = 'Ilość filmów', range=c(0,250)))
    
  })
}


shinyApp(ui = ui, server = server)


