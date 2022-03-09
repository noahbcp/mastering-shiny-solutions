library(shiny)
library(tidyverse)

## Summarises ggplot2::mpg by manufacturer, model & year and splits by manufacturer
## Loop serves to fill each sublist with a string including each car model and year
## Finally, each sublist is named so selectInput can parse them as choices

cars <- ggplot2::mpg %>%
    summarise(manufacturer, model, year, trans) %>% 
    group_by(manufacturer) %>% 
    group_split()
car_choices <- vector(mode = "list", length = length(cars)) #Create empty list to populate with choices

i <- 1
while (i <= length(cars)) {
    car_choices[i] = list(str_to_title(paste(cars[[i]]$model, cars[[i]]$year, cars[[i]]$trans)))
    i <- i + 1
}
names(car_choices) <- str_to_title(unique(mpg$manufacturer))

ui <- fluidPage(
  selectInput(inputId = 'selected_car', label = 'Select a car', choices = car_choices),
  dataTableOutput('mpg.selected')
)

server <- function(input, output, session) {
  ## Reactive expression that matches the selected car model to corresponding position in `mpg`
  mpg.int <- reactive({
    as.integer(which(simplify(car_choices) == input$selected_car))
    })
  ## Renders a datatable without searching that includes the selected car model's data from `mpg`
  output$mpg.selected <- renderDataTable({
    mpg[mpg.int(), ]}, 
    options = list(
      searching = FALSE))
}

shinyApp(ui, server)