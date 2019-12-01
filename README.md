# shinyForRobotTests



25/11/2019
-Shiny application is showing 
* slider Bar to choose the speed of motor
* direction with radio button
* transform speed and direction to json and send it via USB port serial, use observeEvent()

- drop down list to show the connected boards
* reticulate, python to read list of USB connections
* transform the list R 
* show the list in drop down list use updateSelectInput

Shiny application to dynamically add elements to UI: https://shiny.rstudio.com/gallery/dynamic-ui.html
Shiny catch events of changing elements
Reticulate to call python code https://blog.rstudio.com/2018/03/26/reticulate-r-interface-to-python/
italki to choose a teacher for yursen https://www.italki.com/teachers/german?page=7&is_native=1
packages for 3d in R: https://github.com/tylermorganwall/rayrender



26/11/2019
Drop down list to show the usb connections
- find how to fill dynamically the drop down list, from the fuction that is already 
 
server.R
 output$ui <- renderUI({
   return()
   selectInput("dynamic", "Dynamic",choices = c("Option 1" = "option1","Option 2" = "option2"),selected = c("option1", "option2"),multiple = TRUE)
  })

 
ui.R
 uiOutput("ui")



solution2:
ui.R
selectInput("inSelect", "Select input",c("Item A", "Item B", "Item C"))

server.R
 choices1 <- reactive( c( "option1","option2"))
  observe({
    x <- input$inCheckboxGroup
    
    # Can use character(0) to remove all choices
    if (is.null(x))
      x <- character(0)
    
    # Can also set the label and select items
    updateSelectInput(session, "inSelect",
                      label = paste("Select input label", length(choices1())),
                      choices = choices1(),
                      selected = tail(choices1(), 1)
    )
  })



- add to JSON more information { type:motor, part:Motor1, command:turn }  
- find how to parse JSON data from arduino with C++ 
- Connect a motor and sonar sensor 
- Create JSON from arduino to send the data back {type:ultrasonic, part:SonarLeft,  value: , timeStamp: }
- 






setwd("R/ShinyMotorTests/")
shiny::runApp()


Rscript <(echo "setwd('R/ShinyMotorTests/');shiny::runApp();"
