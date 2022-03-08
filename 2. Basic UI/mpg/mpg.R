library(shiny)
library(tidyverse)

## Summarises ggplot2::mpg by manufacturer, model & year and splits by manufacturer
## Loop serves to fill each sublist with a string including each car model and year
## Finally, each sublist is named so selectInput can parse them as choices

cars <- ggplot2::mpg %>%
    summarise(manufacturer, model, year) %>% 
    group_by(manufacturer) %>% 
    group_split()
choices <- list()
i <- 1
while (i <= length(cars)) {
    choices[i] = list(paste(cars[[i]]$model, cars[[i]]$year))
    i <- i + 1
}
names(choices) <- unique(mpg$manufacturer)

ui <- fluidPage(
  selectInput(inputId = 'selected_car', label = 'Select a car')
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)