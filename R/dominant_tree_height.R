.dth<-function(n, h, dbh, min_tree_dbh) {
  if(length(n)<1) return(NA)
  o <-order(h, decreasing=TRUE)
  dbh = dbh[o]
  h <- h[o]
  n <- n[o]
  n <- n[dbh>=min_tree_dbh]
  h <- h[dbh>=min_tree_dbh]
  if(length(n)>0) {
    ncum <- 0
    for(i in 1:length(h)) {
      ncum_prev <- ncum
      ncum <- ncum + n[i]
      if(ncum>100) {
        n[i] <- 100 - ncum_prev # Only adds up to 100 trees
        return(sum(h[1:i]*n[1:i])/sum(n[1:i]))
      }
    }
    return(sum(h*n)/sum(n))
  }
  return(NA)
}

.dominant_tree_height<-function(plant_dynamic_input = NULL,
                                min_tree_dbh = 7.5, ...) {
  if(!min_tree_dbh >= 0) cli::cli_abort("'min_tree_dbh' should be a numeric positive value")

  ## Filter plant_dynamic_input by state
  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live") |>
    units::drop_units()

  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(dominant_tree_height = .dth(n, h, dbh, min_tree_dbh = min_tree_dbh))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, dominant_tree_height)
  return(res)
}
