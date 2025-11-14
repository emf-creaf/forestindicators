.treetable2forestindicators <- function(tt, table_type, id_stand = NA) {
  if(!("id_stand" %in% names(tt))) {
    tt <- tt |>
      dplyr::mutate(id_stand = as.character(id_stand))
  }
  tt <- tt |>
    dplyr::select(id_stand, Year, Species, DBH, Height, N)
  if(nrow(tt)>0) {
    tt <- tt |>
      dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
      dplyr::mutate(Year = as.Date(paste0(Year, "-01-01")))
  }
  tt <- tt |>
    dplyr::mutate(Height = Height/100,
                  Year = as.Date(Year),
                  state = table_type) |>
    dplyr::relocate(id_stand) |>
    dplyr::rename(date = Year,
                  plant_entity = Species,
                  dbh = DBH,
                  h = Height,
                  n = N)
  return(tt)
}
.fordyn2forestindicators<- function(x, id_stand = NA, type = "plant_dynamic_input") {
  res <- NULL
  if(type=="plant_dynamic_input") {
    ltt <- .treetable2forestindicators(x[["TreeTable"]], "live", id_stand)
    dtt <- .treetable2forestindicators(x[["DeadTreeTable"]], "dead", id_stand)
    ctt <- .treetable2forestindicators(x[["CutTreeTable"]], "cut", id_stand)
    res <- dplyr::bind_rows(ltt, dtt,ctt)
  }
  return(res)
}

#' Wrapper function for simulations with package medfate or medfateland
#'
#' @param x An object issued from simulations with functions \code{\link[medfate]{fordyn}}, \code{\link[medfateland]{fordyn_spatial}},
#'          \code{\link[medfateland]{fordyn_scenario}} or \code{\link[medfateland]{fordyn_land}}
#' @param id_stand A string identifying the forest stand (if \code{x} has been obtained using \code{\link[medfate]{fordyn}}).
#' @param type A string describing the input data frame for forestindicators.
#'
#' @returns A data frame with data structure suitable for forestindicators
#' @export
medfate2forestindicators <- function(x, id_stand = NA, type = "plant_dynamic_input") {
  if(!inherits(x, "fordyn") && !inherits(x, "sf") && !inherits(x, "fordyn_scenario")&& !inherits(x, "fordyn_land")) stop("'x' has to be of class 'fordyn', 'sf', 'fordyn_land' or 'fordyn_scenario'")
  type <- match.arg(type, c("plant_dynamic_input", "stand_dynamic_input"))

  if(inherits(x, "fordyn")) {
    if(is.na(id_stand)) stop("Please provide a non-missing value for 'id_stand'")
    res <- .fordyn2forestindicators(x, id_stand, type)
  }
  if(inherits(x, "sf")) {
    res_list <- vector("list", length = nrow(x))
    for(i in 1:nrow(x)) {
      res_list[[i]] <- .fordyn2forestindicators(x$result[[i]], id_stand = x$id[i], type)
    }
    res <- dplyr::bind_rows(res_list)
  }
  if(inherits(x, "fordyn_scenario") || inherits(x, "fordyn_land")) {
    if(inherits(x, "fordyn_scenario")) {
      sf_data <- x$result_sf |>
        sf::st_drop_geometry()
    } else if(inherits(x, "fordyn_land")) {
      sf_data <- x$sf |>
        sf::st_drop_geometry() |>
        dplyr::mutate(id = as.character(1:nrow(x$sf)))
    }
    ltt <- sf_data |>
      dplyr::select(id, tree_table) |>
      dplyr::rename(id_stand = id) |>
      tidyr::unnest(cols = c(tree_table)) |>
      .treetable2forestindicators(table_type = "live")
    dtt <- sf_data |>
      dplyr::select(id, dead_tree_table) |>
      dplyr::rename(id_stand = id) |>
      tidyr::unnest(cols = c(dead_tree_table)) |>
      .treetable2forestindicators(table_type = "dead")
    ctt <- sf_data |>
      dplyr::select(id, cut_tree_table) |>
      dplyr::rename(id_stand = id) |>
      tidyr::unnest(cols = c(cut_tree_table)) |>
      .treetable2forestindicators(table_type = "cut")
    res <- dplyr::bind_rows(ltt, dtt,ctt)
  }
  return(res)
}
