output$ui_Edit <- renderUI({
  tagList(
    shinyjs::disabled(textInput("id", "Identifier", "0")),
    textInput("name", "Name", ""),
    checkboxInput("use_badge", "Use Badge", FALSE),
    sliderInput("r_num_years", "R Years", 0, 25, 2, ticks = FALSE),
    #action buttons
    actionButton("submit", "Submit"),
    actionButton("new", "New"),
    actionButton("delete", "Delete")
  )
})

output$Edit_ui <- renderUI({
  tagList(
    tags$hr(),
    DT::dataTableOutput("responses",
                        width = 500)
  )
})