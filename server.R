library(serial)
library(jsonlite)
library(dplyr)
library(reticulate)
library(plyr)
library(dplyr)
library(jsonlite)


function(input, output, session) {
  # Define a reactive expressions

  # getComListReactive  <- reactive( getComList() ) 
    
  observe({                  
          con <- serialConnection("com1",port = "ttyAMA0", mode = "9600,n,8,1",buffering = "none", 
                                  newline = 0, eof = "", translation = "auto",handshake = "none", buffersize = 4096)
          open(con)
          jsonToSend = paste0("{speed:",input$speed ,",direction:",input$direction ,"}\n")
          write.serialConnection(con,jsonToSend)
          close(con)     
      
     })
     
     observeEvent( input$selectedSerial , {
         
         
         
       } )

  output$plot <- renderPlot({

    })
  
  output$caption  <- renderText({
    

      
    })
    
    
    
    
    
}
