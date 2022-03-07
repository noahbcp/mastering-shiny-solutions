{
    library(shiny)
    
    ui <- fluidPage(
        sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
        sliderInput('y', label = 'If y is', min = 1, max = 50, value = 30),
        "then, (x * y) is", textOutput("product"),
        "and, (x * y) + 5 is", textOutput("product_plus5"),
        "and (x * y) + 10 is", textOutput("product_plus10")
    )
    
    server <- function(input, output, session) {
        # Create a reactive expression `multiply()` to calculate the product of x & y
        multiply <- reactive({
            prod(input$x, input$y)
        })
        
        output$product <- renderText({ 
        multiply()
        })
        
        output$product_plus5 <- renderText({
            sum(multiply(), 5)
        })
        
        output$product_plus10 <- renderText({
            sum(multiply(), 10)
        })
    }
    
    shinyApp(ui, server)
}
