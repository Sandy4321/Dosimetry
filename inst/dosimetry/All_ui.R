output$ui_All <- renderUI({
  #shinyjs::useShinyjs()
  #shinyjs::inlineCSS(appCSS)
  sidebarLayout(
    conditionalPanel("input.tabsetId == 'Edit'",
    sidebarPanel(

                     uiOutput("ui_Edit"))
    #width = 4
  ),
  mainPanel(tabsetPanel(id = "tabsetId",
    
    tabPanel("Edit",
             uiOutput("Edit_ui")
             ),
    tabPanel("Perso",
             uiOutput("ui_perso"))
    
  )))
})