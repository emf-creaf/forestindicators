
devtools::load_all()

## Arguments
indicators = "timber_harvest_01"
tree_list = example_plant_dynamic_input
additional_params = list(timber_harvest_01 = list(province = 8))

res = estimate_indicators(indicators, plant_dynamic_input = tree_list,
                                timber_volume_function = .ifn_volume_forestindicators, 
                          additional_params = additional_params,
                                verbose = TRUE) 
