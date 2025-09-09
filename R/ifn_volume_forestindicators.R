.ifn_volume_forestindicators <- function(stand_static_input, plant_dynamic_input){
  
  df_input = plant_dynamic_input |> 
    dplyr::left_join(dplyr::select(stand_static_input, "id_stand", "Province"), by="id_stand") |>
    dplyr::rename(ID = id_stand, Species = plant_entity, N = n, DBH = dbh, H = h)
  
  vol_bark = IFNallometry::IFNvolume(df_input)
  
  return(vol_bark[["VCC"]])
}