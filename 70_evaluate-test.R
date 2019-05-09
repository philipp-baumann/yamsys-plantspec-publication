################################################################################
## Evaluate the the Yam tuber testing set based on the training models
################################################################################


## Read test reference tuber element data (ICP-OES) ============================

elements_yam_tuber_test <- read_csv(
  "data/test/tuber/elements/tuber_elements_test.csv")

## Read the yam tuber training models ==========================================

pls_tuber_N <- readRDS(file = "models/training/tuber/pls_tuber_N.Rds")
pls_tuber_C <- readRDS(file = "models/training/tuber/pls_tuber_C.Rds")
pls_tuber_S <- readRDS(file = "models/training/tuber/pls_tuber_S.Rds")
pls_tuber_P <- readRDS(file = "models/training/tuber/pls_tuber_P.Rds")
pls_tuber_K <- readRDS(file = "models/training/tuber/pls_tuber_K.Rds")
pls_tuber_Ca <- readRDS(file = "models/training/tuber/pls_tuber_Ca.Rds")
pls_tuber_Mg <- readRDS(file = "models/training/tuber/pls_tuber_Mg.Rds")
pls_tuber_Fe <- readRDS(file = "models/training/tuber/pls_tuber_Fe.Rds")
pls_tuber_Zn <- readRDS(file = "models/training/tuber/pls_tuber_Zn.Rds")
pls_tuber_Cu <- readRDS(file = "models/training/tuber/pls_tuber_Cu.Rds")

# Nest all models in a list for prediction
pls_tuber_all <- list(
  "pls_tuber_N" = pls_tuber_N,
  "pls_tuber_C" = pls_tuber_C,
  "pls_tuber_S" = pls_tuber_S,
  "pls_tuber_P" = pls_tuber_P,
  "pls_tuber_K" = pls_tuber_K,
  "pls_tuber_Ca" = pls_tuber_Ca,
  "pls_tuber_Mg" = pls_tuber_Mg,
  "pls_tuber_Fe" = pls_tuber_Fe,
  "pls_tuber_Zn" = pls_tuber_Zn,
  "pls_tuber_Cu" = pls_tuber_Cu
)

## Predict tuber nutrients based on training model and new spectra =============

pred_tuber_test <- predict_from_spc(
  model_list = pls_tuber_all, 
  spc_tbl = spc_tuber_test
  )

# Join test set predictions and test reference data
predobs_tuber_test <- inner_join(x = pred_tuber_test,
  y = elements_yam_tuber_test)


################################################################################

plot_spc_ext(spc_tbl_l = 
  list("Training ref." = spc_tbl_tuber %>% mutate(group_id = "Test"), 
       "Beatrice test" = spc_tuber_beatrice %>% mutate(group_id = "Test")),
  lcols_spc = c("spc","spc_pre"),
  group_id = "group_id")