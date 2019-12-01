library(memoise)
library(reticulate)
library(dplyr)
library(plyr)
library(jsonlite)



# The list of valid books
books <<- list("A Mid Summer Night's Dream" = "summer",
              "The Merchant of Venice" = "merchant",
              "Romeo and Juliet" = "romeo")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {

})


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
            listOfComs = listOfComs
            listOfComs[rawIndexOfUsbCom[1],3] %>% as.character()
  
  }
