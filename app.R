library(shiny)

ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
      downloadButton("downloadPlot", "Download Plot")
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "skyblue", border = "white",
         main = "Histogram of Waiting Times", xlab = "Waiting time (minutes)")
  })
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste0("oldfaithful_plot_", Sys.Date(), ".png")
    },
    content = function(file) {
      png(file, width = 800, height = 600)
      x <- faithful$waiting
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = "skyblue", border = "white",
           main = "Histogram of Waiting Times", xlab = "Waiting time (minutes)")
      dev.off()
    }
  )
}


shinyApp(ui, server)

