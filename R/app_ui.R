#' The application User-Interface
#'
#' shinyMobile tabs layout template
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @import echarts4r
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    f7Page(
      allowPWA = TRUE,
      options = list(
        theme = "auto",
        dark = TRUE,
        filled = FALSE,
        color = "#007aff",
        touch = list(
          tapHold = TRUE,
          tapHoldDelay = 750,
          iosTouchRipple = FALSE
        ),
        iosTranslucentBars = FALSE,
        navbar = list(
          iosCenterTitle = TRUE,
          hideOnPageScroll = TRUE
        ),
        toolbar = list(hideOnPageScroll = FALSE),
        pullToRefresh = FALSE
      ),
      title = "My app",
      f7TabLayout(
        panels = tagList(
          f7Panel(
            title = "Left Panel",
            side = "left",
            theme = "light",
            "Blabla",
            effect = "cover"
          ),
          f7Panel(
            title = "Right Panel",
            side = "right",
            theme = "dark",
            "Blabla",
            effect = "reveal"
          )
        ),
        navbar = f7Navbar(
          title = "Tabs",
          hairline = TRUE,
          shadow = TRUE,
          leftPanel = TRUE,
          rightPanel = TRUE
        ),
        f7Tabs(
          animated = TRUE,
          f7Tab(
            tabName = "Tab 1",
            icon = f7Icon("folder"),
            active = TRUE,
            f7Block(
              f7Slider(
                inputId = "obs",
                label = "Number of observations",
                max = 1000,
                min = 0,
                value = 100,
                scaleSteps = 5,
                scaleSubSteps = 3,
                scale = TRUE,
                color = "orange",
                labels = tagList(
                  f7Icon("circle"),
                  f7Icon("circle_fill")
                )
              ),
              plotOutput("distPlot")
            )
          ),
          f7Tab(
            tabName = "Tab 2",
            icon = f7Icon("keyboard"),
            active = FALSE,
            f7Block(
              strong = TRUE,
              echarts4rOutput("riverChart"),
              inset = TRUE
            )
          ),
          f7Tab(
            tabName = "Tab 3",
            icon = f7Icon("layers_alt"),
            active = FALSE,
            "Tab 3"
          )
        )
      )
    )
  )
}





#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  #add_resource_path(
  #  "golem", app_sys("app/www/golem")
  #)

  #add_resource_path(
  #  "www", app_sys("app/www")
  #)

  tags$head(
    # added hotjar
    HTML(
      "<!-- Hotjar Tracking Code for https://dgranjon.shinyapps.io/shinyMobileGolemTest -->
      <script>
          (function(h,o,t,j,a,r){
              h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
              h._hjSettings={hjid:2481595,hjsv:6};
              a=o.getElementsByTagName('head')[0];
              r=o.createElement('script');r.async=1;
              r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
              a.appendChild(r);
          })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
      </script>
      "
    )
    #favicon(),
    #bundle_resources(
    #  path = app_sys("app/www/golem"),
    #  app_title = "My app"
    #)
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}