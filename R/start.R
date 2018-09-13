#' Start HIDAP
#'
#' Starting HIDAP (a shiny application)
#'
#' @author Omar Benites Ivan Perez RIU
#' @export
start <- function(){
  fp = system.file("hidap_agrofims", package = "hidap")
  shiny::runApp(fp)
}
