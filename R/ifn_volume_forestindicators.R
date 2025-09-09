.ifn_volume_forestindicators <- function(plant_dynamic_input){

  if(!("Province" %in% names(plant_dynamic_input))) cli::cli_abort("plant_dynamic_input should have a column called 'Province' with Spanish province codes")

  df_input = plant_dynamic_input |>
    dplyr::rename(ID = id_stand, Species = plant_entity, N = n, DBH = dbh, H = h)

  vol_bark = IFNallometry::IFNvolume(df_input)

  return(vol_bark[["VCC"]])
}
