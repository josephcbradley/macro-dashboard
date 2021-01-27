library(tidyverse)
library(gapminder)
library(data.table)
library(profvis)

g7 <-
  c("United Kindom", "United States", "France", "Italy", "Germany", "Japan")

gapm <- 
  as.data.table(gapminder::gapminder)[
    country %in% g7, 
    .(country, year, gdpPercap, lifeExp),
  ]


profvis(
  {
    plot_data <- gapm[, index := (100*gdpPercap)/gdpPercap[year==2002], by = country]
    
    ggplot(
      plot_data,
      aes(x = year, colour = country, y = index)) +
      geom_line() +
      scale_x_continuous(NULL) +
      scale_y_continuous(NULL) +
      labs(
        title = "GDP per capita",
        subtitle = sprintf("%s = 100", 2002)
      ) 
  }
)
