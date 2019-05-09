################################################################################
## Author: Philipp Baumann (philipp.baumann@usys.ethz.ch)
## License: GPL-2.0
## Project: Biophysical, institutional and economic drivers of sustainable 
##   soil use in yam systems for improved food security in West Africa (YAMSYS)
## Description: Aggregate chemical reference analysis data prior to
##   developing spectroscopic reference models for yam elemental content
##   determination
################################################################################

## Load all plant element data =================================================

elements_yam_leaf <- read_csv("data/training/elements/leaf_elements.csv")
elements_yam_tuber  <- read_csv("data/training/elements/tuber_elements.csv")
