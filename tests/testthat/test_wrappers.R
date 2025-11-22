test_that("several indicators can be calculated from medfate/medfateland", {
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::skip_if_not_installed("IFNallometry")
  testthat::skip_if_not_installed("medfate")
  testthat::skip_if_not_installed("medfateland")
  library(medfate)
  data(examplemeteo)
  data(exampleforest)
  data(SpParamsMED)
  #Prepare a two-year meteorological data with half precipitation during
  #the second year
  meteo2001 <- examplemeteo
  meteo2002 <- examplemeteo
  meteo2002$Precipitation <- meteo2002$Precipitation/2
  meteo2002$dates <- seq(as.Date("2002-01-01"),
                         as.Date("2002-12-31"), by="day")
  meteo_01_02 <- rbind(meteo2001, meteo2002)
  #Initialize control parameters
  control <- defaultControl("Granier")
  control$verbose <- FALSE
  #Define soil with default soil params (4 layers)
  examplesoil <- defaultSoilParams(4)
  #Call simulation function
  fd <- medfate::fordyn(exampleforest, examplesoil,
                        medfate::SpParamsMED, meteo_01_02, control,
                        latitude = 41.82592, elevation = 100)
  x <- medfate2forestindicators(fd, "1")
  expect_s3_class(x, "data.frame")
  expect_s3_class(estimate_indicators(c("live_tree_density",
                                       "live_tree_basal_area",
                                       "mean_tree_height",
                                       "dominant_tree_height",
                                       "dominant_tree_diameter",
                                       "quadratic_mean_tree_diameter",
                                       "hart_becking_index"),
                                     plant_dynamic_input = x,
                                     verbose = FALSE), "data.frame")

  expect_s3_class(estimate_indicators(c("live_tree_volume_stock"),
                                      plant_dynamic_input = x,
                                      timber_volume_function = IFNallometry::IFNvolume_forestindicators,
                                      additional_params = list(live_tree_volume_stock=list(province = 8)),
                                      verbose = FALSE), "data.frame")

  # medfateland
  library(medfateland)
  data("example_ifn")
  # Subset two plots to speed-up calculations
  res_noman <- fordyn_spatial(example_ifn[31:32, ], SpParamsMED, examplemeteo, progress = FALSE)
  x <- medfate2forestindicators(res_noman)
  expect_s3_class(x, "data.frame")
  expect_s3_class(estimate_indicators(c("live_tree_density",
                                        "live_tree_basal_area",
                                        "mean_tree_height",
                                        "dominant_tree_height",
                                        "dominant_tree_diameter",
                                        "quadratic_mean_tree_diameter",
                                        "hart_becking_index"),
                                      plant_dynamic_input = x,
                                      verbose = FALSE), "data.frame")

  # Creates scenario with one management unit and annual demand for P. nigra
  scen <- medfateland::create_management_scenario(1, c("Pinus nigra/Pinus sylvestris" = 2300))
  example_ifn$management_unit <- 1
  example_ifn$represented_area_ha <- 100
  example_ifn_utm31 <- sf::st_transform(example_ifn, crs = 32631)
  example_subset <- example_ifn_utm31[31:33, ]
  fs_12 <- medfateland::fordyn_scenario(example_subset, medfate::SpParamsMED, meteo = medfate::examplemeteo,
                           volume_function = NULL, management_scenario = scen,
                           parallelize = FALSE, progress = FALSE)
  x <- medfate2forestindicators(fs_12)
  expect_s3_class(x, "data.frame")
  expect_s3_class(estimate_indicators(c("live_tree_density",
                                        "live_tree_basal_area",
                                        "mean_tree_height",
                                        "dominant_tree_height",
                                        "dominant_tree_diameter",
                                        "quadratic_mean_tree_diameter",
                                        "hart_becking_index"),
                                      plant_dynamic_input = x,
                                      verbose = FALSE), "data.frame")

  ## TOO LONG to run
  # data("example_watershed")
  # example_watershed$crop_factor <- NA
  # example_watershed$crop_factor[example_watershed$land_cover_type=="agriculture"] <- 0.75
  # example_watershed$result_cell <- FALSE
  # example_watershed$result_cell[c(3,6,9)] <- TRUE
  # r <-terra::rast(xmin = 401380, ymin = 4671820, xmax = 402880, ymax = 4672620,
  #                 nrow = 8, ncol = 15, crs = "epsg:32631")
  # ws_control <- default_watershed_control("tetis")
  # res_ws <- fordyn_land(r, example_watershed, SpParamsMED, examplemeteo,
  #                       summary_frequency = "month", local_control = defaultControl(soilDomains = "buckets"),
  #                       watershed_control = ws_control, progress = TRUE)
  # x <- medfate2forestindicators(res_ws)
  # expect_s3_class(x, "data.frame")
  # expect_s3_class(estimate_indicators(c("live_tree_density",
  #                                       "live_tree_basal_area",
  #                                       "mean_tree_height",
  #                                       "dominant_tree_height",
  #                                       "dominant_tree_diameter",
  #                                       "quadratic_mean_tree_diameter",
  #                                       "hart_becking_index"),
  #                                     plant_dynamic_input = x,
  #                                     verbose = FALSE), "data.frame")

})
