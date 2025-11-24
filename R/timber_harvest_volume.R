.timber_harvest_volume <- function(plant_dynamic_input = NULL,
                            timber_volume_function = NULL,
                            min_tree_dbh = 7.5,
                            max_tree_dbh = NA,
                            targeted_species = NA,
                            excluded_species = NA, ...){

  ## Filter plant_dynamic_input by state = "cut"
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "cut") |>
    dplyr::filter(!is.na(dbh), !is.na(n), !is.na(h), !is.na(plant_entity)) |>
    units::drop_units()

  if(!is.na(min_tree_dbh)) {
    plant_input <- plant_input |>
      dplyr::filter(dbh >= min_tree_dbh)
  }
  if(!is.na(max_tree_dbh)) {
    plant_input <- plant_input |>
      dplyr::filter(dbh <= max_tree_dbh)
  }
  if(!is.na(targeted_species)) {
    plant_input <- plant_input |>
      dplyr::filter(plant_entity %in% targeted_species)
  }
  if(!is.na(excluded_species)) {
    plant_input <- plant_input |>
      dplyr::filter(!(plant_entity %in% targeted_species))
  }

  ## Compute volume over bark at the tree-level
  ## Other parameters (such as province for Spanish IFN) should go into "..."
  plant_input$vol <- timber_volume_function(plant_input, ...)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(timber_harvest_volume = sum(vol))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, timber_harvest_volume)
  return(res)
}
