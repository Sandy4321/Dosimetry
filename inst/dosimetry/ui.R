

shinyUI(fluidPage(
  #titlePanel("Dosimetry"),
  
  ## use shiny js to disable the ID field
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  
  do.call(navbarPage, c("Dosimetry",
                        nav_ui,
                        shared_ui,
                        help_menu))
))