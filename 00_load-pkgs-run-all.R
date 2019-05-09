################################################################################
## 
################################################################################

## Install and attach packages
pkgs <- c("drake", "here", "tidyverse", "simplerspec", "future", "doFuture")

new_pkgs <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]

# Install only new packages
if (length(new_pkgs)) {
  if ("devtools" %in% new_pkgs) install.packages("devtools")
  if ("simplerspec" %in% new_pkgs) {
    devtools::install_github("philipp-baumann/simplerspec")}
  install.packages(new_pkgs)
}

# Load packges
purrr::iwalk(pkgs, library, character.only = TRUE)