.tree_basal_area <- function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5,
                        tree_state = "live",
                        ...){

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == tree_state) |>
    units::drop_units()

  ## Compute basal area at the tree-cohort level
  plant_input <- plant_input |>
    dplyr::filter(dbh >= min_tree_dbh) |>
    dplyr::mutate(tree_basal_area = n*pi*(dbh/200)^2)

  ## Aggregate basal area to the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(tree_basal_area = sum(tree_basal_area))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, tree_basal_area)

  return(res)
}

.live_tree_basal_area <- function(plant_dynamic_input = NULL,
                             min_tree_dbh = 7.5,
                             ...){
  return(.tree_basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "live",
                     ...)|>
           dplyr::rename(live_tree_basal_area = tree_basal_area))
}

.cut_tree_basal_area <- function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5,
                        ...){
  return(.tree_basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "cut",
                     ...)|>
           dplyr::rename(cut_tree_basal_area = tree_basal_area))
}

.dead_tree_basal_area <- function(plant_dynamic_input = NULL,
                            min_tree_dbh = 7.5,
                            ...){
  return(.tree_basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "dead",
                     ...)|>
           dplyr::rename(dead_tree_basal_area = tree_basal_area))
}
