# if (file.exists("../inst") && file.exists("../www")){
#   ## for package
#   r_path <- "../.."
# } else{
#   ## for server
#   r_path <- ""
#   
# }
## path to use for local and server use
r_path <- ifelse (file.exists("../inst"), "..", system.file(package = "Dosimetry"))

appCSS <- ".mandatory_star { color: red; }"

#,theme= shinythemes::shinytheme("cerulean")
nav_ui <-
  list(windowTitle = "Dosimetry", id = "nav_radiant",
       theme= shinythemes::shinytheme("cerulean"), 
       inverse = TRUE, collapsible = TRUE, 
       tabPanel("Data",withMathJax(),uiOutput("ui_All")
       ))


shared_ui <-
  tagList(
    #     navbarMenu("R",
    #               tabPanel("Report", uiOutput("report"), icon = icon("edit")),
    #               tabPanel("Code", uiOutput("rcode"), icon = icon("code"))
    #    ),
    
    navbarMenu(title = "", id = "State", icon = icon("save"),
               tabPanel(downloadLink("saveStateNav", " Save state", class = "fa fa-download")),
               tabPanel(actionLink("shareState", "Share state", icon = icon("share"))),
               tabPanel("View state", uiOutput("view_state"), icon = icon("user"))
    ),
    
    ## stop app *and* close browser window
    navbarMenu(title = "", id = "Stop", icon = icon("power-off"),
               tabPanel(actionLink("stop_bioCancer", "Stop", icon = icon("stop"),
                                   onclick = "setTimeout(function(){window.close();}, 100); ")),
               tabPanel(tags$a(id = "refresh_bioCancer", href = "#", class = "action-button",
                               list(icon("refresh"), "Refresh"), onclick = "window.location.reload();")),
               tabPanel(tags$a(id = "new_session", href = "./", target = "_blank",
                               list(icon("plus"), "New session")))
    )
  )

js_head <-
  tags$head(
    tags$script(src = file.path(r_path,"inst/www/js/session.js")),
    tags$script(src = file.path(r_path,"inst/www/js/jquery-ui.custom.min.js")),
    tags$script(src = file.path(r_path,"inst/www/js/returnTextAreaBinding.js")),
    tags$script(src = file.path(r_path,"inst/www/js/returnTextInputBinding.js")),
    # tags$script(src = "js/draggable_modal.js"),
    tags$script(src = file.path(r_path,"inst/www/js/video_reset.js")),
    tags$link(rel = "shortcut icon", href = file.path(r_path,"inst/www/imgs/icon.png"))
  )

help_menu <-
  tagList(
    navbarMenu(title = "", id = "Help", icon = icon("question-circle"),
               tabPanel("Help", uiOutput("help_modeling"), icon = icon("question")),
               #tabPanel("Videos", uiOutput("help_videos"), icon = icon("film")),
               tabPanel("About", uiOutput("help_about"), icon = icon("info")),
               #tabPanel(tags$a("", href = "http://kmezhoud.github.io/CancerPortal/", target = "_blank",
               #                 list(icon("globe"), "bioCancer docs"))),
               tabPanel(tags$a("", href = "https://github.com/kmezhoud/Dosimetry/issues", target = "_blank",
                               list(icon("github"), "Report issue")))
    ),
    js_head
  )




fieldsPrivate <- c(id = "Id", 
            name = "Name", 
            use_badge = "Use Badge", 
            r_num_years = "R Years")

fieldsPrivate_Mandatory <- c("name")

labelMandatory <-
  function(label) {
    tagList(
      label,
      span("*", class = "mandatory_star")
    )
  }


   ## stop app *and* close browser window
    navbarMenu("", icon = icon("power-off"),
               tabPanel(actionLink("stop_radiant", "Stop", icon = icon("stop"),
                                   onclick = "setTimeout(function(){window.close();}, 100); ")),
               if (rstudioapi::isAvailable()) {
                 tabPanel(actionLink("stop_radiant_rmd", "Stop & Report to Rstudio", icon = icon("stop"),
                                     onclick = "setTimeout(function(){window.close();}, 100); "))
               } else {
                 tabPanel("")
               },
               tabPanel(tags$a(id = "refresh_radiant", href = "#", class = "action-button",
                               list(icon("refresh"), "Refresh"), onclick = "window.location.reload();")),
               ## had to remove class = "action-button" to make this work
               tabPanel(tags$a(id = "new_session", href = "./", target = "_blank",
                               list(icon("plus"), "New session")))
    )
  
