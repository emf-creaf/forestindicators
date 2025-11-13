.basal_area <- function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5,
                        tree_state = "live",
                        ...){

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == tree_state)

  ## Compute basal area at the tree-cohort level
  plant_input <- plant_input |>
    dplyr::filter(dbh >= min_tree_dbh) |>
    dplyr::mutate(basal_area = n*pi*(dbh/200)^2)

  ## Aggregate basal area to the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(basal_area = sum(basal_area))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, basal_area)

  return(res)
}

.live_basal_area <- function(plant_dynamic_input = NULL,
                             min_tree_dbh = 7.5,
                             ...){
  return(.basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "live",
                     ...)|>
           dplyr::rename(live_basal_area = basal_area))
}

.cut_basal_area <- function(plant_dynamic_input = NULL,
                        min_tree_dbh = 7.5,
                        ...){
  return(.basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "cut",
                     ...)|>
           dplyr::rename(cut_basal_area = basal_area))
}

.dead_basal_area <- function(plant_dynamic_input = NULL,
                            min_tree_dbh = 7.5,
                            ...){
  return(.basal_area(plant_dynamic_input,
                     min_tree_dbh,
                     tree_state = "dead",
                     ...)|>
           dplyr::rename(dead_basal_area = basal_area))
}
