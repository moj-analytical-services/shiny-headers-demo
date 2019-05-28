#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Header Explorer"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       uiOutput("headers"),
       h3("Headers passed into Shiny"),
       verbatimTextOutput("summary")
     ),
      # Show a plot of the generated distribution
      mainPanel(

        h3("Value of specified header"),
        verbatimTextOutput("value"),
        h3("Value of HTTP_USER_EMAIL header"),
        verbatimTextOutput("user_email")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  output$summary <- renderText({
    paste0(ls(env=session$request), "\n")
  })
  
  output$headers <- renderUI({
    selectInput("header", "Header:", ls(env=session$request))
  })
  
  output$value <- renderText({
    if (nchar(input$header) < 1 || !exists(input$header, envir=session$request)){
      return("NULL");
    }
    return (get(input$header, envir=session$request));
  })

  output$user_email <- renderText({
    return (get("HTTP_USER_EMAIL", envir=session$request))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

