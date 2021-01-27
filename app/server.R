library(shiny)
library(ggplot2)
library(gapminder)
library(data.table)

g7 <-
    c("United Kindom", "United States", "France", "Italy", "Germany", "Japan")

gapm <- 
    as.data.table(gapminder::gapminder)[
        country %in% g7, 
        .(country, year, gdpPercap, lifeExp),
        ]





# 1952- 2007, 5s


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$gdpPcPlot <- renderPlot({
        plot_data <- gapm[, index := (100*gdpPercap)/gdpPercap[year==input$base_year], by = country]
        
            ggplot(
                plot_data,
                aes(x = year, colour = country, y = index)) +
            geom_line() +
            scale_x_continuous(NULL) +
            scale_y_continuous(NULL) +
            labs(
                title = "GDP per capita",
                subtitle = sprintf("%s = 100", input$base_year)
            )

    })
    
    output$popPlot <- renderPlot({
        
        plot_data <- gapm[, index := (100*lifeExp)/lifeExp[year==input$base_year], by = country]
        
        ggplot(
            plot_data,
            aes(x = year, colour = country, y = index)) +
            geom_line() +
            scale_x_continuous(NULL) +
            scale_y_continuous(NULL) +
            labs(
                title = "Life expectancy",
                subtitle = sprintf("%s = 100", input$base_year)
            )
    })

})
