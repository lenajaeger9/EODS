## ------------------------ Functions ------------------------ ##

fun_ndvi <- function(nir, red){
  return((nir - red) / (nir + red))
}

fun_ndwi <- function(green, nir) {
  return((green - nir) / (green + nir))
}

fun_ndsi <- function(green, swir1) {
  return((green - swir1) / (green + swir1))
}

fun_ndgi <- function(green, red){
  return((green - red) / (green + red))
}

fun_psri <- function(red, green, nir){
  return((red - green) / (nir))
}

fun_ndre <- function(nir, rededge) {
  return((nir - rededge) / (nir + rededge))
}

fun_savi <- function(nir, red) {
  return((nir - red) / (nir + red + 0.5) * (1.5))
}




## functions from Yan et al. (2020)
fun_ndwi_mod <- function(green, nir) {
  return((green - 2 * nir) / (green + nir))
}

fun_ndsi_mod <- function(nir, swir1) {
  return((nir - swir1 - 0.05) / (nir + swir1))
}

