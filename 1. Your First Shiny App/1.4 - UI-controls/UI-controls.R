{
library(shiny)

## UI block defines the frontend
ui <- fluidPage(
  selectInput(inputId = 'dataset', label = 'Dataset', choices = ls('package:datasets')), #Creates a dropdown list which can be selected from
  verbatimTextOutput('summary'), #Verbatim text of the selected dataset will be saved under the ID 'summary'
  tableOutput(outputId = 'table'), #Reactive table of the selected dataset will be saved under the ID 'table'
  title = 'R Datasets' #Defines the page title used by browser window
)

## Server block defines the backend
server <- function(input, output, session) {
    #Create a reactive expression
    dataset <- reactive({ #reactive() is used to minimise code duplications. Acts similar to a function but result is cached until it needs to be updated.
        get(input$dataset, 'package:datasets') #fetches the selected dataset, defines it as 'dataset'
    })
  output$summary <- renderPrint({ #Renders the following code block
      summary(dataset()) #reactive expressions are ran like functions
      })
  output$table <- renderTable({ #Renders the following code block as a table
      dataset()
  })
}

shinyApp(ui, server)
}
