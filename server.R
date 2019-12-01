library(serial)
library(jsonlite)
library(dplyr)
library(reticulate)
library(plyr)
library(dplyr)
library(jsonlite)


getComList <- function()
{
       serialPython <- import("serial.tools.list_ports")
       
       com_list     <- serialPython$comports() %>% sapply(function(x) { x %>% as.character() %>% strsplit(.,"-") } ) %>%  
            sapply(function(x) { x %>% as.character() %>% trimws(.) } ) %>% t() 
       
       nameOfComm <- com_list[,1] %>% sapply(function(x) { x %>% as.character() %>% strsplit(.,"/") } )  %>%  do.call("rbind", .)
       
       com_list = cbind(com_list, nameOfComm[,3])
       return(com_list)
       
}

getSelectedCom <- function( comName, listOfComs)
{
            rawIndexOfUsbCom = which(listOfComs == comName , arr.ind = TRUE )
            listOfComs[rawIndexOfUsbCom[1],1] %>% as.character()
  
}

getListComNames <- function(listOfComs)
{
       listOfComs[,2] %>% as.character()
}

sendData <- function(commandToSend,comName = '/dev/ttyACM1')
{
  
  tryCatch(
    expr = {
           serialP <- import("serial")
           ser = serialP$Serial(comName) 
           ser$write(commandToSend)
           ser$close()
    },
    error = function(e){ 
        # (Optional)
        # Do this if an error is caught...
    },
    warning = function(w){
        # (Optional)
        # Do this if an warning is caught...
    },
    finally = {
        # (Optional)
        # Do this at the end before quitting the tryCatch structure...
    }
   )





  
  }

function(input, output, session) {

  getComListReactive  <- reactive( getListComNames(comListInfo()) ) 
  comListInfo         <- reactive( getComList() )
  selectedDevice      <- reactive( getSelectedCom(input$selectedSerial,comListInfo() ))
   
    observe({
       
        # Can also set the label and select items
        updateSelectInput(session, "selectedSerial",
                          label = "Select Board:",
                          choices = getComListReactive(),
                          selected = tail(getComListReactive(), 1)
        )
      })


     observeEvent(c(input$direction ,input$speed),{ 
         jsonToSend = paste0("{speed:",input$speed ,",direction:",input$direction ,"}\n")
         sendData(jsonToSend,selectedDevice() )
         
        })
       
     
     observeEvent( input$selectedSerial , {
         
         
         
       } )

  output$plot <- renderPlot({

    })
  
  output$caption  <- renderText({

         print(selectedDevice())
 
      
    })
    
    
    
    
    
}
