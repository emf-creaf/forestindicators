## RUSLE maintains the same empirically based equation as USLE to compute sheet and rill erosion as follows: 
## A=RKLSCP where A is computed soil loss, R is the rainfall-runoff erosivity factor, 
## K is a soil erodibility factor, L is the slope length factor, 
## S is the slope steepness factor, C is a cover management factor, 
## and P is a supporting practices factor.

.soil_erosion_01 <- function(stand_static_input,
                             stand_dynamic_input = NULL,
                             plant_static_input = NULL,
                             plant_dynamic_input = NULL,
                             k = 0, ...){
  
  ## Check additional parameters (add as many as additional arguments)
  if(!inherits(k, "numeric") | k < 0) cli::cli_abort("'k' should be a positive numeric value") 

  ## Build a single data frame with all the required inputs
  df = stand_dynamic_input |> select(id_stand, date, mean_annual_precipitation, canopy_cover) |>
    left_join(select(stand_static_input, id_stand, slope), by = "id_stand") 
  
  ## Compute soil erosion as mean_annual_precipation * slope * k * (canopy_cover / 100)
  df$soil_erosion_01 = df$mean_annual_precipation * df$slope * (df$canopy_cover / 100) * k 
  
  ## Return the output data frame
  res = df |> select(id_stand, date, soil_erosion_01)
  return(res)
}

