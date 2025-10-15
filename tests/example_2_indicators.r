
devtools::load_all()

## Timber volume and density of dead wood
## Arguments
indicators = c("timber_harvest", "density_dead_wood")
tree_list = example_plant_dynamic_input
additional_params = list(timber_harvest_01 = list(province = 8),
                         density_dead_wood = list(large_tree_dbh = 20),
                         fire_wood = list(max_tree_dhb = 22.5,
                                          target_species = c("Quercus ilex", "Quercus suber", "...")))
## Call it
res = estimate_indicators(indicators, plant_dynamic_input = tree_list,
                          timber_volume_function = .ifn_volume_forestindicators, 
                          additional_params = additional_params,
                          verbose = TRUE) 

View(res)
