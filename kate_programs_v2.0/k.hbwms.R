# k.hbwms.R
# HBW Mode Choice

print("Running hbw mode choice")

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.hbwdtl.dat")
load("mf.hbwdtm.dat")
load("mf.hbwdth.dat")
load("malist.hbw.dat")
attach(malist.hbw)

# Auto Operating Cost
mf.Sopcost <- autocost * mf.tdist
mf.Hopcost <- mf.Sopcost

# Auto Out of Pocket Cost
mf.Spocketcost <- sweep((mf.Sopcost * 0), 2, 0.5 * ma.ltpkg, "+")
mf.Hpocketcost <- sweep((mf.Hopcost * 0), 2, 0.5 * ma.ltpkg, "+")

if (toll == TRUE)
{
  print("About to calculate toll costs")

  # Adjust Toll Time to reflect difference in elasticity between assignment and model (.75)

  mf.amstlTadj <- mf.amstl*(.75)
  mf.mdstlTadj <- mf.mdstl*(.75)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(.75)
  mf.mdhtlTadj <- mf.mdhtl*(.75)

  mf.amhtlD <- (mf.amhtlTadj/60)*pkvot
  mf.mdhtlD <- (mf.mdhtlTadj/60)*opvot

  # Add Tolls
  mf.Spocketcost <- sweep((HBW.pkfact*mf.amstlD + HBW.opfact*mf.mdstlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBW.pkfact*mf.amhtlD + HBW.opfact*mf.mdhtlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBW.low.cc     # auto operating costs coeff
    pktc   <- HBW.low.pktc   # auto out of pocket costs: parking and tolls coeff
    faresc <- HBW.low.faresc # transit fares coeff
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBW.medium.cc      # auto operating costs coeff
    pktc   <- HBW.medium.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBW.medium.faresc  # transit fares coeff
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBW.high.cc      # auto operating costs coeff
    pktc   <- HBW.high.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBW.high.faresc  # transit fares coeff
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact   <- HBW.pkfact
      timeper   <- "am"
      ma.hhcov  <- ma.pkhhcov
      ma.empcov <- ma.pkempcov 
    }
    if (y==2) {
      todfact   <- HBW.opfact
      timeper   <- "md"
      ma.hhcov  <- ma.ophhcov
      ma.empcov <- ma.opempcov 
    }

### HBW Drive Alone Utilities

# Base HBW Drive Alone Utility
    mf.base <- (HBW.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + sweep(cc * mf.Sopcost, 2, HBW.da.walkCoeff * ma.auov, "+") + pktc * mf.Spocketcost)
    
# HBW Drive Alone Utility cv0 (Cars = 0)
    mf.dautil.cv0 <- exp(mf.base + HBW.da.cv0)

# HBW Drive Alone Utility cv1 (Cars < Workers)
    mf.dautil.cv1 <- exp(mf.base + HBW.da.cv1)

# HBW Drive Alone Utility cv2 & cv3 (Cars >= Workers)
    mf.dautil.cv23 <- exp(mf.base + HBW.da.cv23)

### HBW Drive with Passenger Utilities

# Base HBW Drive with Passenger Utility
    mf.base <- (HBW.MC.dpconst + HBW.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBW.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBW.dp.walkCoeff * ma.auov, "+"))

# 1 Person Household HBW Drive with Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.dputil.hh1.cv0 <- exp(mf.base + HBW.dp.hh1 + HBW.dp.cv0)

# 1 Person Household HBW Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh1.cv1 <- exp(mf.base + HBW.dp.hh1 + HBW.dp.cv1)

# 1 Person Household HBW Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh1.cv23 <- exp(mf.base + HBW.dp.hh1 + HBW.dp.cv23)

# 2 Person Household HBW Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh2.cv0 <- exp(mf.base + HBW.dp.hh2 + HBW.dp.cv0)

# 2 Person Household HBW Drive with Passenger Utility cv1 (Cars < Workers) *** NEW ***
    mf.dputil.hh2.cv1 <- exp(mf.base + HBW.dp.hh2 + HBW.dp.cv1)
    
# 2 Person Household HBW Drive with Passenger Utility cv2 & cv3 (Cars >= Workers) *** NEW *** 
    mf.dputil.hh2.cv23 <- exp(mf.base + HBW.dp.hh2 + HBW.dp.cv23)

# 3+ Person Household HBW Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh34.cv0 <- exp(mf.base + HBW.dp.hh34 + HBW.dp.cv0)

# 3+ Person Household HBW Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh34.cv1 <- exp(mf.base + HBW.dp.hh34 + HBW.dp.cv1)

# 3+ Person Household HBW Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh34.cv23 <- exp(mf.base + HBW.dp.hh34 + HBW.dp.cv23)


### HBW Passenger Utilities

# Base HBW Passenger Utility
    mf.base <- (HBW.MC.paconst + HBW.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBW.pa.autoCostFac * (cc * mf.Hopcost), 2, HBW.pa.walkCoeff * ma.auov + HBW.pa.logMixTotACoeff * log(ma.mixthm + 1), "+") +
          sweep(HBW.pa.autoCostFac * (pktc * mf.Hpocketcost), 1, HBW.pa.logMixRetPCoeff * log(ma.mixthm + 1), "+"))

# 1 Person Household HBW Passenger Utility *** NEW ***
    mf.pautil.hh1 <- exp(mf.base + HBW.pa.hh1)

# 2 Person Household HBW Passenger Utility *** NEW ***
    mf.pautil.hh2 <- exp(mf.base + HBW.pa.hh2)

