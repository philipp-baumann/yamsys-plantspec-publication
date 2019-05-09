################################################################################
## Author: Philipp Baumann || philipp.baumann@usys.ethz.ch
## License: GPL-3.0
## Project: Biophysical, institutional and economic drivers of sustainable 
##   soil use in yam systems for improved food security in West Africa (YAMSYS)
## Description: Tune and evaluate PLS regression models to predict yam 
##   tuber elemental concentrations
################################################################################


## Register parallel backend for using multiple cores ==========================

# Allows to tune the models using parallel processing (e.g. use all available
# cores of a CPU); caret package automatically detects the registered backend
# Make a cluster with all possible threads (more than physical cores)
doFuture::registerDoFuture()
plan(multiprocess)

## Prepare final data for spectral modeling ====================================

# Join spectra tibble and chemical reference analysis tibble
spc_elements_tuber <- join_spc_chem(
  spc_tbl = spc_tuber_train, chem_tbl = elements_yam_tuber, by = "sample_id")

spc_elements_leaf <- join_spc_chem(
  spc_tbl = spc_tbl_leaf, chem_tbl = elements_yam_leaf, by = "sample_id")



################################################################################
## Tune and cross-validate training models for yam tubers
################################################################################

## Run PLS regression models for all measured soil properties
## Use 5 times repeated 10-fold cross-validation for model tuning and
## use by resampling repeat averaged (mean) held-out predictions at
## finally chosen of PLS regression components for model evaluation;
## argument `resampling_method` = "rep_kfold_cv" creates 5 times repeated
## cross-validation; always exclude missing values for samples that have missing
## values in the target soil property variable
## =============================================================================

## Use 5 times repeated 10-fold cross-validation

# Total N
pls_tuber_N <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$N), ],
  response = N,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total C
# Omit outlier at > 800 g / kg C
pls_tuber_C <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$C) &
    spc_elements_tuber$C < 800, ],
  response = C,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total S
pls_tuber_S <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$S), ],
  response = S,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total P
# Remove outlier at > 4000 mg P / kg
pls_tuber_P <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$P) & 
    spc_elements_tuber$P < 4000, ],
  response = P,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total K
pls_tuber_K <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$K), ],
  response = K,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Ca
# Remove outlier at > 2000 mg Ca / kg
pls_tuber_Ca <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$Ca) &
    spc_elements_tuber$Ca < 2000, ],
  response = Ca,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Mg
# Remove outlier at > 3000 mg Mg / kg
pls_tuber_Mg <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$Mg) &
    spc_elements_tuber$Mg < 3000, ],
  response = Mg,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Fe
# Remove outliers at > 150 mg Fe / kg
pls_tuber_Fe <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$Fe) &
    spc_elements_tuber$Fe < 150, ],
  response = Fe,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Zn
# Remove outliers at > 75mg Zn / kg
pls_tuber_Zn <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$Zn) &
    spc_elements_tuber$Zn < 75, ],
  response = Zn,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Cu
pls_tuber_Cu <- fit_pls(
  spec_chem = spc_elements_tuber[!is.na(spc_elements_tuber$Cu), ],
  response = Cu,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)


################################################################################
## Write all pls models (R objects) into separate files
## using the saveRDS function
## .Rds files are R data files that contain a single R object, in our case
## it is a list from the output of the fit_pls() function
## These files can be directly loaded into a new R session where e.g. calibrated
## properties are predicted based on new sample spectra
################################################################################

saveRDS(pls_tuber_N, "models/training/tuber/pls_tuber_N.Rds")
saveRDS(pls_tuber_C, "models/training/tuber/pls_tuber_C.Rds")
saveRDS(pls_tuber_S, "models/training/tuber/pls_tuber_S.Rds")
saveRDS(pls_tuber_P, "models/training/tuber/pls_tuber_P.Rds")
saveRDS(pls_tuber_K, "models/training/tuber/pls_tuber_K.Rds")
saveRDS(pls_tuber_Ca, "models/training/tuber/pls_tuber_Ca.Rds")
saveRDS(pls_tuber_Mg, "models/training/tuber/pls_tuber_Mg.Rds")
saveRDS(pls_tuber_Fe, "models/training/tuber/pls_tuber_Fe.Rds")
saveRDS(pls_tuber_Zn, "models/training/tuber/pls_tuber_Zn.Rds")
saveRDS(pls_tuber_Cu, "models/training/tuber/pls_tuber_Cu.Rds")


