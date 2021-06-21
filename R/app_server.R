#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
app_server <- function( input, output, session ) {
  output$val <- renderPrint(input$stepper)
  
  observeEvent(session$clientData$url_search, {
    query <- parseQueryString(session$clientData$url_search)
    
    # Ways of accessing the values
    if (as.numeric(query$foo) == 1) {
      f7Toast(text = "Plop")
    }
  })
  
}