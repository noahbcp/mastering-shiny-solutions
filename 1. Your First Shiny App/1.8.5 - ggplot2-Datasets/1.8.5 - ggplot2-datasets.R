library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
    selectInput("dataset", "Dataset", choices = datasets),
    verbatimTextOutput("summary"),
    plotOutput("plot") #`tableOutput corrected to plotOutput`
)

server <- function(input, output, session) {
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    output$summary <- renderPrint({ #extra 'm' in 'summary'
        summary(dataset())
    })
    output$plot <- renderPlot({
        plot(dataset())},  #missing parenthesis on `dataset` reactive function
        res = 96)
}

shinyApp(ui, server)