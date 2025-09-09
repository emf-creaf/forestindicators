## All outputs will be at the plot-level

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
  plant_input = plant_dynamic_input |> dplyr::filter(state == "cut")

  ##
  plant_input$vol = timber_volume_function(plant_input)

  ## Summarize
  df <- plant_input |> dplyr::group_by(id_stand, date) |> dplyr::summarise(timber_harvest_01 = sum(vol))

  ## Return the output data frame
  res = df |> dplyr::select(id_stand, date, timber_harvest_01)
  return(res)
}
