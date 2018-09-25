################################################################################
## Author: Philipp Baumann || philipp.baumann@usys.ethz.ch
## License: GPL-3.0
## Project: Biophysical, institutional and economic drivers of sustainable 
##   soil use in yam systems for improved food security in West Africa (YAMSYS)
## Description: Process tuber test data; data set of Patricia Schwitter
################################################################################

## Register parallel backend for using multiple cores ==========================

# Allows to tune the models using parallel processing (e.g. use all available
# cores of a CPU); caret package automatically detects the registered backend
library("doParallel")
# Make a cluster with all possible threads (more than physical cores)
cl <- makeCluster(detectCores())
# Register backend
registerDoParallel(cl)
# Return number of parallel workers
getDoParWorkers() # 8 threads on MacBook Pro (Retina, 15-inch, Mid 2015);
# Quadcore processor

################################################################################
## Part 1: Read and pre-process spectra, Read chemical data, and join
## spectral and chemical data sets
################################################################################

## List of OPUS files obtained from Bruker ALPHA spectrometer at ETH Zürich
lf_tuber_test <- dir("data/test/tuber/spectra", full.names = TRUE)
lf_tuber_beatrice <- dir("data/test_beatrice", full.names = TRUE)

## Read files into list
spc_lst_tuber_test <- read_opus_univ(
  fnames = lf_tuber_test,
  extract = "spc",
  parallel = TRUE)

spc_lst_tuber_beatrice <- read_opus_univ(
  fnames = lf_tuber_beatrice,
  extract = "spc",
  parallel = TRUE)


## Spectral data processing pipeline ===========================================

spc_tuber_test <- spc_lst_tuber_test %>%
  gather_spc() %>%
  resample_spc(wn_lower = 500, wn_upper = 3996, wn_interval = 2) %>%
  average_spc() %>%
  preprocess_spc(select = "sg_1_w21")

spc_tuber_beatrice <- spc_lst_tuber_beatrice %>%
  gather_spc() %>%
  resample_spc(wn_lower = 500, wn_upper = 3996, wn_interval = 2) %>%
  average_spc() %>%
  preprocess_spc(select = "sg_1_w21")