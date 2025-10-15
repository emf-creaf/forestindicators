.timber_harvest <- function(stand_static_input = NULL,
                            stand_dynamic_input = NULL,
                            plant_static_input = NULL,
                            plant_dynamic_input = NULL,
                            timber_volume_function = NULL,
                            plant_biomass_function = NULL,
                            province = NA,
                            min_tree_dbh = NA,
                            max_tree_dbh = NA,
                            targeted_species = NULL,
                            excluded_species = NULL, ...){

  ## Check additional parameters (add as many as additional arguments)
  if(!is.na(province)) {
    if(!inherits(province, "numeric")) cli::cli_abort("'province' should be a numeric value")
  }

  ## If province is not null, add it in plant_dynamic_input
  if(!is.na(province)){
    plant_dynamic_input <- plant_dynamic_input |>
      dplyr::mutate(Province = province)
  }

  ## Filter plant_dynamic_input by state = "cut"
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "cut")

  ## Compute volume over bark at the tree-level
  plant_input$vol <- timber_volume_function(plant_input)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(timber_harvest = sum(vol))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, timber_harvest)
  return(res)
}