# 3+ Person Household HBW Passenger Utility *** NEW ***
    mf.pautil.hh34 <- exp(mf.base + HBW.pa.hh34)

### HBW Transit Utilities

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

# Transit Composite Constants
    mf.trvehc <- get(paste("mf.", timeper, "tvehc", sep=''))
    mf.trstpc <- get(paste("mf.", timeper, "tstpc", sep=''))

# Base HBW Transit Utility
    ivt     <- HBW.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- HBW.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- HBW.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.base <- (trconst + ivt + HBW.tr.wait1Coeff * mf.trwait1 + HBW.tr.wait2Coeff * mf.trwait2 + HBW.tr.walkCoeff * mf.trwalk  + HBW.tr.transCoeff * mf.transfers +
          sweep(faresc * mf.trfare, 2, HBW.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") + oviv)
    mf.base[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Single Worker HBW Transit Utility cv0 (Cars=0)
    mf.trutil.sw.cv0 <- exp(mf.base + HBW.tr.sw + HBW.tr.cv0) 
    mf.trutil.sw.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Single Worker HBW Transit Utility cv1 (Cars < Workers)
    mf.trutil.sw.cv1 <- exp(mf.base + HBW.tr.sw + HBW.tr.cv1)
    mf.trutil.sw.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Single Worker HBW Transit Utility cv23 (Cars >= Workers)
    mf.trutil.sw.cv23 <- exp(mf.base + HBW.tr.sw + HBW.tr.cv23) 
    mf.trutil.sw.cv23[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Multi Worker HBW Transit Utility cv0 (Cars=0)
    mf.trutil.mw.cv0 <- exp(mf.base + HBW.tr.mw + HBW.tr.cv0)
    mf.trutil.mw.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Multi Worker HBW Transit Utility cv1 (Car < Workers)
    mf.trutil.mw.cv1 <- exp(mf.base + HBW.tr.mw + HBW.tr.cv1)
    mf.trutil.mw.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# Multi Worker HBW Transit Utility cv23 (Cars >= Workers)
    mf.trutil.mw.cv23 <- exp(mf.base + HBW.tr.mw + HBW.tr.cv23)
    mf.trutil.mw.cv23[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0
    
### HBW Park and Ride Transit Utilities

    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbw"
    paramSet$cv <- "" 
    paramSet$cvConstant <- PNR.cvConstant 
    #constants
    paramSet$formalConstant <- HBW.formalConstant
    paramSet$informalConstant <- HBW.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff

    #HBW Park and Ride Transit Utility cv1 (Cars < Workers)
    paramSet$cv <- "cv1"
    paramSet$cvConstant <- HBW.cv1Constant
    mf.prtutil.cv1 <- calcPNRUtils(timeper, inc, project.dir, HBW.MC.prconst, 1, numzones, paramSet)

    #HBW Park and Ride Transit Utility cv2 & cv3 (Cars >= Workers)
    paramSet$cv <- "cv23"
    paramSet$cvConstant <- PNR.cvConstant
    mf.prtutil.cv23 <- calcPNRUtils(timeper, inc, project.dir, HBW.MC.prconst, 1, numzones, paramSet)


### HBW Bike Utility
    mf.bkutil <- exp(sweep(HBW.MC.bikeconst + HBW.bk.inbikeCoeff * mf.inbike + HBW.bk.ubdistCoeff * mf.ubdist + HBW.bk.cbcostCoeff * mf.cbcost, 2, HBW.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


### HBW Walk Utility
    mf.wkutil <- exp(sweep(HBW.MC.walkconst + HBW.wk.walkCoeff * mf.wtime, 1, HBW.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


##### Compute Total Utilities and Save in Temporary Matrices 

print("Calculating total utilities")

# HBW Utility - 1 Person HH, Single Worker, CV0, w/o Tran or PR
    mf.ut.hh1.sw.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh1.cv0 + mf.pautil.hh1 + mf.bkutil + mf.wkutil)

# HBW Utility - 1 Person HH, Single Worker, CV0, all modes
    mf.ut.hh1.sw.cv0.withtr <- (mf.ut.hh1.sw.cv0.notr + mf.trutil.sw.cv0)

# HBW Utility - 1 Person HH, Single Worker, CV1, w/o Tran or PR
    mf.ut.hh1.sw.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh1.cv1 + mf.pautil.hh1 + mf.bkutil + mf.wkutil)

# HBW Utility - 1 Person HH, Single Worker, CV1, all modes
    mf.ut.hh1.sw.cv1.all <- (mf.ut.hh1.sw.cv1.notrpr + mf.prtutil.cv1 + mf.trutil.sw.cv1)

# HBW Utility - 1 Person HH, Single Worker, CV1, w/o Tran
    mf.ut.hh1.sw.cv1.notr <- (mf.ut.hh1.sw.cv1.notrpr + mf.prtutil.cv1)

# HBW Utility - 1 Person HH, Single Worker, CV23, w/o Tran or PR
    mf.ut.hh1.sw.cv23.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1 + mf.bkutil + mf.wkutil)

# HBW Utility - 1 Person HH, Single Worker, CV23, all modes
    mf.ut.hh1.sw.cv23.all <- (mf.ut.hh1.sw.cv23.notrpr + mf.prtutil.cv23 + mf.trutil.sw.cv23)

# HBW Utility - 1 Person HH, Single Worker, CV23, w/o Tran
    mf.ut.hh1.sw.cv23.notr <- (mf.ut.hh1.sw.cv23.notrpr + mf.prtutil.cv23)

# HBW Utility - 2 Person HH, Single Worker, CV0, w/o Tran or PR
    mf.ut.hh2.sw.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh2.cv0 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Single Worker, CV0, all modes
    mf.ut.hh2.sw.cv0.withtr <- (mf.ut.hh2.sw.cv0.notr + mf.trutil.sw.cv0)

# HBW Utility - 2 Person HH, Single Worker, CV1, w/o Tran or PR
    mf.ut.hh2.sw.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh2.cv1 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Single Worker, CV1, all modes
    mf.ut.hh2.sw.cv1.all <- (mf.ut.hh2.sw.cv1.notrpr + mf.prtutil.cv1 + mf.trutil.sw.cv1)

# HBW Utility - 2 Person HH, Single Worker, CV1, w/o Tran
    mf.ut.hh2.sw.cv1.notr <- (mf.ut.hh2.sw.cv1.notrpr + mf.prtutil.cv1)

# HBW Utility - 2 Person HH, Single Worker, CV23, w/o Tran or PR
    mf.ut.hh2.sw.cv23.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Single Worker, CV23, all modes
    mf.ut.hh2.sw.cv23.all <- (mf.ut.hh2.sw.cv23.notrpr + mf.prtutil.cv23 + mf.trutil.sw.cv23)

# HBW Utility - 2 Person HH, Single Worker, CV23, w/o Tran
    mf.ut.hh2.sw.cv23.notr <- (mf.ut.hh2.sw.cv23.notrpr + mf.prtutil.cv23)

# HBW Utility - 3+ Person HH, Single Worker, CV0, w/o Tran or PR
    mf.ut.hh34.sw.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh34.cv0 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Single Worker, CV0, all modes
    mf.ut.hh34.sw.cv0.withtr <- (mf.ut.hh34.sw.cv0.notr + mf.trutil.sw.cv0)
  
# HBW Utility - 3+ Person HH, Single Worker, CV1, w/o Tran or PR
    mf.ut.hh34.sw.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh34.cv1 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Single Worker, CV1, all modes
    mf.ut.hh34.sw.cv1.all <- (mf.ut.hh34.sw.cv1.notrpr + mf.prtutil.cv1 + mf.trutil.sw.cv1)

# HBW Utility - 3+ Person HH, Single Worker, CV1, w/o Tran
    mf.ut.hh34.sw.cv1.notr <- (mf.ut.hh34.sw.cv1.notrpr + mf.prtutil.cv1)

# HBW Utility - 3+ Person HH, Single Worker, CV23, w/o Tran or PR
    mf.ut.hh34.sw.cv23.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Single Worker, CV23, all modes
    mf.ut.hh34.sw.cv23.all <- (mf.ut.hh34.sw.cv23.notrpr + mf.prtutil.cv23 + mf.trutil.sw.cv23)

# HBW Utility - 3+ Person HH, Single Worker, CV23, w/o Tran
    mf.ut.hh34.sw.cv23.notr <- (mf.ut.hh34.sw.cv23.notrpr + mf.prtutil.cv23)

# HBW Utility - 2 Person HH, Multiple Worker, CV0, w/o Tran or PR
    mf.ut.hh2.mw.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh2.cv0 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Multiple Worker, CV0, all modes
    mf.ut.hh2.mw.cv0.withtr <- (mf.ut.hh2.mw.cv0.notr + mf.trutil.mw.cv0)

# HBW Utility - 2 Person HH, Multiple Worker, CV1, w/o Tran or PR
    mf.ut.hh2.mw.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh2.cv1 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Multiple Worker, CV1, all modes
    mf.ut.hh2.mw.cv1.all <- (mf.ut.hh2.mw.cv1.notrpr + mf.prtutil.cv1 + mf.trutil.mw.cv1)

# HBW Utility - 2 Person HH, Multiple Worker, CV1, w/o Tran
    mf.ut.hh2.mw.cv1.notr <- (mf.ut.hh2.mw.cv1.notrpr + mf.prtutil.cv1)

# HBW Utility - 2 Person HH, Multiple Worker, CV23, w/o Tran or PR
    mf.ut.hh2.mw.cv23.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2 + mf.bkutil + mf.wkutil)

# HBW Utility - 2 Person HH, Multiple Worker, CV23, all modes
    mf.ut.hh2.mw.cv23.all <- (mf.ut.hh2.mw.cv23.notrpr + mf.prtutil.cv23 + mf.trutil.mw.cv23)

# HBW Utility - 2 Person HH, Multiple Worker, CV23, w/o Tran
    mf.ut.hh2.mw.cv23.notr <- (mf.ut.hh2.mw.cv23.notrpr + mf.prtutil.cv23)

# HBW Utility - 3+ Person HH, Multiple Worker, CV0, w/o Tran or PR
    mf.ut.hh34.mw.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh34.cv0 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Multiple Worker, CV0, all modes
    mf.ut.hh34.mw.cv0.withtr <- (mf.ut.hh34.mw.cv0.notr + mf.trutil.mw.cv0)
  
# HBW Utility - 3+ Person HH, Multiple Worker, CV1, w/o Tran or PR
    mf.ut.hh34.mw.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh34.cv1 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Multiple Worker, CV1, all modes
    mf.ut.hh34.mw.cv1.all <- (mf.ut.hh34.mw.cv1.notrpr + mf.prtutil.cv1 + mf.trutil.mw.cv1)

# HBW Utility - 3+ Person HH, Multiple Worker, CV1, w/o Tran
    mf.ut.hh34.mw.cv1.notr <- (mf.ut.hh34.mw.cv1.notrpr + mf.prtutil.cv1)

# HBW Utility - 3+ Person HH, Multiple Worker, CV23, w/o Tran or PR
    mf.ut.hh34.mw.cv23.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34 + mf.bkutil + mf.wkutil)

# HBW Utility - 3+ Person HH, Multiple Worker, CV23, all modes
    mf.ut.hh34.mw.cv23.all <- (mf.ut.hh34.mw.cv23.notrpr + mf.prtutil.cv23 + mf.trutil.mw.cv23)

# HBW Utility - 3+ Person HH, Multiple Worker, CV23, w/o Tran
    mf.ut.hh34.mw.cv23.notr <- (mf.ut.hh34.mw.cv23.notrpr + mf.prtutil.cv23)


### Save Utility Permutations in Temporary Matrices

#Coverage Factor Matrices
    mf.hhcov        <- matrix(ma.hhcov, numzones, numzones)
    mf.empcov.full  <- matrix(ma.empcov, numzones, numzones)
    tmf.empcov      <- t(mf.empcov.full)

# Walk to Transit Access Available at Both Ends
    mf.trok <- mf.hhcov * tmf.empcov

# Walk to Transit Access Available at Destination End of Must Drive to Park and Ride Origin
    mf.prok <- (1 - mf.hhcov) * tmf.empcov

# No Walk to Transit Access Available at Destination End
    mf.trno <- 1 - tmf.empcov


# HBW Temporary Utility - 1 Person HH, Single Worker, CV0
    mf.tmput.hh1.sw.cv0 <- (mf.trok / mf.ut.hh1.sw.cv0.withtr + mf.prok / mf.ut.hh1.sw.cv0.notr + mf.trno / mf.ut.hh1.sw.cv0.notr)

# HBW Temporary Utility - 1 Person HH, Single Worker, CV1
    mf.tmput.hh1.sw.cv1 <- (mf.trok / mf.ut.hh1.sw.cv1.all + mf.prok / mf.ut.hh1.sw.cv1.notr + mf.trno / mf.ut.hh1.sw.cv1.notrpr)

# HBW Temporary Utility - 1 Person HH, Single Worker, CV23
    mf.tmput.hh1.sw.cv23 <- (mf.trok / mf.ut.hh1.sw.cv23.all + mf.prok / mf.ut.hh1.sw.cv23.notr + mf.trno / mf.ut.hh1.sw.cv23.notrpr)

# HBW Temporary Utility - 2 Person HH, Single Worker, CV0
    mf.tmput.hh2.sw.cv0 <- (mf.trok / mf.ut.hh2.sw.cv0.withtr + mf.prok / mf.ut.hh2.sw.cv0.notr + mf.trno / mf.ut.hh2.sw.cv0.notr)

# HBW Temporary Utility - 2 Person HH, Single Worker, CV1
    mf.tmput.hh2.sw.cv1 <- (mf.trok / mf.ut.hh2.sw.cv1.all + mf.prok / mf.ut.hh2.sw.cv1.notr + mf.trno / mf.ut.hh2.sw.cv1.notrpr)

# HBW Temporary Utility - 2 Person HH, Single Worker, CV23
    mf.tmput.hh2.sw.cv23 <- (mf.trok / mf.ut.hh2.sw.cv23.all + mf.prok / mf.ut.hh2.sw.cv23.notr + mf.trno / mf.ut.hh2.sw.cv23.notrpr)

# HBW Temporary Utility - 2 Person HH, Multi Worker, CV0
    mf.tmput.hh2.mw.cv0 <- (mf.trok / mf.ut.hh2.mw.cv0.withtr + mf.prok / mf.ut.hh2.mw.cv0.notr + mf.trno / mf.ut.hh2.mw.cv0.notr)

# HBW Temporary Utility - 2 Person HH, Multi Worker, CV1
    mf.tmput.hh2.mw.cv1 <- (mf.trok / mf.ut.hh2.mw.cv1.all + mf.prok / mf.ut.hh2.mw.cv1.notr + mf.trno / mf.ut.hh2.mw.cv1.notrpr)

# HBW Temporary Utility - 2 Person HH, Multi Worker, CV23
    mf.tmput.hh2.mw.cv23 <- (mf.trok / mf.ut.hh2.mw.cv23.all + mf.prok / mf.ut.hh2.mw.cv23.notr + mf.trno / mf.ut.hh2.mw.cv23.notrpr)

# HBW Temporary Utility - 3+ Person HH, Single Worker, CV0
    mf.tmput.hh34.sw.cv0 <- (mf.trok / mf.ut.hh34.sw.cv0.withtr + mf.prok / mf.ut.hh34.sw.cv0.notr + mf.trno / mf.ut.hh34.sw.cv0.notr)

# HBW Temporary Utility - 3+ Person HH, Single Worker, CV1
    mf.tmput.hh34.sw.cv1 <- (mf.trok / mf.ut.hh34.sw.cv1.all + mf.prok / mf.ut.hh34.sw.cv1.notr + mf.trno / mf.ut.hh34.sw.cv1.notrpr)

# HBW Temporary Utility - 3+ Person HH, Single Worker, CV23
    mf.tmput.hh34.sw.cv23 <- (mf.trok / mf.ut.hh34.sw.cv23.all + mf.prok / mf.ut.hh34.sw.cv23.notr + mf.trno / mf.ut.hh34.sw.cv23.notrpr)

# HBW Temporary Utility - 3+ Person HH, Multi Worker, CV0
    mf.tmput.hh34.mw.cv0 <- (mf.trok / mf.ut.hh34.mw.cv0.withtr + mf.prok / mf.ut.hh34.mw.cv0.notr + mf.trno / mf.ut.hh34.mw.cv0.notr)

# HBW Temporary Utility - 3+ Person HH, Multi Worker, CV1
    mf.tmput.hh34.mw.cv1 <- (mf.trok / mf.ut.hh34.mw.cv1.all + mf.prok / mf.ut.hh34.mw.cv1.notr + mf.trno / mf.ut.hh34.mw.cv1.notrpr)

# HBW Temporary Utility - 3+ Person HH, Multi Worker, CV23
    mf.tmput.hh34.mw.cv23 <- (mf.trok / mf.ut.hh34.mw.cv23.all + mf.prok / mf.ut.hh34.mw.cv23.notr + mf.trno / mf.ut.hh34.mw.cv23.notrpr)


### HBW Drive Alone Person Trips

# HBW Drive Alone Person Trips - CV0 *** NEW ***
    mf.hwda.cv0 <- ((
                     mf.dautil.cv0 * mf.tmput.hh1.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh2.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh2.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh34.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh34.mw.cv0 * get(paste("ma.hbwBC0",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Drive Alone Person Trips - CV1
    mf.hwda.cv1 <- ((
                     mf.dautil.cv1 * mf.tmput.hh1.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh2.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh2.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh34.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh34.mw.cv1 * get(paste("ma.hbwBC1",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Drive Alone Person Trips - CV23
    mf.hwda.cv23 <- ((
                      mf.dautil.cv23 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC3",inc,sep=''))) *
                      get(paste("mf.hbwdt",inc,sep='')) * todfact)
  
# Raw HBW Drive Alone Trips
    assign(paste("mf.hwda",inc,timeper,sep="."), mf.hwda.cv0 + mf.hwda.cv1 + mf.hwda.cv23)

    assign(paste("mf.hwda.cv0",inc,timeper,sep="."), mf.hwda.cv0)
    assign(paste("mf.hwda.cv1",inc,timeper,sep="."), mf.hwda.cv1)
    assign(paste("mf.hwda.cv23",inc,timeper,sep="."),mf.hwda.cv23)

    rm (mf.hwda.cv0, mf.hwda.cv1, mf.hwda.cv23, mf.dautil.cv0, mf.dautil.cv1, mf.dautil.cv23)


### HBW Drive with Passenger Person Trips

# HBW Drive with Passenger Person Trips - CV0 *** NEW ***
    mf.hwdp.cv0 <- ((
                     mf.dputil.hh1.cv0 * mf.tmput.hh1.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) +
                     mf.dputil.hh2.cv0 * mf.tmput.hh2.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) +
                     mf.dputil.hh2.cv0 * mf.tmput.hh2.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) +
                     mf.dputil.hh34.cv0 * mf.tmput.hh34.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) +
                     mf.dputil.hh34.cv0 * mf.tmput.hh34.mw.cv0 * get(paste("ma.hbwBC0",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Drive with Passenger Person Trips - CV1
    mf.hwdp.cv1 <- ((
                     mf.dputil.hh1.cv1 * mf.tmput.hh1.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) +
                     mf.dputil.hh2.cv1 * mf.tmput.hh2.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) +
                     mf.dputil.hh2.cv1 * mf.tmput.hh2.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) +
                     mf.dputil.hh34.cv1 * mf.tmput.hh34.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) +
                     mf.dputil.hh34.cv1 * mf.tmput.hh34.mw.cv1 * get(paste("ma.hbwBC1",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Drive with Passenger Person Trips - CV23
    mf.hwdp.cv23 <- ((
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) +
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC3",inc,sep=''))) *
                      get(paste("mf.hbwdt",inc,sep='')) * todfact)

# Raw HBW Drive with Passenger Trips
    assign(paste("mf.hwdp",inc,timeper,sep="."), mf.hwdp.cv0 + mf.hwdp.cv1 + mf.hwdp.cv23)

    assign(paste("mf.hwdp.cv0",inc,timeper,sep="."), mf.hwdp.cv0)
    assign(paste("mf.hwdp.cv1",inc,timeper,sep="."), mf.hwdp.cv1)
    assign(paste("mf.hwdp.cv23",inc,timeper,sep="."),mf.hwdp.cv23)

    rm (mf.hwdp.cv0, mf.hwdp.cv1, mf.hwdp.cv23, 
        mf.dputil.hh1.cv0, mf.dputil.hh1.cv1, mf.dputil.hh1.cv23,
        mf.dputil.hh2.cv0, mf.dputil.hh2.cv1, mf.dputil.hh2.cv23,
        mf.dputil.hh34.cv0, mf.dputil.hh34.cv1, mf.dputil.hh34.cv23)


### HBW Passenger Person Trips

# HBW Passenger Person Trips - CV0
    mf.hwpa.cv0 <- ((
                     mf.pautil.hh1 * mf.tmput.hh1.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) +
                     mf.pautil.hh2 * mf.tmput.hh2.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) +
                     mf.pautil.hh2 * mf.tmput.hh2.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) +
                     mf.pautil.hh34 * mf.tmput.hh34.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) +
                     mf.pautil.hh34 * mf.tmput.hh34.mw.cv0 * get(paste("ma.hbwBC0",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Passenger Person Trips - CV1
    mf.hwpa.cv1 <- ((
                     mf.pautil.hh1 * mf.tmput.hh1.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) +
                     mf.pautil.hh2 * mf.tmput.hh2.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) +
                     mf.pautil.hh2 * mf.tmput.hh2.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) +
                     mf.pautil.hh34 * mf.tmput.hh34.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) +
                     mf.pautil.hh34 * mf.tmput.hh34.mw.cv1 * get(paste("ma.hbwBC1",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Passenger Person Trips - CV23
    mf.hwpa.cv23 <- ((
                      mf.pautil.hh1 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) +
                      mf.pautil.hh1 * mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) +
                      mf.pautil.hh2 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) +
                      mf.pautil.hh2 * mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) +
                      mf.pautil.hh2 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) +
                      mf.pautil.hh2 * mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) +
                      mf.pautil.hh34 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) +
                      mf.pautil.hh34 * mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) +
                      mf.pautil.hh34 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) +
                      mf.pautil.hh34 * mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC3",inc,sep=''))) *
                      get(paste("mf.hbwdt",inc,sep='')) * todfact)

# Raw HBW Passenger Trips
    assign(paste("mf.hwpa",inc,timeper,sep="."), mf.hwpa.cv0 + mf.hwpa.cv1 + mf.hwpa.cv23)

    assign(paste("mf.hwpa.cv0",inc,timeper,sep="."), mf.hwpa.cv0)
    assign(paste("mf.hwpa.cv1",inc,timeper,sep="."), mf.hwpa.cv1)
    assign(paste("mf.hwpa.cv23",inc,timeper,sep="."), mf.hwpa.cv23)

    rm(mf.hwpa.cv0, mf.hwpa.cv1, mf.hwpa.cv23, mf.pautil.hh1, mf.pautil.hh2, mf.pautil.hh34)


### HBW Transit Person Trips

# HBW Transit Person Trips - CV0
    mf.hwtr.cv0 <- ((
                     mf.trutil.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) / mf.ut.hh1.sw.cv0.withtr +
                     mf.trutil.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) / mf.ut.hh2.sw.cv0.withtr +
                     mf.trutil.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) / mf.ut.hh2.mw.cv0.withtr +
                     mf.trutil.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) / mf.ut.hh34.sw.cv0.withtr +
                     mf.trutil.mw.cv0 * get(paste("ma.hbwBC0",inc,sep='')) / mf.ut.hh34.mw.cv0.withtr) *
                     sweep(todfact * get(paste("mf.hbwdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBW Transit Person Trips - CV1
   mf.hwtr.cv1 <- ((
                    mf.trutil.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) / mf.ut.hh1.sw.cv1.all +
                    mf.trutil.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) / mf.ut.hh2.sw.cv1.all +
                    mf.trutil.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) / mf.ut.hh2.mw.cv1.all +
                    mf.trutil.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) / mf.ut.hh34.sw.cv1.all +
                    mf.trutil.mw.cv1 * get(paste("ma.hbwBC1",inc,sep='')) / mf.ut.hh34.mw.cv1.all) *
                    sweep(todfact * get(paste("mf.hbwdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBW Transit Person Trips - CV23
    mf.hwtr.cv23 <- ((
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) / mf.ut.hh1.sw.cv23.all +
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) / mf.ut.hh2.sw.cv23.all +
                      mf.trutil.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) / mf.ut.hh2.mw.cv23.all +
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) / mf.ut.hh34.sw.cv23.all +
                      mf.trutil.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) / mf.ut.hh34.mw.cv23.all +
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) / mf.ut.hh1.sw.cv23.all +
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) / mf.ut.hh2.sw.cv23.all +
                      mf.trutil.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) / mf.ut.hh34.sw.cv23.all +
                      mf.trutil.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) / mf.ut.hh2.mw.cv23.all +
                      mf.trutil.mw.cv23 * get(paste("ma.hbwBC3",inc,sep='')) / mf.ut.hh34.mw.cv23.all) *
                      sweep(todfact * get(paste("mf.hbwdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# Raw HBW Transit Person Trips
    assign(paste("mf.hwtr",inc,timeper,sep="."), mf.hwtr.cv1 + mf.hwtr.cv23 + mf.hwtr.cv0)

    assign(paste("mf.hwtr.cv0",inc,timeper,sep="."), mf.hwtr.cv0)
    assign(paste("mf.hwtr.cv1",inc,timeper,sep="."), mf.hwtr.cv1)
    assign(paste("mf.hwtr.cv23",inc,timeper,sep="."), mf.hwtr.cv23)

    rm (mf.hwtr.cv0, mf.hwtr.cv1, mf.hwtr.cv23, 
        mf.trutil.sw.cv0, mf.trutil.sw.cv1, mf.trutil.sw.cv23,
        mf.trutil.mw.cv0, mf.trutil.mw.cv1, mf.trutil.mw.cv23)


### HBW Park and Ride Transit Person Trips

# HBW Park and Ride Transit Person Trips - CV1
    mf.hwprtr.cw.cv1 <- (mf.prtutil.cv1 * (
                         mf.trok / mf.ut.hh1.sw.cv1.all * get(paste("ma.hbwAA1",inc,sep='')) +
                         mf.trok / mf.ut.hh2.sw.cv1.all * get(paste("ma.hbwAB1",inc,sep='')) +
                         mf.trok / mf.ut.hh2.mw.cv1.all * get(paste("ma.hbwBB1",inc,sep='')) +
                         mf.trok / mf.ut.hh34.sw.cv1.all * get(paste("ma.hbwAC1",inc,sep='')) +
                         mf.trok / mf.ut.hh34.mw.cv1.all * get(paste("ma.hbwBC1",inc,sep=''))) *
                         get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Park and Ride Transit Person Trips - CV23
    mf.hwprtr.cw.cv23 <- (mf.prtutil.cv23 * (
                          mf.trok / mf.ut.hh1.sw.cv23.all * get(paste("ma.hbwAA2",inc,sep='')) +
                          mf.trok / mf.ut.hh1.sw.cv23.all * get(paste("ma.hbwAA3",inc,sep='')) +
                          mf.trok / mf.ut.hh2.sw.cv23.all * get(paste("ma.hbwAB2",inc,sep='')) +
                          mf.trok / mf.ut.hh2.sw.cv23.all * get(paste("ma.hbwAB3",inc,sep='')) +
                          mf.trok / mf.ut.hh2.mw.cv23.all * get(paste("ma.hbwBB2",inc,sep='')) +
                          mf.trok / mf.ut.hh2.mw.cv23.all * get(paste("ma.hbwBB3",inc,sep='')) +
                          mf.trok / mf.ut.hh34.sw.cv23.all * get(paste("ma.hbwAC2",inc,sep='')) +
                          mf.trok / mf.ut.hh34.sw.cv23.all * get(paste("ma.hbwAC3",inc,sep='')) +
                          mf.trok / mf.ut.hh34.mw.cv23.all * get(paste("ma.hbwBC2",inc,sep='')) +
                          mf.trok / mf.ut.hh34.mw.cv23.all * get(paste("ma.hbwBC3",inc,sep=''))) *
                          get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Park and Ride Transit Person Trips - CV1
    mf.hwprtr.md.cv1 <- (mf.prtutil.cv1 * (
                         mf.prok / mf.ut.hh1.sw.cv1.notr * get(paste("ma.hbwAA1",inc,sep='')) +
                         mf.prok / mf.ut.hh2.sw.cv1.notr * get(paste("ma.hbwAB1",inc,sep='')) +
                         mf.prok / mf.ut.hh2.mw.cv1.notr * get(paste("ma.hbwBB1",inc,sep='')) +
                         mf.prok / mf.ut.hh34.sw.cv1.notr * get(paste("ma.hbwAC1",inc,sep='')) +
                         mf.prok / mf.ut.hh34.mw.cv1.notr * get(paste("ma.hbwBC1",inc,sep=''))) *
                         get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Park and Ride Transit Person Trips - CV23
    mf.hwprtr.md.cv23 <- (mf.prtutil.cv23 * (
                          mf.prok / mf.ut.hh1.sw.cv23.notr * get(paste("ma.hbwAA2",inc,sep='')) +
                          mf.prok / mf.ut.hh1.sw.cv23.notr * get(paste("ma.hbwAA3",inc,sep='')) +
                          mf.prok / mf.ut.hh2.sw.cv23.notr * get(paste("ma.hbwAB2",inc,sep='')) +
                          mf.prok / mf.ut.hh2.sw.cv23.notr * get(paste("ma.hbwAB3",inc,sep='')) +
                          mf.prok / mf.ut.hh2.mw.cv23.notr * get(paste("ma.hbwBB2",inc,sep='')) +
                          mf.prok / mf.ut.hh2.mw.cv23.notr * get(paste("ma.hbwBB3",inc,sep='')) +
                          mf.prok / mf.ut.hh34.sw.cv23.notr * get(paste("ma.hbwAC2",inc,sep='')) +
                          mf.prok / mf.ut.hh34.sw.cv23.notr * get(paste("ma.hbwAC3",inc,sep='')) +
                          mf.prok / mf.ut.hh34.mw.cv23.notr * get(paste("ma.hbwBC2",inc,sep='')) +
                          mf.prok / mf.ut.hh34.mw.cv23.notr * get(paste("ma.hbwBC3",inc,sep=''))) *
                          get(paste("mf.hbwdt",inc,sep='')) * todfact)

# Raw HBW Park and Ride Transit Trips
    assign(paste("mf.hwprtr",inc,timeper,sep="."), mf.hwprtr.cw.cv1 + mf.hwprtr.md.cv1 + mf.hwprtr.cw.cv23 + mf.hwprtr.md.cv23)
    assign(paste("mf.hwprtr.cv1",inc,timeper,sep="."), mf.hwprtr.cw.cv1 + mf.hwprtr.md.cv1)
    assign(paste("mf.hwprtr.cv23",inc,timeper,sep="."), mf.hwprtr.cw.cv23 + mf.hwprtr.md.cv23)
    assign(paste("mf.hwprtr.cw.cv1",inc,timeper,sep="."), mf.hwprtr.cw.cv1)
    assign(paste("mf.hwprtr.cw.cv23",inc,timeper,sep="."), mf.hwprtr.cw.cv23)
    assign(paste("mf.hwprtr.md.cv1",inc,timeper,sep="."), mf.hwprtr.md.cv1)
    assign(paste("mf.hwprtr.md.cv23",inc,timeper,sep="."), mf.hwprtr.md.cv23)
    rm (mf.prtutil.cv1, mf.prtutil.cv23)

#allocate trips to lots
allocateTripsToLots(get(paste("mf.hwprtr.cv1",inc,timeper,sep=".")), project.dir, 1, numzones, HBW.vehOccFactor, "hbw", "cv1")
allocateTripsToLots(get(paste("mf.hwprtr.cv23",inc,timeper,sep=".")), project.dir, 1, numzones, HBW.vehOccFactor, "hbw", "cv23")


### HBW Bike Person Trips

# HBW Bike Person Trips - CV0
    mf.hwbk.cv0 <- (mf.bkutil * (
                    mf.tmput.hh1.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) +
                    mf.tmput.hh2.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) +
                    mf.tmput.hh2.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) +
                    mf.tmput.hh34.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) +
                    mf.tmput.hh34.mw.cv0 * get(paste("ma.hbwBC0",inc,sep=''))) *
                    get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Bike Person Trips - CV1
    mf.hwbk.cv1 <- (mf.bkutil * (
                    mf.tmput.hh1.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) +
                    mf.tmput.hh2.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) +
                    mf.tmput.hh2.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) +
                    mf.tmput.hh34.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) +
                    mf.tmput.hh34.mw.cv1 * get(paste("ma.hbwBC1",inc,sep=''))) *
                    get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Bike Person Trips - CV23
    mf.hwbk.cv23 <- (mf.bkutil * (
                     mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) +
                     mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) +
                     mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) +
                     mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) +
                     mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) +
                     mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) +
                     mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) +
                     mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) +
                     mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) +
                     mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC3",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# Raw HBW Bike Trips
    assign(paste("mf.hwbike",inc,timeper,sep="."), mf.hwbk.cv0 + mf.hwbk.cv1 + mf.hwbk.cv23)

    assign(paste("mf.hwbike.cv0",inc,timeper,sep="."), mf.hwbk.cv0)
    assign(paste("mf.hwbike.cv1",inc,timeper,sep="."), mf.hwbk.cv1)
    assign(paste("mf.hwbike.cv23",inc,timeper,sep="."), mf.hwbk.cv23)

    rm(mf.hwbk.cv0, mf.hwbk.cv1, mf.hwbk.cv23, mf.bkutil)


