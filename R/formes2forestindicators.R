.formestreetable2forestindicators <- function(tt, table_type, id_stand = NA) {
  tt <- tt |>
    dplyr::rename(id_stand = ID, plant_entity = Species, dbh = DBH, h = H, n = N) |>
    dplyr::mutate(date = as.Date(paste0(Year, "-01-01")), state = table_type) |>
    dplyr::mutate(id_stand = as.character(id_stand)) |>
    dplyr::mutate(plant_entity = as.character(plant_entity)) |>
    dplyr::relocate(id_stand, plant_entity, date, state, dbh, h, n) |>
    dplyr::select(-Step, -Year)
  return(tt)
}


#' Wrapper function for simulations with package FORMES 
#'
#' @param x An object issued from simulations with functions \code{\link[FORMES]{IFNscenario}}, 
#'          \code{\link[DSSsim]{run_formes_scenario}}.
#' @param initial_year A numeric value of the initial year (step 0 of the simulation)
#' @param type A string describing the input data frame for forestindicators.
#'
#' @returns A data frame with data structure suitable for forestindicators
#' @export
formes2forestindicators <- function(x, initial_year = NA, type = "plant_dynamic_input") {
  if(!inherits(x, "IFNscenario")) stop("'x' has to be of class 'IFNscenario'")
  if(is.na(initial_year)) stop("'initial_year' (step 0) must be indicated as yyyy")
  type <- match.arg(type, c("plant_dynamic_input", "stand_dynamic_input"))
  
  if(inherits(x, "IFNscenario")) {
    # live
    ltt <- x$treeDataSequence |> 
      dplyr::mutate(Year = Step*x$numYears+initial_year) |>
    .formestreetable2forestindicators(table_type = "live")    
    # dead
    dtt <- x$treeDataDead |> 
      dplyr::mutate(Year = Step*x$numYears+initial_year) |>
      .formestreetable2forestindicators(table_type = "dead")
    # cut
    if(nrow(x$treeDataCut)>0){
      ctt <- x$treeDataDead |> 
        dplyr::mutate(Year = Step*x$numYears+initial_year) |>
      .formestreetable2forestindicators(table_type = "cut")
      res <- dplyr::bind_rows(ltt, dtt, ctt)
    } else{
      res <- dplyr::bind_rows(ltt, dtt)
    }
  }
  return(res)
}
