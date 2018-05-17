library(shiny) 
shinyServer(function(input, output) {
            
    myXY <- reactive({
            paste("Temperature ~", "as.integer(", input$x,")")
        })
        
    model <- reactive({
        brushed_data <- brushedPoints(chicago, input$brush1,
                                      xvar = input$x, yvar = "Temperature")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(as.formula(myXY()), data = brushed_data)
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
        with(chicago, {
        plot(as.formula(myXY()), xlab = input$x,
             ylab = "Temperature", main = "Relationship between air pollution and temperature",
             col = "dark green", cex = 1.5, pch = 16, bty = "n")
        if(!is.null(model())){
            abline(model(), col = "blue", lwd = 2)
             }
         })
    }) 
})



            
          
    
    



