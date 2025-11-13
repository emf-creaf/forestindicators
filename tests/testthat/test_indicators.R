
test_that("Obvious errors are dealt",{
  expect_error(estimate_indicators("wrong indicator name", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", c(2,3), verbose = FALSE))
})

test_that("tree basal area calculation",{
  expect_error(estimate_indicators("live_tree_basal_area", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dead_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("cut_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})
test_that("tree density calculation",{
  expect_error(estimate_indicators("live_tree_density", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dead_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("cut_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})

test_that("quadratic mean tree diameter calculation",{
  expect_error(estimate_indicators("quadratic_mean_tree_diameter", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("quadratic_mean_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})
test_that("dominant tree height calculation",{
  expect_error(estimate_indicators("dominant_tree_height", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("dominant_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})
test_that("mean tree height calculation",{
  expect_error(estimate_indicators("mean_tree_height", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("mean_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})
test_that("hart-becking calculation",{
  expect_error(estimate_indicators("hart_becking_index", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("hart_becking_index",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})

test_that("dominant tree diameter calculation",{
  expect_error(estimate_indicators("dominant_tree_diameter", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("dominant_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})

test_that("live tree carbon stock calculation",{
  expect_error(estimate_indicators("live_tree_carbon_stock", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_error(estimate_indicators("live_tree_carbon_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_carbon_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
})

test_that("live tree biomass stock calculation",{
  expect_error(estimate_indicators("live_tree_biomass_stock", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_error(estimate_indicators("live_tree_biomass_stock",
                                   plant_dynamic_input = example_plant_dynamic_input,
                                   verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_biomass_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
})
test_that("timber harvest calculation",{
  expect_error(estimate_indicators("timber_harvest", data.frame(id_stand = "stand 1"), verbose = FALSE))
  additional_params <- list(timber_harvest = list(province = 8))
  expect_error(estimate_indicators("timber_harvest",
                                   plant_dynamic_input = example_plant_dynamic_input,
                                   timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                   additional_params = list(),
                                   verbose = FALSE))
  expect_s3_class(estimate_indicators("timber_harvest",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE), "data.frame")
})


test_that("density dead wood calculation",{
  additional_params <- list(density_dead_wood = list(max_tree_dbh = 10))
  expect_s3_class(estimate_indicators("density_dead_wood",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      additional_params = additional_params,
                                      verbose = FALSE), "data.frame")
})


test_that("several indicators can be calculated",{
  additional_params <- list(timber_harvest = list(province=8),
                            density_dead_wood = list(max_tree_dbh = 10))
  expect_s3_class(estimate_indicators(c("live_basal_area", "dead_basal_area", "cut_basal_area", "density_dead_wood", "timber_harvest", "carbon_stock"),
                                     stand_static_input = example_stand_static_input,
                                     stand_dynamic_input = example_stand_dynamic_input,
                                     plant_dynamic_input = example_plant_dynamic_input,
                                     plant_static_input = example_plant_static_input,
                                     timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                     plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                     additional_params = additional_params,
                                     verbose = FALSE), "data.frame")
})



# test_that("soil erosion calculation",{
#   expect_error(estimate_indicators("soil_erosion_01", data.frame(id_stand = "stand 1"), verbose = FALSE))
#   expect_s3_class(estimate_indicators("soil_erosion_01",
#                                       stand_static_input = example_stand_static_input,
#                                       stand_dynamic_input = example_stand_dynamic_input,
#                                       verbose = FALSE), "data.frame")
# })

# test_that("recreational value calculation",{
#   expect_s3_class(estimate_indicators("recreational_value_01",
#                                       stand_static_input = example_stand_static_input,
#                                       plant_static_input = example_plant_static_input,
#                                       plant_dynamic_input = example_plant_dynamic_input,
#                                       verbose = FALSE), "data.frame")
# })
#
