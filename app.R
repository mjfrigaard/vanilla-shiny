# Load packages ---------------------------------------------------------------

library(shiny)
library(ggplot2)
library(tools)
library(shinythemes)
library(stringr)

# Source utils.R --------------------------------------------------------------
source("utils.R")

source("mod_vars.R")

source("mod_plot.R")

# vanillaApp() ----------------------------------------------------------------
vanillaApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      theme = shinythemes::shinytheme("spacelab"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          varsUI(id = "vars")
        ),

        shiny::mainPanel(
          shiny::br(),
          shiny::p(
            "These data were obtained from",
            shiny::a("IMBD", href = "http://www.imbd.com/"),
            "and",
            shiny::a("Rotten Tomatoes", href = "https://www.rottentomatoes.com/"),
            "."
          ),
          shiny::p(
            "The data represent",
            nrow(movies),
            "randomly sampled movies released between 1972 to 2014 in the United States."
          ),
          plotUI(id = "plot"),
          shiny::hr(),
          shiny::p(
            shiny::em(
              "The code for this shiny application comes from",
              shiny::a("Building Web Applications with shiny",
                href = "https://rstudio-education.github.io/shiny-course/")
            )
          )
        )
      )
    ),
    server = function(input, output, session) {

        selected_vars <- varsServer(id = "vars")

        plotServer(id = "plot", var_inputs = selected_vars)
    }
  )
}

vanillaApp()
