library(dplyr)

chicago <- readRDS("chicago.rds")

chicago <- select(chicago, tmpd:pm25tmean2, pm10tmean2, o3tmean2) %>%
    rename(Temperature = tmpd, Dewpoint = dptp, pm25 = pm25tmean2,
           pm10 = pm10tmean2, o3 = o3tmean2) %>%
    mutate(Fine_Particle = pm25 - mean(pm25, na.rm = TRUE),
           Dust_Particle = pm10 - mean(pm10, na.rm = TRUE),
           Ozone = o3 - mean(o3, na.rm = TRUE))

head(chicago)

chicago <- chicago[!is.na(chicago$Fine_Particle),]
chicago <- chicago[!is.na(chicago$Dust_Particle),]
chicago <- chicago[!is.na(chicago$Ozone),]
chicago <- chicago[!is.na(chicago$Temperature),]


library(shiny)

shinyUI(fluidPage( 
    tags$h1("Interactive Pollution and Temperature App"),
    tags$h3("Part of the Coursera Developing Data Products course"),
    tags$p("This Shiny app looks at the relationship between temperature and fine particle pollution, measured on a daily basis between 1987 and 2005 in the city of Chicago, USA"),
    tags$p("More detail of the data can be found at the link below"),
    tags$a(href = "https://www.airnow.gov/index.cfm?action=aqibasics.particle", "Particle Pollution"),
    tags$br(),
    tags$hr(),
    tags$h3("Instructions"),
    tags$p("The example below fits a linear model for the selected points and then draws a line of best fit for the resulting model."),
    tags$p("Using your mouse, click and drag to 'draw' a selection of points in the chart below."),
    tags$p("Once you have made a selection, you will see the regression line, and the associated slope and intercept values for that selection, in the widget box on the left."),
    tags$p("If you select an area with no points, you will see a 'No Model Found' message instead."),
    tags$p("If you do manage to get an error message, just right-click and hit 'reload'."),
    tags$p("Have fun!"),
    tags$hr(),
    
    titlePanel("Explore Linear Models"),
    sidebarLayout(
        sidebarPanel(
            h3("Widget Box"),
            tags$br(),
            h4("Slope"),
            textOutput("slopeOut"),
            h4("Intercept"),
            textOutput("intOut")
        ),
        mainPanel(
            plotOutput("plot1", brush = brushOpts(
                id = "brush1"
            ))
        )
        ),
    tags$hr(),
    tags$p("Author: Mick Sheahan, May 17th 2018")
))


    

