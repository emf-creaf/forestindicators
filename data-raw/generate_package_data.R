indicator_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                       sheet="indicators"), stringsAsFactors=FALSE)
usethis::use_data(indicator_definition, overwrite = TRUE)

variable_definition <-as.data.frame(readxl::read_xlsx("data-raw/forestindicators_input.xlsx",
                                                      sheet="variables"), stringsAsFactors=FALSE)
usethis::use_data(variable_definition, overwrite = TRUE)
