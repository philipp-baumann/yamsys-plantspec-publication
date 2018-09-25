

## Plot training and test spectra ==============================================

pdf(file = "out/figs/spc-train-test-expl.pdf", width = 5, height = 5)
plot_spc_ext(
  spc_tbl_l = list(
    "Training set" = spc_tuber_train %>%
      mutate(group_id = "Comparison test and training spectra"), 
    "Test set" = spc_tuber_test %>%
      mutate(group_id = "Comparison test and training spectra")),
  lcols_spc = c("spc", "spc_pre"), group_id = "group_id")
dev.off()