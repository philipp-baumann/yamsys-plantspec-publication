spc_elements_tuber_test <- spc_tuber_test %>%
  inner_join(x = ., y = elements_yam_tuber_test)


spc_elements_tuber_all <- spc_elements_tuber %>%
  select(sample_id, spc_pre, C, N, P, K, Ca, Mg, Fe, Zn, Cu) %>%
  bind_rows(spc_elements_tuber_test %>% 
    select(sample_id, spc_pre, C, N, P, K, Ca, Mg, Fe, Zn, Cu))


pls_tuber_N_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$N), ],
  response = N,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

pls_tuber_C_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$C) &
    spc_elements_tuber_all$C < 800 & spc_elements_tuber_all$C > 383, ],
  response = C,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total P
# Remove outlier at > 4000 mg P / kg
pls_tuber_P_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$P) & 
    spc_elements_tuber_all$P < 4000, ],
  response = P,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total K
pls_tuber_K_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$K), ],
  response = K,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Ca
# Remove outlier at > 2000 mg Ca / kg
pls_tuber_Ca_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$Ca) &
    spc_elements_tuber_all$Ca < 2000, ],
  response = Ca,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Mg
# Remove outlier at > 3000 mg Mg / kg
pls_tuber_Mg_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$Mg) &
    spc_elements_tuber_all$Mg < 3000, ],
  response = Mg,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Fe
# Remove outliers at > 150 mg Fe / kg
pls_tuber_Fe_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$Fe) &
    spc_elements_tuber_all$Fe < 150, ],
  response = Fe,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Zn
# Remove outliers at > 75mg Zn / kg
pls_tuber_Zn_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$Zn) &
    spc_elements_tuber_all$Zn < 75, ],
  response = Zn,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)

# Total Cu
pls_tuber_Cu_all <- fit_pls(
  spec_chem = spc_elements_tuber_all[!is.na(spc_elements_tuber_all$Cu), ],
  response = Cu,
  evaluation_method = "resampling",
  tuning_method = "resampling",
  resampling_method = "rep_kfold_cv",
  pls_ncomp_max = 10
)


pdf(file = "out/figs/model-eval-yam-tuber-all.pdf", width = 10, height = 15)
cowplot::plot_grid(pls_tuber_C_all$p_model, pls_tuber_N_all$p_model,
  pls_tuber_P_all$p_model, pls_tuber_K_all$p_model, pls_tuber_Ca_all$p_model,
  pls_tuber_Mg_all$p_model, pls_tuber_Zn_all$p_model, pls_tuber_Cu_all$p_model,
  ncol = 2)
dev.off()

