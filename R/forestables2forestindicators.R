#' Wrapper function for structures obtained with forestables
#'
#' @param x A data frame obtained with package forestables
#' @param version Spanish National Forest Inventory version ("ifn2", "ifn3" or "ifn4")
#' @param type A string describing the input data frame for forestindicators.
#'
#' @returns A data frame with data structure suitable for forestindicators
#' @export
#'
#' @examples
forestables2forestindicators <- function(x, version = NULL, type = "plant_dynamic_input") {

  type <- match.arg(type, c("stand_static_input", "plant_dynamic_input"))

  if(!is.null(version)) {
    x <- x |>
      dplyr::filter(version == version)
  }

  if(type=="plant_dynamic_input") {
    plant_dynamic_input <- x |>
      dplyr::select(id_unique_code, year, province_code, tree) |>
      tidyr::unnest(cols = tree) |>
      dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "tree_ifn4") |>
      dplyr::mutate(province_code = as.numeric(province_code)) |>
      dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
      dplyr::rename(id_stand = id_unique_code,
                    province = province_code,
                    date = year,
                    n = density_factor,
                    h = height,
                    plant_entity = sp_name) |>
      dplyr::mutate(state = "live") |>
      dplyr::filter(!is.na(n)) |>
      dplyr::select(-tree_ifn4)
    return(plant_dynamic_input)
  }
}
