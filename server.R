library(shiny) 
shinyServer(function(input, output) {
    
    model <- reactive({
        brushed_data <- brushedPoints(chicago, input$brush1,
                                      xvar = "Temperature", yvar = "Fine_Particle")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(Fine_Particle ~ Temperature, data = brushed_data)
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
        
        plot(chicago$Temperature, chicago$Ozone, xlab = "Temperature",
             ylab = "Fine Particle Pollution", main = "Relationship between ozone levels and temperature",
             col = "dark green", cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model())){
            abline(model(), col = "blue", lwd = 2)
        }
    })
})
 
    



