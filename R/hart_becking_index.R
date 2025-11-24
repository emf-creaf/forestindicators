.hbi<-function(n, h, dbh, min_tree_dbh) {
  return((100/.dth(n,h, dbh, min_tree_dbh))*sqrt(10000/sum(n[dbh>=min_tree_dbh])))
}

.hart_becking_index<-function(plant_dynamic_input = NULL,
                              min_tree_dbh = 7.5, ...) {
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live") |>
    units::drop_units()

  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::filter(!is.na(n), !is.na(dbh), !is.na(h)) |>
    dplyr::summarise(hart_becking_index = .hbi(n, h, dbh, min_tree_dbh = min_tree_dbh))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, hart_becking_index)
  return(res)
}
