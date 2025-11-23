.quadratic_mean_tree_diameter<-function(plant_dynamic_input = NULL,
                                        min_tree_dbh = 7.5, ...) {
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")

  .qmtd<-function(n, h, dbh, min_tree_dbh) {
    if(length(n)<1) return(NA)
    tba = n*pi*(dbh/200)^2
    ba = sum(tba[dbh>=min_tree_dbh])
    return(200*sqrt(ba/(pi*sum(n[dbh>=min_tree_dbh]))))
  }

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live") |>
    units::drop_units()

  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(quadratic_mean_tree_diameter = .qmtd(n, h, dbh, min_tree_dbh = min_tree_dbh))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, quadratic_mean_tree_diameter)
  return(res)
}
