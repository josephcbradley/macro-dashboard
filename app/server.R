library(shiny)
library(tidyverse)
library(gapminder)
library(data.table)

g7 <-
    c("United Kindom", "United States", "France", "Italy", "Germany", "Japan")

gapm <- gapminder::gapminder %>%
    filter(country %in% g7) %>%
    select(country, year, gdpPercap, lifeExp) %>%
    group_by(country)

# 1952- 2007, 5s


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$gdpPcPlot <- renderPlot({
        
        gapm %>% 
            group_modify(
                ~mutate(.x,
                        base = gdpPercap[which(year == input$base_year)],
                        index = (gdpPercap / base) * 100
                )
            ) %>%
            ggplot(aes(x = year, colour = country, y = index)) +
            geom_line() +
            scale_x_continuous(NULL) +
            scale_y_continuous(NULL) +
            labs(
                title = "GDP per capita",
                subtitle = sprintf("%s = 100", input$base_year)
            )

    })
    
    output$popPlot <- renderPlot({
        
        gapm %>% 
            group_modify(
                ~mutate(.x,
                        base = lifeExp[which(year == input$base_year)],
                        index = (lifeExp / base) * 100
                )
            ) %>%
            ggplot(aes(x = year, colour = country, y = index)) +
            geom_line() +
            scale_x_continuous(NULL) +
            scale_y_continuous(NULL) +
            labs(
                title = "Life expectancy",
                subtitle = sprintf("%s = 100", input$base_year)
            )
        
    })

})
