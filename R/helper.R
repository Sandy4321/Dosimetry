CreateData <-
  function(data) {
  data <- InitData(data)
  rownames(data) <- GetNextId()
  if (exists("responses")) {
    responses <<- rbind(responses, data)
  } else {
    responses <<- data
  }
}

CreateDefaultRecord <-
  function() {
    mydefault <- InitData(list(id = "0", name = "", use_badge = FALSE, r_num_years = 2))
    return (mydefault)
  }

DeleteData<-
  function(data) {
    responses <<- responses[row.names(responses) != unname(data["id"]), ]
  }

displayTable <-
  function(df, session= session){
    if (exists("responses") && nrow(responses) > 0) {
      #df <- as.data.frame(df %>% add_rownames("Id"))
    }
    
    action = DT::dataTableAjax(session, df, rownames = FALSE)
    
    #DT::datatable(dat, filter = "top", rownames =FALSE, server = TRUE,
    table <- DT::datatable(df, filter = list(position = "top", clear = FALSE, plain = TRUE),
                           rownames = FALSE, style = "bootstrap", escape = FALSE,
                           class = "compact",
                           selection = "single",
                           options = list(
                             ajax = list(url = action),
                             search = list(search = "",regex = TRUE),
                             columnDefs = list(list(className = 'dt-center', targets = "_all")),
                             autoWidth = TRUE,
                             processing = TRUE,
                             pageLength = 10,
                             lengthMenu = list(c(10, 25, 50, -1), c('10','25','50','All'))
                           )
    )
    return(table)
  }


getListMetadata <-
  function(field) {
    result <- list(fields = field)
    return (result)
  }

GetNextId <-
  function() {
    if (exists("responses") && nrow(responses) > 0) {
      max(as.integer(rownames(responses))) + 1
    } else {
      return (1)
    }
  }

humanTime <-
  function() format(Sys.time(), "%Y%m%d-%H%M%OS")
  

InitData <-
  function(data) {
    datar <- data.frame(name = data["name"], 
                        use_badge = as.logical(data["use_badge"]), 
                        r_num_years = as.integer(data["r_num_years"]),
                        stringsAsFactors = FALSE)
    rownames(datar) <- data["id"]
    return (datar)
  }


ReadData <-
  function() {
    if (exists("responses")) {
      responses
    }
  }

saveData <- 
  function(data) {
  fileName <- sprintf("%s_%s.csv",
                      #humanTime(),
                      digest::digest(data))
  
  write.csv(x = data, file = file.path("responses", fileName),
            row.names = FALSE, quote = TRUE)
}

UpdateData <-
  function(data) {
    data <- InitData(data)
    responses[row.names(responses) == row.names(data), ] <<- data
  }

UpdateInputs <-
  function(data, session) {
  updateTextInput(session, "id", value = unname(rownames(data)))
  updateTextInput(session, "name", value = unname(data["name"]))
  updateCheckboxInput(session, "use_badge", value = as.logical(data["use_badge"]))
  updateSliderInput(session, "r_num_years", value = as.integer(data["r_num_years"]))
}

