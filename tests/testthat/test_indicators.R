
test_that("foo estimation works",{
  expect_s3_class(estimate_indicators(indicator_definition$indicator, data.frame(), verbose = FALSE), "data.frame")
})
