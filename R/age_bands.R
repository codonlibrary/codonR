#' Place age into appropriate X year band
#'
#' @param age  Age of the person.
#' @param X Width of year band (default: 10)
#' @return The age-band that the age belongs
#'
#' @examples
#' age_band(3)
#' # "0-9"
#' age_bands(3, X= 5)
#' # "0-4"
#'
#' @export 

age_bands <- function(age, X = 10){
  
  if(is.null(age)){
    return("Age unknown")
  }
  
  if (age >= 90){
    if (age >= 150){
      stop( paste0( collapse = "", "The age input: ", age, "is too large.") )
    } else {
      return("90 and over")
    }
  } else {
    if(age < 0){
      stop( paste0( collapse = "", "The age input: ", age, "is too small.") )
    } else {
      lowerbound = X * floor(age / X)
      upperbound = lowerbound + X - 1
      return( paste0( collapse = "",  lowerbound, "-", upperbound) )
    }
  }
}


