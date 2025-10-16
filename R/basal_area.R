.basal_area <- function(stand_static_input = NULL,
                        stand_dynamic_input = NULL,
                        plant_static_input = NULL,
                        plant_dynamic_input = NULL,
                        timber_volume_function = NULL,
                        plant_biomass_function = NULL,
                        min_tree_dbh = 7.5,
                        tree_state = "live",
                        ...){

  ## Filter plant_dynamic_input by state = "cut"
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == tree_state)

  ## Compute volume over bark at the tree-level
  plant_input <- plant_input |>
    dplyr::filter(dbh >= min_tree_dbh) |>
    dplyr::mutate(basal_area = n*pi*(dbh/200)^2)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(basal_area = sum(basal_area))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, basal_area)
  return(res)
}
