ui <- fluidPage(
  #use shiny js to disable the ID field
  shinyjs::useShinyjs(),
  shinyjs::inlineCSS(appCSS),
  
  titlePanel("Dosimetry"),
  #input fields
  #tags$hr(),
  sidebarLayout(
  sidebarPanel(
  shinyjs::disabled(textInput("id", "Identifier", "0")),
  textInput("name", "Name", ""),
  checkboxInput("use_badge", "Use Badge", FALSE),
  sliderInput("r_num_years", "R Years", 0, 25, 2, ticks = FALSE),
  #action buttons
  actionButton("submit", "Submit"),
  actionButton("new", "New"),
  actionButton("delete", "Delete"),
  width = 3
  ),
  mainPanel(
    tabsetPanel(
  #data table
  DT::dataTableOutput("responses", width = 500)
  
    )
  )
)
)