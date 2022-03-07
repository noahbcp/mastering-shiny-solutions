library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")

ui <- fluidPage(
    selectInput(inputId = "dataset", label = "Dataset", choices = datasets),
    verbatimTextOutput(outputId = "summary"),
    tableOutput(outputId = "plot")
)

server <- function(input, output, session) {
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    
    output$summary <- renderPrint({
        summary(dataset())
    })
    
    output$plot <- renderPlot({
        plot(dataset()) #missing () on `dataset`
    }, res = 96)
}

shinyApp(ui, server)

library(shiny)