.live_tree_volume_stock <- function(plant_dynamic_input = NULL,
                                    timber_volume_function = NULL,
                                    min_tree_dbh = 7.5,
                                    max_tree_dbh = NA,
                                    targeted_species = NA,
                                    excluded_species = NA, ...){

  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live")

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
  plant_input$volume <- timber_volume_function(plant_input, ...)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(live_tree_volume_stock = sum(volume))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, live_tree_volume_stock)
  return(res)
}
