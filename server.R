library(shiny)
library(ggplot2)
data("trees")

dataset <- trees

#multiple regression model. Create the relationship model.
model <- lm(Height~Girth+Volume, data = dataset)

shinyServer(function(input, output) {
    output$text1 <- renderText({
      paste("The Girth of the Tree is ",tags$b(input$sld_Girth),
            "and the Volume of the Tree is",tags$b(input$sld_Volume),
            "then,"
            )
    })
    output$Plot <- renderPlot({
      df <- data.frame(Girth=input$sld_Girth,
                       Volume=input$sld_Volume
                       )
      
      pred <- predict(model, newdata=df)
      
      output$text2 <- renderText({
      paste0("the estimated height is going to be around ",
             tags$b(pred),
             " ft")
      })
      yvals <- c("Tree Diameter", "Volume (cubic ft)", "Height")
      
      df <- data.frame(
        x = factor(yvals, levels = yvals, ordered = TRUE),
        y = c(input$sld_Girth, input$sld_Volume, pred))
      
      ggplot(df, aes(x=x, y=y, fill=c("red", "green", "blue"))) +
        geom_bar(stat="identity", width=0.5) +
        xlab("") +
        ylab("Height (ft)") +
        theme_minimal() +
        theme(legend.position="none")+
        ylim(0,100)
    })
      

})