#' Available indicator information
#'
#' Provides the list of indicators currently available
#'
#' @returns A data frame with information of available indicator functions and their requirements.
#' @export
#'
available_indicators<-function() {
  return(indicator_definition$indicator)
}

