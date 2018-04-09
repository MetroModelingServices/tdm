# k.hbopnrSkims.R
# HBO Auto and Transit Composite Park & Ride Skims

# Drive Alone Operating Cost
mf.Sopcost     <- autocost * mf.tdist
mf.Spocketcost <- mf.Sopcost * 0

if (toll == TRUE)
{
  print("About to calculate toll costs")
  
  # Adjust Toll Time to reflect difference in elasticity between assignment and model (.75)

  mf.amstlTadj <- mf.amstl*(1.125)*(.75)
  mf.mdstlTadj <- mf.mdstl*(1.25)*(.75)
  
  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot
  
  # Add Tolls
  mf.Spocketcost <- HBO.pkfact*mf.amstlD + HBO.opfact*mf.mdstlD
  rm(mf.amstlTadj,mf.amstlD,mf.mdstlTadj,mf.mdstlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBO.low.cc
    pktc   <- HBO.low.pktc
    faresc <- HBO.low.faresc
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBO.medium.cc
    pktc   <- HBO.medium.pktc
    faresc <- HBO.medium.faresc
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBO.high.cc
    pktc   <- HBO.high.pktc
    faresc <- HBO.high.faresc
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      timeper <- "am"
    }
    if (y==2) {
      timeper <- "md"
    }

    ### AUTO ####

    # Base HBO Drive Alone Utility (no parking charge or walk time)
    mf.auto <- PNR.autoWeight * HBO.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + cc * mf.Sopcost + pktc * mf.Spocketcost
    mf.PNRauto <- HBO.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + cc * mf.Sopcost + pktc * mf.Spocketcost

    ### TRANSIT ####

    # Transit In-Vehicle Time
    mf.trbivt <- get(paste("mf.", timeper, "tbiv", sep=''))
    mf.trlivt <- get(paste("mf.", timeper, "tliv", sep=''))
    mf.trrivt <- get(paste("mf.", timeper, "triv", sep=''))
    mf.trscivt <- get(paste("mf.", timeper, "tsciv", sep=''))
    mf.trbrivt <- get(paste("mf.", timeper, "tbriv", sep=''))
    
    # Transit Initial Wait Time (cap at 30 min)
    mf.trwait1 <- get(paste("mf.", timeper, "twt1", sep=''))
    mf.trwait1[mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30

		# Transit Transfer Wait Time (cap at 30 min)
    mf.trwait2 <- get(paste("mf.", timeper, "twt2", sep=''))
    mf.trwait2[mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    
    # Transit Walk Time (cap at 30 min)
    mf.trwalk <- get(paste("mf.", timeper, "twalk", sep=''))
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    
    # Transit Transfer Boardings
    mf.transfers <- get(paste("mf.", timeper, "txfr", sep=''))

    # Base HBO Transit Utility (no constant)
    ivt  <- HBO.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    oviv <- HBO.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.transit <- (ivt + HBO.tr.wait1Coeff * mf.trwait1 + HBO.tr.wait2Coeff * mf.trwait2 + HBO.tr.walkCoeff * mf.trwalk + HBO.tr.transCoeff * mf.transfers +
             sweep(faresc * mf.trfare, 2, HBO.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") +
             sweep(oviv, 1, HBO.tr.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.transit[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- -9999

    #trace OD
    if(!is.na(lotChoiceTraceOD[1])) {
      cat(paste("\n", "hbo pnr skims", "inc=", inc, "timeper=", timeper, "\n"), file=loglotChoiceFileName, append=T)
      cat(paste("\n", "HBO.ivCoeff=", HBO.ivCoeff, "\n"), file=loglotChoiceFileName, append=T) 
        
      matNames = c("mf.tdist","mf.Sopcost",paste("mf.",timeper,"stt",sep=''),"mf.auto","mf.PNRauto",
        "ivt","mf.trbivt","mf.trlivt","mf.trrivt","mf.trscivt","mf.trbrivt",
        "mf.trwait1","mf.trwait2","mf.trwalk","mf.transfers","mf.transit")
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],matNames,loglotChoiceFileName)
    }
    
    #setup to lot and to destination trip matrix - will be calculated in mode split
    mf.hboslmat = mf.hboprtrtl = mf.hboprtrtd = matrix(0, nrow(mf.auto), nrow(mf.auto))
#    if (file.access("mf.hboprtrtl.RData", mode=0) != 0) { save(mf.hboprtrtl, file="mf.hboprtrtl.RData") }
#    if (file.access("mf.hboprtrtd.RData", mode=0) != 0) { save(mf.hboprtrtd, file="mf.hboprtrtd.RData") }
#    if (file.access("mf.hboslmat.RData", mode=0) != 0) { save(mf.hboslmat, file="mf.hboslmat.RData") }
    save(mf.hboprtrtl, file="mf.hboprtrtl.RData")
    save(mf.hboprtrtd, file="mf.hboprtrtd.RData")
    save(mf.hboslmat, file="mf.hboslmat.RData")

    #save auto and transit for later use
    save(mf.auto, file=paste("mf.auto.hbo.", timeper, ".", inc, ".RData", sep=""))
    save(mf.PNRauto, file=paste("mf.PNRauto.hbo.", timeper, ".", inc, ".RData", sep=""))
    save(mf.transit, file=paste("mf.transit.hbo.", timeper, ".", inc, ".RData", sep=""))

  }
  
}
