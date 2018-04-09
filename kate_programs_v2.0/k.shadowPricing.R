#k.shadowPricing.R

#fixed convergence criteria
maxPRMSE     <- 0.05
maxInfPRMSE  <- 0.1
spDampenInit <- 0.8
spDampen     <- 0.4

loglotShadowPricingFileName <- paste(project.dir, 'logs/lotSPTrace.log', sep='/')

if(doShadowPricing){

  #write current iteration
  load(paste(project.dir, "model/lottaz.RData", sep="/"))
  lottazFileName = paste(project.dir, "/model/lottaz_", spIter, ".csv", sep="")
  write.csv(lottaz, lottazFileName, row.names=F)

  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  lots_inf = readXLSXmatrix(proj.inputs,"lots_inf",lotsmtx=T)
  lottazinf_all_lots <- lots_inf
  for (i in 1:nrow(lottazinf)) {
    lottazinf_all_lots$TAZ[lottazinf$TAZ[i]] <- lottazinf$TAZ[i]
    lottazinf_all_lots[lottazinf$TAZ[i],] <- lottazinf[i,]
  }
  lottazinfFileName = paste(project.dir, "/model/lottazinf_", spIter, ".csv", sep="")
  write.csv(lottazinf_all_lots, lottazinfFileName, row.names=F)

  #do shadow pricing so calculate convergence measures
  spPRMSE = calcLotPRMSE(spIter)
  spInfPRMSE = calcInfLotPRMSE(spIter)
  anyLotDiff = calcLotDiffTarget()

  cat(paste("spIter: ", spIter, "\n"), file=loglotShadowPricingFileName, append=T)
  cat(paste("spPRMSE: ", spPRMSE, "\n"), file=loglotShadowPricingFileName, append=T)
  cat(paste("spInfPRMSE: ", spInfPRMSE, "\n"), file=loglotShadowPricingFileName, append=T)
  cat(paste("anyLotDiff: ", anyLotDiff, "\n"), file=loglotShadowPricingFileName, append=T)

} else {

  #do not do shadow pricing iteration so set all criteria to converged
  spIter     <- 9999
  spPRMSE    <- 0
  spInfPRMSE <- 0
  anyLotDiff <- FALSE
}

#check convergence and break if needed
if(spIter < maxSPIter) {

  if(((spPRMSE < maxPRMSE) | !anyLotDiff) & (spInfPRMSE < maxInfPRMSE)) {

    break

  } else {

    #update pnr lot shadow pricing
    updateLotShadowPrice(spIter)

    #reset volumes to run another SP iteration
    resetLotVolumes()
    resetSelectLotMatrix("hbw")
    resetTLTDMatrices()

    spIter = spIter + 1

  }

} else {

  break
}