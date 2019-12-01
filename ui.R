fluidPage(
  # Application title
  titlePanel("Motors Tests"),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
     
      selectInput("selectedSerial","Select Board:", c()),
      radioButtons("direction", "Direction:", c("Right" = "right","Left" = "left")),
      sliderInput("speed","Choose Speed :",min = 1,  max = 50, value = 15),
      hr()
    
    ),

    # Show Word Cloud
    mainPanel(
      plotOutput("plot"),
      h1(textOutput("caption"))
    )
  )
)
