
test_that("Obvious errors are dealt",{
  expect_error(estimate_indicators("wrong indicator name", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", c(2,3), verbose = FALSE))
})

test_that("basal area calculation",{
  expect_error(estimate_indicators("basal_area", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("basal_area",
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

test_that("dominant tree diameter calculation",{
  expect_error(estimate_indicators("dominant_tree_diameter", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("dominant_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})
## 2.
test_that("timber harvest calculation",{
  expect_error(estimate_indicators("timber_harvest", data.frame(id_stand = "stand 1"), verbose = FALSE))
  additional_params <- list(timber_harvest = list(province = 8))
  expect_s3_class(estimate_indicators("timber_harvest",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      timber_volume_function = forestindicators:::.ifn_volume_forestindicators,
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


# test_that("several indicators can be calculated",{
#   expect_s3_class(estimate_indicators(c("soil_erosion_01", "recreational_value_01"),
#                                      stand_static_input = example_stand_static_input,
#                                      stand_dynamic_input = example_stand_dynamic_input, plant_dynamic_input = example_plant_dynamic_input, plant_static_input = example_plant_static_input,
#                                      verbose = FALSE, additional_params = list(soil_erosion_01 = list(k=1))), "data.frame")
# })



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
