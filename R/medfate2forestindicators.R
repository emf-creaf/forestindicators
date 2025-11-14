.fordyn2forestindicators<- function(x, id_stand = NA, type = "plant_dynamic_input") {
  res <- NULL
  if(type=="plant_dynamic_input") {
    ltt <- x[["TreeTable"]] |>
      dplyr::select(Year, Species, DBH, Height, N)
    if(nrow(ltt)>0) {
      ltt <- ltt |>
        dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
        dplyr::mutate(Year = as.Date(paste0(Year, "-01-01")))
    }
    ltt <- ltt |>
      dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
      dplyr::mutate(Year = as.Date(paste0(Year, "-01-01"))) |>
      dplyr::mutate(id_stand = as.character(id_stand),
                    Height = Height/100,
                    Year = as.Date(Year),
                    state = "live") |>
      dplyr::relocate(id_stand) |>
      dplyr::rename(date = Year,
                    plant_entity = Species,
                    dbh = DBH,
                    h = Height,
                    n = N)

    dtt <- x[["DeadTreeTable"]] |>
      dplyr::select(Year, Species, DBH, Height, N)
    if(nrow(dtt)>0) {
      dtt <- dtt |>
        dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
        dplyr::mutate(Year = as.Date(paste0(Year, "-01-01")))
    }
    dtt <- dtt |>
      dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
      dplyr::mutate(Year = as.Date(paste0(Year, "-01-01"))) |>
      dplyr::mutate(id_stand = as.character(id_stand),
                    Year = as.Date(Year),
                    Height = Height/100,
                    state = "dead") |>
      dplyr::relocate(id_stand) |>
      dplyr::rename(date = Year,
                    plant_entity = Species,
                    dbh = DBH,
                    h = Height,
                    n = N)
    ctt <- x[["CutTreeTable"]] |>
      dplyr::select(Year, Species, DBH, Height, N)
    if(nrow(ctt)>0) {
      ctt <- ctt |>
        dplyr::mutate(Year = tidyr::replace_na(Year, min(Year, na.rm=TRUE)-1)) |>
        dplyr::mutate(Year = as.Date(paste0(Year, "-01-01")))
    }
    ctt <- ctt |>
      dplyr::mutate(id_stand = as.character(id_stand),
                    Year = as.Date(Year),
                    Height = Height/100,
                    state = "cut") |>
      dplyr::relocate(id_stand) |>
      dplyr::rename(date = Year,
                    plant_entity = Species,
                    dbh = DBH,
                    h = Height,
                    n = N)
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
  if(!inherits(x, "fordyn") && !inherits(x, "sf")) stop("'x' has to be of class 'fordyn' or 'sf'")
  type <- match.arg(type, c("plant_dynamic_input", "stand_dynamic_input"))

  if(inherits(x, "fordyn")) {
    res <- .fordyn2forestindicators(x, id_stand, type)
  }
  if(inherits(x, "sf")) {
    res_list <- vector("list", length = nrow(x))
    for(i in 1:nrow(x)) {
      res_list[[i]] <- .fordyn2forestindicators(x$result[[i]], id_stand = x$id[i], type)
    }
    res <- dplyr::bind_rows(res_list)
  }
  return(res)
}
