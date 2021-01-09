library(shiny)
library(tidyverse)
library(devtools)
library(WDI)

gapm <- gapminder::gapminder %>%
  filter(country %in% g7) %>%
  select(country, year, gdpPercap, lifeExp) %>%
  group_by(country)