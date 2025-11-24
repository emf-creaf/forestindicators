#' Wrapper function for structures obtained with forestables
#'
#' @param x A data frame obtained with package forestables
#' @param country Country of the forest inventory (i.e. "ES", "FR" or "US")
#' @param version Spanish National Forest Inventory version (i.e. "ifn2", "ifn3" or "ifn4")
#' @param type A string of the input data frame required for forestindicators.
#'
#' @returns A data frame with data structure suitable for forestindicators
#' @export
forestables2forestindicators <- function(x, country = "ES", version = "ifn2", type = "plant_dynamic_input") {

  type <- match.arg(type, c("stand_static_input", "plant_dynamic_input"))

  # Subset country
  country <- match.arg(country, c("ES", "FR", "US"))
  x <- x[x$country==country, , drop = FALSE]

  # Subset version for Spain
  if(country=="ES") {
    if(!is.null(version)) {
      x <- x[x$version==version, , drop = FALSE]
    }
  }

  if(type=="plant_dynamic_input") {
    plant_dynamic_input <- x |>
      dplyr::select(id_unique_code, year, province_code, tree) |>
      tidyr::unnest(cols = tree)
    if(country=="ES") {
      if(version == "ifn2") {
        plant_dynamic_input <- plant_dynamic_input |>
          dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "cubing_form", "quality_wood") |>
          dplyr::mutate(province_code = as.numeric(province_code)) |>
          dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
          dplyr::rename(id_stand = id_unique_code,
                        province = province_code,
                        date = year,
                        n = density_factor,
                        h = height,
                        plant_entity = sp_name) |>
          dplyr::mutate(state = "live") |>
          dplyr::filter(!is.na(n))
      } else if(version == "ifn3") {
        plant_dynamic_input <- plant_dynamic_input |>
          dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "cubing_form", "quality_wood", "tree_ifn2", "tree_ifn3") |>
          dplyr::mutate(province_code = as.numeric(province_code)) |>
          dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
          dplyr::rename(id_stand = id_unique_code,
                        province = province_code,
                        date = year,
                        n = density_factor,
                        h = height,
                        plant_entity = sp_name) |>
          dplyr::mutate(state = dplyr::case_when(tree_ifn3==0 ~  "cut",
                                                 tree_ifn3==888 ~ "dead",
                                                 .default = "live")) |>
          dplyr::filter(tree_ifn3!=999)
      } else if(version == "ifn4") {
        plant_dynamic_input <- plant_dynamic_input |>
          dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "cubing_form", "quality_wood", "tree_ifn3", "tree_ifn4") |>
          dplyr::mutate(province_code = as.numeric(province_code)) |>
          dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
          dplyr::rename(id_stand = id_unique_code,
                        province = province_code,
                        date = year,
                        n = density_factor,
                        h = height,
                        plant_entity = sp_name) |>
          dplyr::mutate(state = dplyr::case_when(tree_ifn4==0 ~  "cut",
                                                 tree_ifn4==888 ~ "dead",
                                                 .default = "live")) |>
          dplyr::filter(tree_ifn4!=999)
      }
    }
    return(plant_dynamic_input)
  }
}
