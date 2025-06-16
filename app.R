library(shiny)

ui <- fluidPage(
  titlePanel("Upload CSV & Download Plot"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose CSV File", accept = ".csv"),
      sliderInput("bins", "Number of bins:", 1, 50, 30),
      downloadButton("downloadPlot", "Download Plot")
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  
  # Reactive data: uploaded CSV or default faithful dataset
  data <- reactive({
    if (is.null(input$file)) {
      faithful$waiting
    } else {
      df <- read.csv(input$file$datapath)
      # Assuming the CSV has one numeric column to plot; adjust as needed
      df[[1]]
    }
  })
  
  output$distPlot <- renderPlot({
    x <- data()
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "skyblue", border = "white",
         main = "Histogram of Waiting Times", xlab = "Waiting time (minutes)")
  })
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste0("plot_", Sys.Date(), ".png")
    },
    content = function(file) {
      png(file, width = 800, height = 600)
      x <- data()
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = "skyblue", border = "white",
           main = "Histogram of Waiting Times", xlab = "Waiting time (minutes)")
      dev.off()
    }
  )
}

shinyApp(ui, server)


