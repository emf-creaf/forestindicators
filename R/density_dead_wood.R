.density_dead_wood <- function(stand_static_input = NULL,
                               stand_dynamic_input = NULL,
                               plant_static_input = NULL,
                               plant_dynamic_input = NULL,
                               timber_volume_function = NULL,
                               plant_biomass_function = NULL,
                               min_tree_dbh = 17.5,
                               max_tree_dbh = NA, ...){


  ## Check additional parameters (add as many as additional arguments)
  if(!inherits(min_tree_dbh, "numeric")) cli::cli_abort("'min_tree_dbh' should be a numeric value")
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")
  if(!inherits(max_tree_dbh, "numeric")) cli::cli_abort("'max_tree_dbh' should be a numeric value")
  if(!max_tree_dbh >= 0) cli::cli_abort("'max_tree_dbh' should be a numeric positive value")

  ## Filter plant_dynamic_input by state = "dead" and DBH >= min_tree_dbh
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "cut", dbh > min_tree_dbh)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(density_dead_wood = sum(n))

  ## Return the output data frame
  res <- df |>
    dplyr::select(id_stand, date, density_dead_wood)
  return(res)
}
