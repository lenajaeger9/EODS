## script to automatically calculate NDVI for all rasters in the ortho_path and exporting into ndvi_path
## note that this script is made for M3M data; if other sensor; needs adapting band names etc
## if alpha channel is saved during processing, the script deletes this band

library(terra)

# Functions provided via GitHub (https://github.com/lenajaeger9/EODS)
source("/Users/lenajaeger/Documents/Semester1/GlacialLakeAnalysis/Functions.R") 

# ⚠️ set paths (adapt)
# ortho path containing all Multispectral Orthomosaics
ortho_path <- "/Users/lenajaeger/Documents/SenescencePaper/data/Luz/Ortho"
ndvi_path <- "/Users/lenajaeger/Documents/SenescencePaper/data/Luz/NDVI"

bands_M3M <- c("green", "red", "RedEdge", "nir")

# Get a list of all files in the folder
tif_files <- list.files(path = ortho_path, pattern = ".tif", full.names = TRUE)


# loop through files to calculate and export NDVI
for (file in tif_files) {
  cat("Processing raster:", substring(file, nchar(file) - 30), "\n")
  
  # Extract the original filename (without extension)
  file_basename <- tools::file_path_sans_ext(basename(file))
  # output filename
  ndvi_filename <- paste0(file_basename, "_NDVI.tif")
  
  raster_stack <- rast(file)
  
  # Check the number of bands and delete alpha channel if present
  num_bands <- nlyr(raster_stack)
  cat("Number of Bands:", num_bands, "\n")
  
  if (num_bands == 5) {
    raster_stack <- raster_stack[[1:4]]
    cat("Removed the last band\n")
  }
  
  names(raster_stack) <- bands_M3M
  
  # Calculate NDVI using the custom function
  ndvi <- fun_ndvi(raster_stack$nir, raster_stack$red)
  
  # Write NDVI raster to the output directory
  writeRaster(ndvi, file.path(ndvi_path, ndvi_filename), overwrite = T)
  cat("NDVI raster written to:", file.path(ndvi_path, ndvi_filename), "\n\n")
}

