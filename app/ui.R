library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Macro Dashboard"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("base_year",
                        "Base Year:",
                        min = 1952L,
                        max = 2007L,
                        value = 1997L, 
                        step = 5L,
                        sep = "")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("GDP per capitca", plotOutput("gdpPcPlot")),
                        tabPanel("Life expectancy", plotOutput("popPlot"))
            )
        )
    )
))
