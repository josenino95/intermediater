# First test, download data for this StationID US1CAAL0001

library(tictoc)
library(future)
library(furrr)

download_noaa_file <- function(StationId) {
filename <- StationId
url <- paste0("https://www.ncei.noaa.gov/data/ghcnm/v4/precipitation/access/", filename, ".csv")
download.file(url = url,
              destfile = paste0(filename, ".csv"),
              quiet=TRUE)
}

tic("Single file")
download_noaa_file("US1CAAL0001")
toc()

list_of_four <- c("US1CAAL0001", "US1CAAL0002", "US1CAAL0003", "US1CAAL0004")

tic("Serial for loop")
lapply(list_of_four, download_noaa_file)
toc()
  

plan(multisession)
availableCores()
tic("Multisession")
future_map(list_of_four, download_noaa_file)
toc()
