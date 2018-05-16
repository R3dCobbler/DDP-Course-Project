library(dplyr)
chicago <- readRDS("chicago.rds")
chicago <- select(chicago, tmpd:pm25tmean2) %>%
    rename(temp = tmpd, dewpoint = dptp, pm25 = pm25tmean2) %>%
    mutate(pm25detrend = pm25 - mean(pm25, na.rm = TRUE)) %>% 
    rename(poll = pm25detrend) 
head(chicago)

library(shiny)
shinyUI(fluidPage(
    titlePanel("Explore different models"),
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

    

