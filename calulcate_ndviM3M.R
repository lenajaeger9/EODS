
## script to calculates NDVI for all rasters in the ortho_path and exporting into target_path
## note that this script is made for M3M data that is co-registered. 

library(terra)

# Functions provided via GitHub (https://github.com/lenajaeger9/EODS)
source("/Users/lenajaeger/Documents/Semester1/GlacialLakeAnalysis/Functions.R") 

#alternatively:
fun_ndvi <- function(nir, red){
  return((nir - red) / (nir + red))
}

# ⚠️ set paths (adapt)
# ortho path containing all multispectral orthomosaics: 
ortho_path <- "/Users/lenajaeger/Documents/SenescencePaper/data/Luz/stacks/"
# path where ndvi files should be saved (target path): 
target_path <- "/Users/lenajaeger/Documents/SenescencePaper/data/Luz/NDVI/"

# bands from Co-Registered stacks: R, G, B, RED MS, NIR MS 
bands <- c("R","G", "B", "RED_MS", "NIR_MS") 

# Get a list of all files in the folder
tif_files <- list.files(path = ortho_path, pattern = ".tif", full.names = TRUE)

# loop through files to calculate and export NDVI
for (file in tif_files) {
  cat("Processing raster:", substring(file, nchar(file) - 30), "\n")
  # Extract the original filename (without extension)
  file_basename <- tools::file_path_sans_ext(basename(file))
  # output filename
  ndvi_filename <- paste0(file_basename, "_NDVI.tif")
  # load raster
  raster <- rast(file)
  # rename bands
  names(raster) <- bands
  # Calculate NDVI using the custom function
  ndvi <- fun_ndvi(nir = raster$NIR_MS, red = raster$RED_MS)
  # Write NDVI raster to the output directory
  writeRaster(ndvi, file.path(target_path, ndvi_filename), overwrite = T)
  cat("NDVI raster written to:", file.path(target_path, ndvi_filename), "\n\n")
}