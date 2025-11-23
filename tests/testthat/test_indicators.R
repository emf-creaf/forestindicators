
test_that("Obvious errors are dealt",{
  expect_error(estimate_indicators("wrong indicator name", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", data.frame(), verbose = FALSE))
  expect_error(estimate_indicators("soil_erosion", c(2,3), verbose = FALSE))
})

example_plant_dynamic_input_units <- example_plant_dynamic_input
example_plant_dynamic_input_units$h <- units::set_units(example_plant_dynamic_input_units$h, "m", mode = "standard")
example_plant_dynamic_input_units$dbh <- units::set_units(example_plant_dynamic_input_units$dbh, "cm", mode = "standard")
example_plant_dynamic_input_units$n <- units::set_units(example_plant_dynamic_input_units$n, "ha-1", mode = "standard")

example_plant_dynamic_input_wrong_units <- example_plant_dynamic_input
example_plant_dynamic_input_wrong_units$h <- units::set_units(example_plant_dynamic_input_wrong_units$h, "cm", mode = "standard")
example_plant_dynamic_input_wrong_units$dbh <- units::set_units(example_plant_dynamic_input_wrong_units$dbh, "m", mode = "standard")
example_plant_dynamic_input_wrong_units$n <- units::set_units(example_plant_dynamic_input_wrong_units$n, "kg", mode = "standard")

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
  expect_s3_class(estimate_indicators("live_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dead_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("cut_tree_basal_area",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("live_tree_basal_area",
                                    plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                    verbose = FALSE))
  expect_error(estimate_indicators("dead_tree_basal_area",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
  expect_error(estimate_indicators("cut_tree_basal_area",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
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
  expect_s3_class(estimate_indicators("live_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dead_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("cut_tree_density",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("live_tree_density",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
  expect_error(estimate_indicators("dead_tree_density",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
  expect_error(estimate_indicators("cut_tree_density",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})

test_that("quadratic mean tree diameter calculation",{
  expect_error(estimate_indicators("quadratic_mean_tree_diameter", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("quadratic_mean_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("quadratic_mean_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("quadratic_mean_tree_diameter",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})
test_that("dominant tree height calculation",{
  expect_error(estimate_indicators("dominant_tree_height", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("dominant_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dominant_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("dominant_tree_height",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})
test_that("mean tree height calculation",{
  expect_error(estimate_indicators("mean_tree_height", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("mean_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("mean_tree_height",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("mean_tree_height",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})
test_that("hart-becking calculation",{
  expect_error(estimate_indicators("hart_becking_index", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("hart_becking_index",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("hart_becking_index",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("hart_becking_index",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})

test_that("dominant tree diameter calculation",{
  expect_error(estimate_indicators("dominant_tree_diameter", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_s3_class(estimate_indicators("dominant_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("dominant_tree_diameter",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("dominant_tree_diameter",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   verbose = FALSE))
})


test_that("live tree volume stock calculation",{
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
  expect_error(estimate_indicators("live_tree_volume_stock", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_error(estimate_indicators("live_tree_volume_stock",
                                   plant_dynamic_input = example_plant_dynamic_input,
                                   verbose = FALSE))
  additional_params <- list(live_tree_volume_stock = list(province=8))
  expect_s3_class(estimate_indicators("live_tree_volume_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("live_tree_volume_stock",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("live_tree_volume_stock",
                                      plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE))
})

test_that("live tree carbon stock calculation",{
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
  expect_error(estimate_indicators("live_tree_carbon_stock", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_error(estimate_indicators("live_tree_carbon_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_carbon_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("live_tree_carbon_stock",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("live_tree_carbon_stock",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                   verbose = FALSE))
})

test_that("live tree biomass stock calculation",{
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
  expect_error(estimate_indicators("live_tree_biomass_stock", data.frame(id_stand = "stand 1"), verbose = FALSE))
  expect_error(estimate_indicators("live_tree_biomass_stock",
                                   plant_dynamic_input = example_plant_dynamic_input,
                                   verbose = FALSE))
  expect_s3_class(estimate_indicators("live_tree_biomass_stock",
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators("live_tree_biomass_stock",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      verbose = FALSE), "data.frame")
  expect_error(estimate_indicators("live_tree_biomass_stock",
                                   plant_dynamic_input = example_plant_dynamic_input_wrong_units,
                                   plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                   verbose = FALSE))
})

test_that("timber harvest calculation",{
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
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
  expect_s3_class(estimate_indicators("timber_harvest",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
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
  expect_s3_class(estimate_indicators("density_dead_wood",
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      additional_params = additional_params,
                                      verbose = FALSE), "data.frame")
})


test_that("several indicators can be calculated",{
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
  additional_params <- list(timber_harvest = list(province=8),
                            density_dead_wood = list(max_tree_dbh = 10))
  expect_s3_class(estimate_indicators(c("live_tree_basal_area", "dead_tree_basal_area", "cut_tree_basal_area",
                                        "density_dead_wood", "timber_harvest", "live_tree_carbon_stock"),
                                     stand_static_input = example_stand_static_input,
                                     stand_dynamic_input = example_stand_dynamic_input,
                                     plant_dynamic_input = example_plant_dynamic_input,
                                     plant_static_input = example_plant_static_input,
                                     timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                     plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                     additional_params = additional_params,
                                     verbose = FALSE), "data.frame")
  expect_s3_class(estimate_indicators(c("live_tree_basal_area", "dead_tree_basal_area", "cut_tree_basal_area",
                                        "density_dead_wood", "timber_harvest", "live_tree_carbon_stock"),
                                      stand_static_input = example_stand_static_input,
                                      stand_dynamic_input = example_stand_dynamic_input,
                                      plant_dynamic_input = example_plant_dynamic_input,
                                      plant_static_input = example_plant_static_input,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE, include_units = TRUE), "data.frame")
  expect_s3_class(estimate_indicators(c("live_tree_basal_area", "dead_tree_basal_area", "cut_tree_basal_area",
                                        "density_dead_wood", "timber_harvest", "live_tree_carbon_stock"),
                                      stand_static_input = example_stand_static_input,
                                      stand_dynamic_input = example_stand_dynamic_input,
                                      plant_dynamic_input = example_plant_dynamic_input_units,
                                      plant_static_input = example_plant_static_input,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
                                      additional_params = additional_params,
                                      verbose = FALSE, include_units = TRUE), "data.frame")
})

test_that("several indicators can be calculated from forestables", {
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("tidyr")
  testthat::skip_if_not_installed("IFNallometry")
  testthat::skip_if_not_installed("forestables")
  ifn4_example <- forestables::ifn_output_example |>
    dplyr::filter(version == "ifn4")
  x <- ifn4_example |>
    dplyr::select(id_unique_code, year, province_code, tree) |>
    tidyr::unnest(cols = tree) |>
    dplyr::select("id_unique_code", "year", "province_code", "sp_name", "density_factor", "dbh", "height", "tree_ifn4") |>
    dplyr::mutate(province_code = as.numeric(province_code)) |>
    dplyr::mutate(year = as.Date(paste0(year, "-01-01"))) |>
    dplyr::rename(id_stand = id_unique_code,
                  province = province_code,
                  date = year,
                  n = density_factor,
                  h = height,
                  plant_entity = sp_name) |>
    dplyr::mutate(state = "live") |>
    dplyr::filter(!is.na(n)) |>
    dplyr::select(-tree_ifn4)

  expect_s3_class(estimate_indicators(c("live_tree_density",
                                        "live_tree_basal_area",
                                        "mean_tree_height",
                                        "dominant_tree_height",
                                        "dominant_tree_diameter",
                                        "quadratic_mean_tree_diameter",
                                        "hart_becking_index"),
                                      plant_dynamic_input = x,
                                      plant_biomass_function = IFNallometry::IFNbiomass_forestindicators,
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
