# Based on https://github.com/hadley/testthat#integration-with-r-cmd-check 
# which is the limit on travis CI. 
library(testthat)
library(codonR)
test_check("codonR")
