

ui <- fluidPage(
  titlePanel("Explore Pollution Burden by County and Demographics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("county", "Select a County:",
                  choices = sort(unique(data$`California County`))),
      selectInput("demographic", "Select Demographic Group:",
                  choices = c("Hispanic (%)", "White (%)", "African American (%)", 
                              "Asian American (%)", "Native American (%)", "Other/Multiple (%)"))
    ),
    mainPanel(
      plotOutput("demoPlot")
    )
  )
)

server <- function(input, output) {
  output$demoPlot <- renderPlot({
    plot_data <- data %>% filter(`California County` == input$county)
    
    ggplot(
      plot_data,
      aes_string(
        x = paste0("`", input$demographic, "`"),
        y = "`Pollution Burden Score`"
      )
    ) +
      geom_point(alpha = 0.5, color = "darkblue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(
        title = paste("Pollution vs.", input$demographic, "in", input$county),
        x = input$demographic,
        y = "Pollution Burden Score"
      ) +
      theme_minimal()
  })
}


shinyApp(ui = ui, server = server)