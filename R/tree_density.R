.tree_density<-function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5,
                        tree_state = "live",
                        ...) {
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == tree_state) |>
    units::drop_units()

  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::filter(dbh >= min_tree_dbh) |>
    dplyr::summarise(tree_density = sum(n))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, tree_density)
  return(res)
}

.live_tree_density <- function(plant_dynamic_input = NULL,
                             min_tree_dbh = 7.5,
                             ...){
  return(.tree_density(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "live",
                     ...)|>
           dplyr::rename(live_tree_density = tree_density))
}

.cut_tree_density <- function(plant_dynamic_input = NULL,
                            min_tree_dbh = 7.5,
                            ...){
  return(.tree_density(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "cut",
                     ...)|>
           dplyr::rename(cut_tree_density = tree_density))
}

.dead_tree_density <- function(plant_dynamic_input = NULL,
                             min_tree_dbh = 7.5,
                             ...){
  return(.tree_density(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "dead",
                     ...)|>
           dplyr::rename(dead_tree_density = tree_density))
}
