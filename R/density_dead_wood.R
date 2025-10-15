.density_dead_wood <- function(stand_static_input = NULL,
                               stand_dynamic_input = NULL,
                               plant_static_input = NULL,
                               plant_dynamic_input = NULL,
                               timber_volume_function = NULL,
                               plant_biomass_function = NULL,
                               large_tree_dbh = NULL, ...){
  
  ## If large_tree_dbh is null, assign default value
  if(is.null(large_tree_dbh)){
    large_tree_dbh = 17.5
  }
  
  ## Check additional parameters (add as many as additional arguments)
  if(!inherits(large_tree_dbh, "numeric")) cli::cli_abort("'large_tree_dbh' should be a numeric value")
  if(!large_tree_dbh >= 0) cli::cli_abort("'large_tree_dbh' should be a numeric positive value")
  
  ## Filter plant_dynamic_input by state = "dead" and DBH >= large_tree_dbh
  plant_input = plant_dynamic_input |> dplyr::filter(state == "cut", dbh > large_tree_dbh)
  
  ## Summarize at the plot-level
  df <- plant_input |> dplyr::group_by(id_stand, date) |> dplyr::summarise(density_dead_wood = sum(n))
  
  ## Return the output data frame
  res = df |> dplyr::select(id_stand, date, density_dead_wood)
  return(res)
}
