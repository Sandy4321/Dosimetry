output$ui_perso <- renderUI({
  tagList(
  wellPanel(
    fluidRow(
      column(3,
             textInput(
               "firstName_id",
               "First Name:",
               "FIRST"
             )),
      column(3,
             textInput("name_id",
                       "Last Name:",
                       "LAST")),
      column(3,
             dateInput(
               'birthday_id',
               label = 'Birthday',
               value = "1980-01-01" #Sys.Date()
             )),
      column(3,
             selectizeInput("gender_id", "Gender", 
                            choices= c("Female", "Male"), multiple= FALSE) 
      )
    )
  ),
  
  sliderInput(
    "control_num",
    "This controls values:",
    min = 1,
    max = 20,
    value = 15
  )
  )
})