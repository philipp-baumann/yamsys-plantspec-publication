Mid-infrared spectroscopy to diagnose Yam (*Diascorea* sp.) mineral nutrients
================

Project structure
=================

The file structure is as follows:

    ## /media/ssd/nas-ethz/doktorat/projects/01_spectroscopy/23_yamsys-plantspec-publication
    ## ├── 10_compile-ref-data.R
    ## ├── 20_summarize-ref-data.R
    ## ├── 23_yamsys-plantspec-publication.Rproj
    ## ├── 30_read-process-spc-train.R
    ## ├── 40_build-spc-models-tuber-train.R
    ## ├── 50_read-process-spc-test.R
    ## ├── 60_explore-spc-training-test.R
    ## ├── 70_evaluate-test.R
    ## ├── 90_model-test-train-fusion.R
    ## ├── README.Rmd
    ## ├── README.md
    ## ├── data
    ## │   ├── test
    ## │   │   └── tuber
    ## │   │       ├── elements
    ## │   │       ├── sampling
    ## │   │       └── spectra
    ## │   ├── test_beatrice
    ## │   │   ├── tuber_85_test.0
    ## │   │   └── tuber_85_test.1
    ## │   └── training
    ## │       ├── elements
    ## │       │   ├── leaf_elements.csv
    ## │       │   ├── raw
    ## │       │   └── tuber_elements.csv
    ## │       ├── sampling
    ## │       │   ├── data_field_lo.csv
    ## │       │   ├── data_field_mo.csv
    ## │       │   ├── data_field_sb.csv
    ## │       │   ├── data_field_tb.csv
    ## │       │   └── metadata-field-yamsys.csv
    ## │       └── spectra
    ## │           ├── leaf
    ## │           └── tuber
    ## ├── gpl.md
    ## ├── models
    ## │   └── training
    ## │       ├── leaf
    ## │       └── tuber
    ## │           ├── pls_tuber_C.Rds
    ## │           ├── pls_tuber_Ca.Rds
    ## │           ├── pls_tuber_Cu.Rds
    ## │           ├── pls_tuber_Fe.Rds
    ## │           ├── pls_tuber_K.Rds
    ## │           ├── pls_tuber_Mg.Rds
    ## │           ├── pls_tuber_N.Rds
    ## │           ├── pls_tuber_P.Rds
    ## │           ├── pls_tuber_S.Rds
    ## │           └── pls_tuber_Zn.Rds
    ## └── out
    ##     └── figs
    ##         ├── model-eval-yam-tuber-all.pdf
    ##         └── spc-train-test-expl.pdf
