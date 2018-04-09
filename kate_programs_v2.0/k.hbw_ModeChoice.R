#k.hbw_ModeChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

#shadow pricing convergence criteria
spIter     <- 0
spPRMSE    <- 1
spInfPRMSE <- 1
anyLotDiff <- TRUE

purpose_mc <- "hw"
stage      <- "ModeChoice"
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

#start shadow pricing loop
repeat {
  source(paste(R.path, "k.hbwms.R", sep='/'))
  source(paste(R.path, "k.shadowPricing.R", sep='/'))
}

source(paste(R.path, "k.ms_markets_sum.R", sep='/'))

finalLotShadowPrice()

if (finalCleanup==TRUE) {
  source(paste(R.path, "k.finalCleanup.R", sep='/'))
}
