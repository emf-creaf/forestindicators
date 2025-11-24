test_that("Information about indicators can be shown",{
  for(i in 1:length(indicator_definition$indicator)) {
    indicator  <- indicator_definition$indicator[i]
    expect_no_condition(capture.output(show_information(indicator)))
  }
})
