library(dplyr)
chicago <- readRDS("chicago.rds")

chicago <- select(chicago, tmpd:pm25tmean2) %>%
    rename(temp = tmpd, dewpoint = dptp, pm25 = pm25tmean2) %>%
    mutate(pm25detrend = pm25 - mean(pm25, na.rm = TRUE)) %>% 
    rename(poll = pm25detrend)
head(chicago)

chicago <- chicago[!is.na(chicago$poll),]
chicago <- chicago[!is.na(chicago$temp),]


library(shiny)
shinyUI(fluidPage( 
    tags$h1("Developing Data Products Course Project"),
    tags$p("This Shiny app looks at the relationship between temperature and fine particle pollution, measured on a daily basis between 1987 and 2005 in the city of Chicago, USA"),
    tags$p("More detail of the data can be found at the link below"),
    tags$a(href = "https://www.airnow.gov/index.cfm?action=aqibasics.particle", "Chicago Data"),
    tags$br(),
    tags$hr(),
    tags$h3("Instructions"),
    tags$p("This example fits a linear model for the selected points and then draws a line of best fit for the resulting model."),
    tags$p("Using your mouse, click and hold to 'draw' a selection of points in the chart below."),
    tags$p("Once you have made a selection, you will see the regression line, and the associated slope and intercept values for that selection, in the box on the left."),
    tags$p("If you select an area with no points, you will see a 'No Model Found' message instead."),
    tags$p("If you do manage to get an error message, just right-click and hit 'reload'."),
    tags$p("Have fun!"),
    tags$hr(),

    titlePanel("Explore the model"),
    sidebarLayout(
        sidebarPanel(
            h3("Slope"),
            textOutput("slopeOut"),
            h3("Intercept"),
            textOutput("intOut")
        ),
        mainPanel(
            plotOutput("plot1", brush = brushOpts(
                id = "brush1"
            ))
        )
    )
))

    

