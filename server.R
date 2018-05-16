library(shiny)
shinyServer(function(input, output) {
    model <- reactive({
        brushed_data <- brushedPoints(chicago, input$brush1,
                                      xvar = "temp", yvar = "poll")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(poll ~ temp, data = brushed_data)
    })
    output$slopeOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][2]
        }
    })
    
    output$intOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][1]
        }
    })
    output$plot1 <- renderPlot({
        plot(chicago$temp, chicago$poll, xlab = "Temperature",
             ylab = "Particle Pollution", main = "Relationship between temperature and particle pollution in Chicago 1987 - 2005",
             cex = 1.5, pch = 16, col = "darkgreen", bty = "n")
        if(!is.null(model())){
            abline(model(), col = "red", lwd = 2)
        }
    })
})
