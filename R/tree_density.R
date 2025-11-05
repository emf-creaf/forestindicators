.tree_density<-function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5, ...) {
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live")

  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::filter(dbh >= min_tree_dbh) |>
    dplyr::summarise(tree_density = sum(n))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, tree_density)
  return(res)
}
