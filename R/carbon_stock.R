.carbon_stock <- function(plant_dynamic_input = NULL,
                          plant_biomass_function = NULL,
                          fraction = "total",
                          targeted_species = NA,
                          excluded_species = NA, ...){

  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "live")

  if(!is.na(targeted_species)) {
    plant_input <- plant_input |>
      dplyr::filter(plant_entity %in% targeted_species)
  }
  if(!is.na(excluded_species)) {
    plant_input <- plant_input |>
      dplyr::filter(!(plant_entity %in% targeted_species))
  }

  ## Compute biomass at the tree-level
  ## Other parameters (such as area for Spanish IFN) should go into "..."
  plant_input$biomass <- plant_biomass_function(plant_input, fraction = fraction, ...)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(carbon_stock = sum(biomass))

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, carbon_stock)
  return(res)
}
