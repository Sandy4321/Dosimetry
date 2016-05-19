shinyServer(function(input, output, session) {

  
  source("inst/global.R", encoding = "UTF-8", local = TRUE)
  source("R/helper.R", encoding = "UTF-8", local = TRUE)
  
    # disable sumit button if Mandatory fields are not filled
  observe({
    # check if all mandatory fields have a value
    mandatoryFilled <-
      vapply(fieldsPrivate_Mandatory,
             function(x) {
               !is.null(input[[x]]) && input[[x]] != ""
             },
             logical(1))
    mandatoryFilled <- all(mandatoryFilled)
    
    # enable/disable the submit button
    shinyjs::toggleState(id = "submit", condition = mandatoryFilled)
  })
  
  
   # input fields are treated as a group
  formData <- reactive({
    sapply(names(getListMetadata(fieldsPrivate)$fields), function(x) input[[x]])
  })
  
  # Click "Submit" button -> save data
  observeEvent(input$submit, {
    if (input$id != "0") {
      UpdateData(formData())
    } else {
      CreateData(formData())
      UpdateInputs(CreateDefaultRecord(), session)
    }
  }, priority = 1)
  
  # # action to take when submit button is pressed
  # observeEvent(input$submit, {
  #   saveData(formData())
  # })
  
  # Press "New" button -> display empty record
  observeEvent(input$new, {
    UpdateInputs(CreateDefaultRecord(), session)
  })
  
  # Press "Delete" button -> delete from data
  observeEvent(input$delete, {
    DeleteData(formData())
    UpdateInputs(CreateDefaultRecord(), session)
  }, priority = 1)
  
  # Select row in table -> show details in inputs
  observeEvent(input$responses_rows_selected, {
    if (length(input$responses_rows_selected) > 0) {
      data <- ReadData()[input$responses_rows_selected, ]
      UpdateInputs(data, session)
    }
    
  })
 
  # display table
  output$responses <- DT::renderDataTable({
    #update after submit is clicked
    input$submit
    #update after delete is clicked
    input$delete
    
    
    #ReadData()
    displayTable(ReadData(), session= session)
  }
  #, server = FALSE, selection = "single",
  #colnames = unname(getListMetadata()$fields)[-1]
  )
  

})