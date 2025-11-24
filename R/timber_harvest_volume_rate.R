.timber_harvest_volume_rate <- function(plant_dynamic_input = NULL,
                                        timber_volume_function = NULL,
                                        min_tree_dbh = 7.5,
                                        max_tree_dbh = NA,
                                        targeted_species = NA,
                                        excluded_species = NA, ...){

  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "cut") |>
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

  ## Compute volume at the tree-level
  ## Other parameters (such as area for Spanish IFN) should go into "..."
  plant_input$vol <- timber_volume_function(plant_input, ...)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(timber_harvest_volume = sum(vol), .groups = "drop") |>
    dplyr::group_by(id_stand) |>
    dplyr::reframe(date = date,
                   timber_harvest_volume = timber_harvest_volume,
                   date_change_years = as.numeric(difftime(date, dplyr::lag(date,1), units = "days"))/365.25) |>
    dplyr::mutate(timber_harvest_volume_rate = timber_harvest_volume/date_change_years)

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, timber_harvest_volume_rate)
  return(res)
}
