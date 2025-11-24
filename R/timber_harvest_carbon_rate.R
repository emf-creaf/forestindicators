.timber_harvest_carbon_rate <- function(plant_dynamic_input = NULL,
                                        plant_biomass_function = NULL,
                                        targeted_species = NA,
                                        excluded_species = NA, ...){

  plant_input <- plant_dynamic_input |>
    dplyr::filter(state == "cut") |>
    units::drop_units()

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
  plant_input$biomass <- plant_biomass_function(plant_input, fraction = "stem", as.CO2 = TRUE, ...)

  ## Summarize at the plot-level
  df <- plant_input |>
    dplyr::group_by(id_stand, date) |>
    dplyr::summarise(timber_harvest_biomass = sum(biomass), .groups = "drop") |>
    dplyr::group_by(id_stand) |>
    dplyr::reframe(date = date,
                   timber_harvest_biomass = timber_harvest_biomass,
                   date_change_years = as.numeric(difftime(date, dplyr::lag(date,1), units = "days"))/365.25) |>
    dplyr::mutate(timber_harvest_carbon_rate = timber_harvest_biomass/date_change_years)

  ## Return the output data frame
  res <- df |> dplyr::select(id_stand, date, timber_harvest_carbon_rate)
  return(res)
}
