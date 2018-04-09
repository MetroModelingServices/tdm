#k.hbr_ModeChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

purpose_mc <- "hr"
stage      <- "ModeChoice"
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hbrms.R", sep='/'))
source(paste(R.path, "k.ms_markets_sum.R", sep='/'))

if (finalCleanup==TRUE) {
  source(paste(R.path, "k.finalCleanup.R", sep='/'))
}
