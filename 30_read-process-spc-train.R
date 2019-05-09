################################################################################
## Author: Philipp Baumann || philipp.baumann@usys.ethz.ch
## License: GPL-3.0
## Project: Biophysical, institutional and economic drivers of sustainable 
##   soil use in yam systems for improved food security in West Africa (YAMSYS)
## Description: Tune and evaluate PLS regression models to predict Yam 
##   root and leaf elemental concentrations
################################################################################

## Register parallel backend for using multiple cores ==========================

# Allows to tune the models using parallel processing (e.g. use all available
# cores of a CPU); caret package automatically detects the registered backend
# Make a cluster with all possible threads (more than physical cores)
doFuture::registerDoFuture()
plan(multiprocess)


################################################################################
## Part 1: Read and pre-process spectra, Read chemical data, and join
## spectral and chemical data sets
################################################################################

## List of OPUS files obtained from Bruker ALPHA spectrometer at ETH Zürich
lf_leaf <- dir("data/training/spectra/leaf", full.names = TRUE)
lf_tuber <- dir("data/training/spectra/tuber", full.names = TRUE)

## Read files: ETH Zürich
spc_lst_leaf <- read_opus_univ(
  fnames = lf_leaf,
  extract = c("spc", "ScSm", "ScRf"), 
  parallel = TRUE)

spc_lst_tuber <- read_opus_univ(
  fnames = lf_tuber,
  extract = c("spc", "ScSm", "ScRf"),
  parallel = TRUE)


## Spectral data processing pipe ===============================================

## ETH Alpha
spc_tbl_leaf <- spc_lst_leaf %>%
  gather_spc() %>%
  resample_spc(wn_lower = 500, wn_upper = 3996, wn_interval = 2) %>%
  average_spc() %>%
  preprocess_spc(select = "sg_1_w21")

spc_tuber_train <- spc_lst_tuber %>%
  gather_spc() %>%
  resample_spc(wn_lower = 500, wn_upper = 3996, wn_interval = 2) %>%
  average_spc() %>%
  preprocess_spc(select = "sg_1_w21") %>%
  group_by(sample_id) %>%
  slice(1L)
