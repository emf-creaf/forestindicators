.timber_harvest_01 <- function(stand_static_input,
                               stand_dynamic_input = NULL,
                               plant_static_input = NULL,
                               plant_dynamic_input = NULL,
                               timber_volume_function = NULL,
                               plant_biomass_function = NULL,
                               a = 0, ...){
  
  ## Check additional parameters (add as many as additional arguments)
  if(!inherits(a, "numeric")) cli::cli_abort("'a' should be a numeric value") 
  
  ## Filter plant_dynamic_input by state = "cut"
  tree_cut = plant_dynamic_input |> filter(state == "cut")  
  
  
  ## Return the output data frame
  res = df |> select(id_stand, date, timber_harvest_01)
  return(res)
}