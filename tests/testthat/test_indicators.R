
test_that("Obvious errors are dealt",{
  expect_error(estimate_indicators("wrong indicator name", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion_01", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion_01", c(2,3), verbose = FALSE))
})

test_that("soil erosion calculation",{
  expect_error(estimate_indicators("soil_erosion_01", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("soil_erosion_01",
                                      stand_static_input = example_stand_static_input,
                                      stand_dynamic_input = example_stand_dynamic_input,
                                      verbose = FALSE), "data.frame")
})

test_that("timber harvest calculation",{
  expect_error(estimate_indicators("timber_harvest_01", data.frame(id_stand = "stand 1"), verbose = FALSE))
  example_plant_dynamic_input$Province = "8"
  expect_s3_class(estimate_indicators("timber_harvest_01",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      timber_volume_function = forestindicators:::.ifn_volume_forestindicators,
                                      verbose = FALSE), "data.frame")
})

test_that("recreational value calculation",{
  expect_s3_class(estimate_indicators("recreational_value_01",
                                      stand_static_input = example_stand_static_input,
                                      plant_static_input = example_plant_static_input,
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
})

test_that("several indicators can be calculated",{
  expect_s3_class(estimate_indicators(c("soil_erosion_01", "recreational_value_01"),
                                     stand_static_input = example_stand_static_input,
                                     stand_dynamic_input = example_stand_dynamic_input, plant_dynamic_input = example_plant_dynamic_input, plant_static_input = example_plant_static_input,
                                     verbose = FALSE, additional_params = list(soil_erosion_01 = list(k=1))), "data.frame")
})
