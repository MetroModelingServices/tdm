# k.hbspnrSkims.R
# HBS Auto and Transit Composite Park & Ride Skims

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
  mf.Spocketcost <- HBS.pkfact*mf.amstlD + HBS.opfact*mf.mdstlD
  rm(mf.amstlTadj,mf.amstlD,mf.mdstlTadj,mf.mdstlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBS.low.cc
    pktc   <- HBS.low.pktc
    faresc <- HBS.low.faresc
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBS.medium.cc
    pktc   <- HBS.medium.pktc
    faresc <- HBS.medium.faresc
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBS.high.cc
    pktc   <- HBS.high.pktc
    faresc <- HBS.high.faresc
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

    # Base HBS Drive Alone Utility (no parking charge or walk time)
    mf.auto <- PNR.autoWeight * HBS.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + cc * mf.Sopcost + pktc * mf.Spocketcost
    mf.PNRauto <- HBS.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + cc * mf.Sopcost + pktc * mf.Spocketcost

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

    # Base HBS Transit Utility (no constant)
    ivt  <- HBS.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    oviv <- HBS.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.transit <- (ivt + HBS.tr.wait1Coeff * mf.trwait1 + HBS.tr.wait2Coeff * mf.trwait2 + HBS.tr.walkCoeff * mf.trwalk + HBS.tr.transCoeff * mf.transfers +
             sweep(faresc * mf.trfare, 2, HBS.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") +
             sweep(oviv, 1, HBS.tr.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.transit[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- -9999

    #trace OD
    if(!is.na(lotChoiceTraceOD[1])) {
      cat(paste("\n", "hbs pnr skims", "inc=", inc, "timeper=", timeper, "\n"), file=loglotChoiceFileName, append=T)
      cat(paste("\n", "HBS.ivCoeff=", HBS.ivCoeff, "\n"), file=loglotChoiceFileName, append=T) 
        
      matNames = c("mf.tdist","mf.Sopcost",paste("mf.",timeper,"stt",sep=''),"mf.auto","mf.PNRauto",
        "ivt","mf.trbivt","mf.trlivt","mf.trrivt","mf.trscivt","mf.trbrivt",
        "mf.trwait1","mf.trwait2","mf.trwalk","mf.transfers","mf.transit")
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],matNames,loglotChoiceFileName)
    }
    
    #setup to lot and to destination trip matrix - will be calculated in mode split
    mf.hbsslmat = mf.hbsprtrtl = mf.hbsprtrtd = matrix(0, nrow(mf.auto), nrow(mf.auto))
#    if (file.access("mf.hbsprtrtl.RData", mode=0) != 0) { save(mf.hbsprtrtl, file="mf.hbsprtrtl.RData") }
#    if (file.access("mf.hbsprtrtd.RData", mode=0) != 0) { save(mf.hbsprtrtd, file="mf.hbsprtrtd.RData") }
#    if (file.access("mf.hbsslmat.RData", mode=0) != 0) { save(mf.hbsslmat, file="mf.hbsslmat.RData") }
    save(mf.hbsprtrtl, file="mf.hbsprtrtl.RData")
    save(mf.hbsprtrtd, file="mf.hbsprtrtd.RData")
    save(mf.hbsslmat, file="mf.hbsslmat.RData")

    #save auto and transit for later use
    save(mf.auto, file=paste("mf.auto.hbs.", timeper, ".", inc, ".RData", sep=""))
    save(mf.PNRauto, file=paste("mf.PNRauto.hbs.", timeper, ".", inc, ".RData", sep=""))
    save(mf.transit, file=paste("mf.transit.hbs.", timeper, ".", inc, ".RData", sep=""))

  }
  
}
