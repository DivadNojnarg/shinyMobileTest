#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @import echarts4r
#' @noRd
app_server <- function( input, output, session ) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
  
  observeEvent(session$clientData$url_search, {
    query <- parseQueryString(session$clientData$url_search)
    req(length(query) > 0)
    # Ways of accessing the values
    if (as.numeric(query$foo) == 1) {
      f7Toast(text = "Plop")
    }
  })
  
  # date for echarts4r
  dates <- seq.Date(Sys.Date() - 30, Sys.Date(), by = "day")
  
  river <- data.frame(
    dates = dates,
    apples = runif(length(dates)),
    bananas = runif(length(dates)),
    pears = runif(length(dates))
  )
  
  output$riverChart <- renderEcharts4r({
    river %>% 
      e_charts(dates) %>%
      e_river(apples) %>% 
      e_river(bananas) %>%
      e_river(pears) %>% 
      e_tooltip(trigger = "axis") %>%
      e_title("River charts", "(Streamgraphs)")
  })
  
}