### HBW Walk Person Trips

# HBW Walk Person Trips - CV0
    mf.hwwk.cv0 <- (mf.wkutil * (
                    mf.tmput.hh1.sw.cv0 * get(paste("ma.hbwAA0",inc,sep='')) +
                    mf.tmput.hh2.sw.cv0 * get(paste("ma.hbwAB0",inc,sep='')) +
                    mf.tmput.hh2.mw.cv0 * get(paste("ma.hbwBB0",inc,sep='')) +
                    mf.tmput.hh34.sw.cv0 * get(paste("ma.hbwAC0",inc,sep='')) +
                    mf.tmput.hh34.mw.cv0 * get(paste("ma.hbwBC0",inc,sep=''))) *
                    get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Walk Person Trips - CV1
    mf.hwwk.cv1 <- (mf.wkutil * (
                    mf.tmput.hh1.sw.cv1 * get(paste("ma.hbwAA1",inc,sep='')) +
                    mf.tmput.hh2.sw.cv1 * get(paste("ma.hbwAB1",inc,sep='')) +
                    mf.tmput.hh2.mw.cv1 * get(paste("ma.hbwBB1",inc,sep='')) +
                    mf.tmput.hh34.sw.cv1 * get(paste("ma.hbwAC1",inc,sep='')) +
                    mf.tmput.hh34.mw.cv1 * get(paste("ma.hbwBC1",inc,sep=''))) *
                    get(paste("mf.hbwdt",inc,sep='')) * todfact)

# HBW Walk Person Trips - CV23
    mf.hwwk.cv23 <- (mf.wkutil * (
                     mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA2",inc,sep='')) +
                     mf.tmput.hh1.sw.cv23 * get(paste("ma.hbwAA3",inc,sep='')) +
                     mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB2",inc,sep='')) +
                     mf.tmput.hh2.sw.cv23 * get(paste("ma.hbwAB3",inc,sep='')) +
                     mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB2",inc,sep='')) +
                     mf.tmput.hh2.mw.cv23 * get(paste("ma.hbwBB3",inc,sep='')) +
                     mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC2",inc,sep='')) +
                     mf.tmput.hh34.sw.cv23 * get(paste("ma.hbwAC3",inc,sep='')) +
                     mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC2",inc,sep='')) +
                     mf.tmput.hh34.mw.cv23 * get(paste("ma.hbwBC3",inc,sep=''))) *
                     get(paste("mf.hbwdt",inc,sep='')) * todfact)

# Raw HBW Walk Trips
    assign(paste("mf.hwwalk",inc,timeper,sep="."), mf.hwwk.cv0 + mf.hwwk.cv1 + mf.hwwk.cv23)

    assign(paste("mf.hwwalk.cv0",inc,timeper,sep="."), mf.hwwk.cv0)
    assign(paste("mf.hwwalk.cv1",inc,timeper,sep="."), mf.hwwk.cv1)
    assign(paste("mf.hwwalk.cv23",inc,timeper,sep="."), mf.hwwk.cv23)

    rm(mf.hwwk.cv0, mf.hwwk.cv1, mf.hwwk.cv23, mf.wkutil)

#  REMOVE the Total and Temporary Utilities

    rm(mf.hhcov, mf.trok, mf.prok, mf.trno)
    rm(list=ls()[grep(("mf.tmput"),ls())])
    rm(list=ls()[grep(("mf.ut"),ls())])

  }   ##  END OF TIME OF DAY LOOP

}  ## END OF INCOME LOOP

detach(malist.hbw)
