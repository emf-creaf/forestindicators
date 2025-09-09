#' forestindicators: estimation of multiple indicators of forest ecosystem services
#'
#'  Facilitates the estimation multiple indicators of forest ecosystem services. Indicators are defined in internal functions and tables.
#'
#' @name forestindicators-package
#' @aliases forestindicators forestindicators-package
#' @docType package
#' @author
#' Maintainer: Miquel De Cáceres
#' \email{miquelcaceres@@gmail.com}
#' [ORCID](https://orcid.org/0000-0001-7132-2080)
#'
#' Author: Núria Aquilué
#' [ORCID](https://orcid.org/0000-0001-7911-3144)
#'
#' Contributor: Víctor Granda
#' [ORCID](https://orcid.org/0000-0002-0469-1991)
#'
#' Contributor: José Salgado
#'
#' Contributor: Giuseppe Cappizzi
#'
#' @seealso Useful links: \itemize{ \item{
#' \url{https://emf-creaf.github.io/forestindicators/index.html}} }
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @import cli
#' @import sf
#' @importFrom dplyr bind_rows left_join select summarise group_by mutate
#' @importFrom tibble tibble as_tibble
## usethis namespace: end
NULL

# global variable exporting
utils::globalVariables(c(".data","indicator_definition", "variable_definition",
                         "example_stand_static_input", "example_stand_dynamic_input",
                         "example_plant_static_input", "example_plant_dynamic_input"))
