
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
