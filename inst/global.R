appCSS <- ".mandatory_star { color: red; }"

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


