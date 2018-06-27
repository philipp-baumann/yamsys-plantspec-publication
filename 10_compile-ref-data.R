################################################################################
## Author: Philipp Baumann (philipp.baumann@usys.ethz.ch)
## License: GPL-2.0
## Project: Biophysical, institutional and economic drivers of sustainable 
##   soil use in yam systems for improved food security in West Africa (YAMSYS)
## Description: Aggregate chemical reference analysis data prior to
##   developing spectroscopic reference models for yam elemental content
##   determination
################################################################################

## Install all necessary R packages
## install.packages("devtools", type = "source")
## devtools::install_github("philipp-baumann/simplerspec")

## Load packages
pkgs <- c("tidyverse", "simplerspec")
lapply(pkgs, library, character.only = TRUE)

## Load all plant element data =================================================


elements_yam_leaf <- read_csv("data/elements/leaf_elements.csv")
elements_yam_tuber  <- read_csv("data/elements/tuber_elements.csv")

