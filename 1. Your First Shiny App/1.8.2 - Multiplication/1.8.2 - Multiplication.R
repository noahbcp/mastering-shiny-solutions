{
library(shiny)

ui <- fluidPage(
    sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
    sliderInput('y', label = 'If y is', min = 1, max = 50, value = 30),
    sliderInput('c', label = 'If c is', min = 1, max = 50, value = 30),
    "then, (x * y) is", textOutput("product"),
    "and, (x * y) + 5 is", textOutput("product_plus5"),
    "and (x * y) + 10 is", textOutput("product_plus10"),
    "and (x * y) + c is", textOutput('product_plusc')
)

server <- function(input, output, session) {
    # Create a reactive expression `multiply()` to calculate the product of `x` & `y` and add a value, `c`.
    multiply <- reactive({
        function(x, y, c) {
            sum(prod(x, y), c)
        }
    })
    
    output$product <- renderText({ 
        multiply()(input$x, input$y, 0) # Note that reactive expressions with functions within must be called with reactive()(fn.var1, ...)
    })
    
    output$product_plus5 <- renderText({
        multiply()(input$x, input$y, 5)
    })
    
    output$product_plus10 <- renderText({
        multiply()(input$x, input$y, 10)
    })
    
    output$product_plusc <- renderText({
        multiply()(input$x, input$y, input$c)
    })
}

shinyApp(ui, server)
}
