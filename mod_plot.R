# Load data --------------------------------------------------------------------

load("movies.RData")

plotUI <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::tags$br(),
    shiny::plotOutput(outputId = ns("scatterplot"))
  )
}

plotServer <- function(id, var_inputs) {
  shiny::moduleServer(id, function(input, output, session) {
    movies <- movies

    inputs <- shiny::reactive({
      plot_title <- tools::toTitleCase(var_inputs$plot_title())
      list(
        x = var_inputs$x(),
        y = var_inputs$y(),
        z = var_inputs$z(),
        alpha = var_inputs$alpha(),
        size = var_inputs$size(),
        plot_title = plot_title
      )
    })

    output$scatterplot <- shiny::renderPlot({
      plot <- point_plot(
        df = movies,
        x_var = inputs()$x,
        y_var = inputs()$y,
        col_var = inputs()$z,
        alpha_var = inputs()$alpha,
        size_var = inputs()$size
      )
      plot +
        ggplot2::labs(
          title = inputs()$plot_title,
          x = stringr::str_replace_all(tools::toTitleCase(inputs()$x), "_", " "),
          y = stringr::str_replace_all(tools::toTitleCase(inputs()$y), "_", " ")
        ) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position = "bottom")
    })
  })
}
