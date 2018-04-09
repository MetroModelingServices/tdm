# k.hbrms.R
# HBR Mode Choice

print("Running hbr mode choice")

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.hbrdtl.dat")
load("mf.hbrdtm.dat")
load("mf.hbrdth.dat")
load("malist.hbr.dat")
attach(malist.hbr)

# Auto Operating Cost
mf.Sopcost <- autocost * mf.tdist
mf.Hopcost <- mf.Sopcost

# Auto Out of Pocket Cost
mf.Spocketcost <- sweep((mf.Sopcost * 0), 2, 0.5 * ma.stpkg, "+")
mf.Hpocketcost <- sweep((mf.Hopcost * 0), 2, 0.5 * ma.stpkg, "+")

if (toll == TRUE)
{
  print("About to calculate toll costs")

  # Adjust Toll Time to reflect difference in elasticity between assignment and model (.75)

  mf.amstlTadj <- mf.amstl*(1.125)*(.75)
  mf.mdstlTadj <- mf.mdstl*(1.25)*(.75)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(1.125)*(.75)
  mf.mdhtlTadj <- mf.mdhtl*(1.25)*(.75)

  mf.amhtlD <- (mf.amhtlTadj/60)*pkvot
  mf.mdhtlD <- (mf.mdhtlTadj/60)*opvot

  # Add Tolls
  mf.Spocketcost <- sweep((HBR.pkfact*mf.amstlD + HBR.opfact*mf.mdstlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBR.pkfact*mf.amhtlD + HBR.opfact*mf.mdhtlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBR.low.cc     # auto operating costs coeff
    pktc   <- HBR.low.pktc   # auto out of pocket costs: parking and tolls coeff
    faresc <- HBR.low.faresc # transit fares coeff
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBR.medium.cc      # auto operating costs coeff
    pktc   <- HBR.medium.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBR.medium.faresc  # transit fares coeff
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBR.high.cc      # auto operating costs coeff
    pktc   <- HBR.high.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBR.high.faresc  # transit fares coeff
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact <- HBR.pkfact
      timeper <- "am"
      ma.hhcov <- ma.pkhhcov
      ma.empcov <- ma.pkempcov
    }
    if (y==2) {
      todfact <- HBR.opfact
      timeper <- "md"
      ma.hhcov <- ma.ophhcov
      ma.empcov <- ma.opempcov
    }

### HBR Drive Alone Utility 

# HBR Drive Alone Utility
    mf.base <- (HBR.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + sweep(cc * mf.Sopcost, 2, HBR.da.walkCoeff * ma.auov, "+") + pktc * mf.Spocketcost)

# HBR Drive Alone Utility cv0 (No Cars) *** NEW ***
    mf.dautil.cv0 <- exp(mf.base + HBR.da.cv0)

# HBR Drive Alone Utility cv1 (Cars < Workers) *** NEW ***
    mf.dautil.cv1 <- exp(mf.base + HBR.da.cv1)

# HBR Drive Alone Utility cv2 & cv3 (Cars >= Workers) *** NEW ***
    mf.dautil.cv23 <- exp(mf.base + HBR.da.cv23)


### Drive with Passenger Utilities

# Base HBR Drive with Passenger Utility
    mf.base <- (HBR.MC.dpconst + HBR.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBR.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBR.dp.walkCoeff * ma.auov, "+"))

# 1 Person Household HBR Drive with Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.dputil.hh1.cv0 <- exp(mf.base + HBR.dp.hh1 + HBR.dp.cv0)

# 1 Person Household HBR Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh1.cv1 <- exp(mf.base + HBR.dp.hh1 + HBR.dp.cv1)

# 1 Person Household HBR Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh1.cv23 <- exp(mf.base + HBR.dp.hh1 + HBR.dp.cv23)

# 2 Person Household HBR Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh2.cv0 <- exp(mf.base + HBR.dp.hh2 + HBR.dp.cv0)

# 2 Person Household HBR Drive with Passenger Utility cv1 (Cars < Workers) *** NEW ***
    mf.dputil.hh2.cv1 <- exp(mf.base + HBR.dp.hh2 + HBR.dp.cv1)
    
# 2 Person Household HBR Drive with Passenger Utility cv2 & cv3 (Cars >= Workers) *** NEW *** 
    mf.dputil.hh2.cv23 <- exp(mf.base + HBR.dp.hh2 + HBR.dp.cv23)

# 3+ Person Household HBR Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh34.cv0 <- exp(mf.base + HBR.dp.hh34 + HBR.dp.cv0)

# 3+ Person Household HBR Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh34.cv1 <- exp(mf.base + HBR.dp.hh34 + HBR.dp.cv1)

# 3+ Person Household HBR Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh34.cv23 <- exp(mf.base + HBR.dp.hh34 + HBR.dp.cv23)


### Passenger Utilities

# Base HBR Passenger Utility
    mf.base <- (HBR.MC.paconst + HBR.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBR.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBR.pa.walkCoeff * ma.auov, "+"))

# 1 Person Household HBR Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.pautil.hh1.cv0 <- exp(mf.base + HBR.pa.hh1 + HBR.pa.cv0)

# 1 Person Household HBR Passenger Utility cv123 (Cars > 0) *** EDITED ***
    mf.pautil.hh1.cv123 <- exp(mf.base + HBR.pa.hh1 + HBR.pa.cv123)

# 2 Person Household HBR Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh2.cv0 <- exp(mf.base + HBR.pa.hh2 + HBR.pa.cv0)
    
# 2 Person Household HBR Passenger Utility cv123 (Cars > 0) *** NEW ***
    mf.pautil.hh2.cv123 <- exp(mf.base + HBR.pa.hh2 + HBR.pa.cv123)

# 3+ Person Household HBR Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh34.cv0 <- exp(mf.base + HBR.pa.hh34 + HBR.pa.cv0)

# 3+ Person Household HBR Passenger Utility cv123 (Cars > 0)
    mf.pautil.hh34.cv123 <- exp(mf.base + HBR.pa.hh34 + HBR.pa.cv123)


### HBR Transit Utilities

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

# Base HBR Transit Utility
    ivt     <- HBR.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- HBR.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- HBR.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.base <- (trconst + ivt + HBR.tr.wait1Coeff * mf.trwait1 + HBR.tr.wait2Coeff * mf.trwait2 + HBR.tr.walkCoeff * mf.trwalk + HBR.tr.transCoeff * mf.transfers +
          sweep(faresc * mf.trfare, 2, HBR.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") +
          sweep(oviv, 1, HBR.tr.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.base[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBR Transit Utility cv0 (No Cars)
    mf.trutil.cv0 <- exp(mf.base + HBR.tr.cv0)
    mf.trutil.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBR Transit Utility cv1 (Cars < Workers)
    mf.trutil.cv1 <- exp(mf.base + HBR.tr.cv1)
    mf.trutil.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBR Transit Utility cv2 (Cars = Workers)
    mf.trutil.cv2 <- exp(mf.base + HBR.tr.cv2)
    mf.trutil.cv2[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBR Transit Utility cv3 (Cars > Workers)
    mf.trutil.cv3 <- exp(mf.base + HBR.tr.cv3)
    mf.trutil.cv3[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0


### HBR Park and Ride Transit Utility

    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbr"
    paramSet$cv <- "" 
    paramSet$cvConstant <- PNR.cvConstant 
    #constants
    paramSet$formalConstant <- HBR.formalConstant
    paramSet$informalConstant <- HBR.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff

    mf.prtutil <- calcPNRUtils(timeper, inc, project.dir, HBR.MC.prconst, 1, numzones, paramSet)


### HBR Bike Utility
    mf.bkutil <- exp(sweep(HBR.MC.bikeconst + HBR.bk.inbikeCoeff * mf.inbike + HBR.bk.ubdistCoeff * mf.ubdist + HBR.bk.nbcostCoeff * mf.nbcost, 2, HBR.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


### HBR Walk Utilities
    mf.wkutil <- exp(sweep(HBR.MC.walkconst + HBR.wk.walkCoeff * mf.wtime, 1, HBR.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


##### Compute Total Utilities and Save in Temporary Matrices 

print("Calculating total utilities")

# HBR Utility - HH1, CV0, w/o Transit
    mf.ut.hh1.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh1.cv0 + mf.pautil.hh1.cv0 + mf.bkutil + mf.wkutil)

# HBR Utility - HH1, CV0, w/ Transit
    mf.ut.hh1.cv0.withtr <- (mf.ut.hh1.cv0.notr + mf.trutil.cv0)

# HBR Utility - HH1, CV1, w/o Transit or PnR
    mf.ut.hh1.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh1.cv1 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH1, CV1, all modes
    mf.ut.hh1.cv1.all <- (mf.ut.hh1.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBR Utility - HH1, CV1, w/o Transit
    mf.ut.hh1.cv1.notr <- (mf.ut.hh1.cv1.notrpr + mf.prtutil)

# HBR Utility - HH1, CV2, w/o Transit or PnR
    mf.ut.hh1.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH1, CV2, all modes
    mf.ut.hh1.cv2.all <- (mf.ut.hh1.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBR Utility - HH1, CV2, w/o Transit
    mf.ut.hh1.cv2.notr <- (mf.ut.hh1.cv2.notrpr + mf.prtutil)

# HBR Utility - HH1, CV3, w/o Transit or PnR
    mf.ut.hh1.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH1, CV3, all modes
    mf.ut.hh1.cv3.all <- (mf.ut.hh1.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBR Utility - HH1, CV3, w/o Transit
    mf.ut.hh1.cv3.notr <- (mf.ut.hh1.cv3.notrpr + mf.prtutil)

# HBR Utility - HH2, CV0, w/o Transit
    mf.ut.hh2.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh2.cv0 + mf.pautil.hh2.cv0 + mf.bkutil + mf.wkutil)

# HBR Utility - HH2, CV0, w/ Transit
    mf.ut.hh2.cv0.withtr <- (mf.ut.hh2.cv0.notr + mf.trutil.cv0)

# HBR Utility - HH2, CV1, w/o Transit or PnR
    mf.ut.hh2.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh2.cv1 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH2, CV1, all modes
    mf.ut.hh2.cv1.all <- (mf.ut.hh2.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBR Utility - HH2, CV1, w/o Transit
    mf.ut.hh2.cv1.notr <- (mf.ut.hh2.cv1.notrpr + mf.prtutil)

# HBR Utility - HH2, CV2, w/o Transit or PnR
    mf.ut.hh2.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH2, CV2, all modes
    mf.ut.hh2.cv2.all <- (mf.ut.hh2.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBR Utility - HH2, CV2, w/o Transit
    mf.ut.hh2.cv2.notr <- (mf.ut.hh2.cv2.notrpr + mf.prtutil)

# HBR Utility - HH2, CV3, w/o Transit or PnR
    mf.ut.hh2.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH2, CV3, all modes
    mf.ut.hh2.cv3.all <- (mf.ut.hh2.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBR Utility - HH2, CV3, w/o Transit
    mf.ut.hh2.cv3.notr <- (mf.ut.hh2.cv3.notrpr + mf.prtutil)

# HBR Utility - HH34, CV0, w/o Transit
    mf.ut.hh34.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh34.cv0 + mf.pautil.hh34.cv0 + mf.bkutil + mf.wkutil)

# HBR Utility - HH34, CV0, w/ Transit
    mf.ut.hh34.cv0.withtr <- (mf.ut.hh34.cv0.notr + mf.trutil.cv0)

# HBR Utility - HH34, CV1, w/o Transit or PnR
    mf.ut.hh34.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh34.cv1 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH34, CV1, all modes
    mf.ut.hh34.cv1.all <- (mf.ut.hh34.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBR Utility - HH34, CV1, w/o Transit
    mf.ut.hh34.cv1.notr <- (mf.ut.hh34.cv1.notrpr + mf.prtutil)

# HBR Utility - HH34, CV2, w/o Transit or PnR
    mf.ut.hh34.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH34, CV2, all modes
    mf.ut.hh34.cv2.all <- (mf.ut.hh34.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBR Utility - HH34, CV2, w/o Transit
    mf.ut.hh34.cv2.notr <- (mf.ut.hh34.cv2.notrpr + mf.prtutil)

# HBR Utility - HH34, CV3, w/o Transit or PnR
    mf.ut.hh34.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBR Utility - HH34, CV3, all modes
    mf.ut.hh34.cv3.all <- (mf.ut.hh34.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBR Utility - HH34, CV3, w/o Transit
    mf.ut.hh34.cv3.notr <- (mf.ut.hh34.cv3.notrpr + mf.prtutil)


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


# HBR Temporary Utility - HH1, CV0
   mf.tmput.hh1.cv0 <- (mf.trok / mf.ut.hh1.cv0.withtr + mf.prok / mf.ut.hh1.cv0.notr + mf.trno / mf.ut.hh1.cv0.notr)

# HBR Temporary Utility - HH1, CV1
    mf.tmput.hh1.cv1 <- (mf.trok / mf.ut.hh1.cv1.all + mf.prok / mf.ut.hh1.cv1.notr + mf.trno / mf.ut.hh1.cv1.notrpr)

# HBR Temporary Utility - HH1, CV2
    mf.tmput.hh1.cv2 <- (mf.trok / mf.ut.hh1.cv2.all + mf.prok / mf.ut.hh1.cv2.notr + mf.trno / mf.ut.hh1.cv2.notrpr)

# HBR Temporary Utility - HH1, CV3
    mf.tmput.hh1.cv3 <- (mf.trok / mf.ut.hh1.cv3.all + mf.prok / mf.ut.hh1.cv3.notr + mf.trno / mf.ut.hh1.cv3.notrpr)

# HBR Temporary Utility - HH2, CV0
    mf.tmput.hh2.cv0 <- (mf.trok / mf.ut.hh2.cv0.withtr + mf.prok / mf.ut.hh2.cv0.notr + mf.trno / mf.ut.hh2.cv0.notr)

# HBR Temporary Utility - HH2, CV1
    mf.tmput.hh2.cv1 <- (mf.trok / mf.ut.hh2.cv1.all + mf.prok / mf.ut.hh2.cv1.notr + mf.trno / mf.ut.hh2.cv1.notrpr)

# HBR Temporary Utility - HH2, CV2
    mf.tmput.hh2.cv2 <- (mf.trok / mf.ut.hh2.cv2.all + mf.prok / mf.ut.hh2.cv2.notr + mf.trno / mf.ut.hh2.cv2.notrpr)

# HBR Temporary Utility - HH2, CV3
    mf.tmput.hh2.cv3 <- (mf.trok / mf.ut.hh2.cv3.all + mf.prok / mf.ut.hh2.cv3.notr + mf.trno / mf.ut.hh2.cv3.notrpr)

# HBR Temporary Utility - HH34, CV0
    mf.tmput.hh34.cv0 <- (mf.trok / mf.ut.hh34.cv0.withtr + mf.prok / mf.ut.hh34.cv0.notr + mf.trno / mf.ut.hh34.cv0.notr)

# HBR Temporary Utility - HH34, CV1
    mf.tmput.hh34.cv1 <- (mf.trok / mf.ut.hh34.cv1.all + mf.prok / mf.ut.hh34.cv1.notr + mf.trno / mf.ut.hh34.cv1.notrpr)

# HBR Temporary Utility - HH34, CV2
    mf.tmput.hh34.cv2 <- (mf.trok / mf.ut.hh34.cv2.all + mf.prok / mf.ut.hh34.cv2.notr + mf.trno / mf.ut.hh34.cv2.notrpr)

# HBR Temporary Utility - HH34, CV3
    mf.tmput.hh34.cv3 <- (mf.trok / mf.ut.hh34.cv3.all + mf.prok / mf.ut.hh34.cv3.notr + mf.trno / mf.ut.hh34.cv3.notrpr)


### HBR Drive Alone Person Trips

# HBR Drive Alone Person Trips - CV0 
    mf.hrda.cv0 <- ((
                     mf.dautil.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbrA0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbrB0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbrC0",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Drive Alone Person Trips - CV1 
    mf.hrda.cv1 <- ((
                     mf.dautil.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hbrA1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hbrB1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hbrC1",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Drive Alone Person Trips - CV23 
    mf.hrda.cv23 <- ((
                      mf.dautil.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hbrA2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hbrA3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hbrB2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hbrB3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hbrC2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hbrC3",inc,sep=''))) *
                      get(paste("mf.hbrdt",inc,sep='')) * todfact)
  
# Raw HBR Drive Alone Trips
    assign(paste("mf.hrda",inc,timeper,sep="."), mf.hrda.cv0 + mf.hrda.cv1 + mf.hrda.cv23)

    assign(paste("mf.hrda.cv0",inc,timeper,sep="."), mf.hrda.cv0)
    assign(paste("mf.hrda.cv1",inc,timeper,sep="."), mf.hrda.cv1)
    assign(paste("mf.hrda.cv23",inc,timeper,sep="."), mf.hrda.cv23)

    rm (mf.hrda.cv0, mf.hrda.cv1, mf.hrda.cv23, mf.dautil.cv0, mf.dautil.cv1, mf.dautil.cv23)


### HBR Drive with Passenger Person Trips

# HBR Drive with Passenger Person Trips - CV0
    mf.hrdp.cv0 <- ((
                     mf.dputil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbrA0",inc,sep='')) +
                     mf.dputil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbrB0",inc,sep='')) +
                     mf.dputil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbrC0",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Drive with Passenger Person Trips - CV1
    mf.hrdp.cv1 <- ((
                     mf.dputil.hh1.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hbrA1",inc,sep='')) +
                     mf.dputil.hh2.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hbrB1",inc,sep='')) +
                     mf.dputil.hh34.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hbrC1",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Drive with Passenger Person Trips - CV23
    mf.hrdp.cv23 <- ((
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hbrA2",inc,sep='')) +
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hbrA3",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hbrB2",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hbrB3",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hbrC2",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hbrC3",inc,sep=''))) *
                      get(paste("mf.hbrdt",inc,sep='')) * todfact)

# Raw HBR Drive with Passenger Trips
    assign(paste("mf.hrdp",inc,timeper,sep="."), mf.hrdp.cv0 + mf.hrdp.cv1 + mf.hrdp.cv23)

    assign(paste("mf.hrdp.cv0",inc,timeper,sep="."), mf.hrdp.cv0)
    assign(paste("mf.hrdp.cv1",inc,timeper,sep="."), mf.hrdp.cv1)
    assign(paste("mf.hrdp.cv23",inc,timeper,sep="."), mf.hrdp.cv23)

    rm (mf.hrdp.cv0, mf.hrdp.cv1, mf.hrdp.cv23,
        mf.dputil.hh1.cv0, mf.dputil.hh1.cv1, mf.dputil.hh1.cv23,
        mf.dputil.hh2.cv0, mf.dputil.hh2.cv1, mf.dputil.hh2.cv23,
        mf.dputil.hh34.cv0, mf.dputil.hh34.cv1, mf.dputil.hh34.cv23)


### HBR Passenger Person Trips

# HBR Passenger Person Trips - CV0
    mf.hrpa.cv0 <- ((
                     mf.pautil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbrA0",inc,sep='')) +
                     mf.pautil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbrB0",inc,sep='')) +
                     mf.pautil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbrC0",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Passenger Person Trips - CV1
    mf.hrpa.cv1 <- (( 
                     mf.pautil.hh1.cv123 * mf.tmput.hh1.cv1 * get(paste("md.hbrA1",inc,sep='')) +
                     mf.pautil.hh2.cv123 * mf.tmput.hh2.cv1 * get(paste("md.hbrB1",inc,sep='')) +
                     mf.pautil.hh34.cv123 * mf.tmput.hh34.cv1 * get(paste("md.hbrC1",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Passenger Person Trips - CV23
    mf.hrpa.cv23 <- ((
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv2 * get(paste("md.hbrA2",inc,sep='')) +
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv3 * get(paste("md.hbrA3",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv2 * get(paste("md.hbrB2",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv3 * get(paste("md.hbrB3",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv2 * get(paste("md.hbrC2",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv3 * get(paste("md.hbrC3",inc,sep=''))) *
                      get(paste("mf.hbrdt",inc,sep='')) * todfact)

# Raw HBR Passenger Trips
    assign(paste("mf.hrpa",inc,timeper,sep="."), mf.hrpa.cv0 + mf.hrpa.cv1 + mf.hrpa.cv23)

    assign(paste("mf.hrpa.cv0",inc,timeper,sep="."), mf.hrpa.cv0)
    assign(paste("mf.hrpa.cv1",inc,timeper,sep="."), mf.hrpa.cv1)
    assign(paste("mf.hrpa.cv23",inc,timeper,sep="."), mf.hrpa.cv23)

    rm (mf.hrpa.cv0, mf.hrpa.cv1, mf.hrpa.cv23,
        mf.pautil.hh1.cv0, mf.pautil.hh1.cv123,
        mf.pautil.hh2.cv0, mf.pautil.hh2.cv123,
        mf.pautil.hh34.cv0, mf.pautil.hh34.cv123)


### HBR Transit Person Trips

# HBR Transit Person Trips - CV0
    mf.hrtr.cv0 <- ((
                    (mf.trutil.cv0 / mf.ut.hh1.cv0.withtr) * get(paste("md.hbrA0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh2.cv0.withtr) * get(paste("md.hbrB0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh34.cv0.withtr) * get(paste("md.hbrC0",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbrdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBR Transit Person Trips - CV1
    mf.hrtr.cv1 <- ((
                    (mf.trutil.cv1 / mf.ut.hh1.cv1.all) * get(paste("md.hbrA1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh2.cv1.all) * get(paste("md.hbrB1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh34.cv1.all) * get(paste("md.hbrC1",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbrdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBR Transit Person Trips - Household Size = 2, CV 1-3
    mf.hrtr.cv23 <- ((
                     (mf.trutil.cv2 / mf.ut.hh1.cv2.all) * get(paste("md.hbrA2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh1.cv3.all) * get(paste("md.hbrA3",inc,sep='')) +
                     (mf.trutil.cv2 / mf.ut.hh2.cv2.all) * get(paste("md.hbrB2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh2.cv3.all) * get(paste("md.hbrB3",inc,sep='')) + 
                     (mf.trutil.cv2 / mf.ut.hh34.cv2.all) * get(paste("md.hbrC2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh34.cv3.all) * get(paste("md.hbrC3",inc,sep=''))) *
                      sweep(todfact * get(paste("mf.hbrdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# Raw HBR Transit Person Trips
    assign(paste("mf.hrtr",inc,timeper,sep="."), mf.hrtr.cv0 + mf.hrtr.cv1 + mf.hrtr.cv23)

    assign(paste("mf.hrtr.cv0",inc,timeper,sep="."), mf.hrtr.cv0)
    assign(paste("mf.hrtr.cv1",inc,timeper,sep="."), mf.hrtr.cv1)
    assign(paste("mf.hrtr.cv23",inc,timeper,sep="."), mf.hrtr.cv23)

    rm (mf.hrtr.cv0, mf.hrtr.cv1, mf.hrtr.cv23, mf.trutil.cv0, mf.trutil.cv1, mf.trutil.cv2, mf.trutil.cv3)


### HBR Park and Ride Transit Person Trips

    mf.hrprtr.cw.cv1 <- (mf.prtutil * (
                         mf.trok / mf.ut.hh1.cv1.all * get(paste("md.hbrA1",inc,sep='')) +
                         mf.trok / mf.ut.hh2.cv1.all * get(paste("md.hbrB1",inc,sep='')) +
                         mf.trok / mf.ut.hh34.cv1.all * get(paste("md.hbrC1",inc,sep=''))) *
                         get(paste("mf.hbrdt",inc,sep='')) * todfact)

    mf.hrprtr.cw.cv23 <- (mf.prtutil * (
                          mf.trok / mf.ut.hh1.cv2.all * get(paste("md.hbrA2",inc,sep='')) +
                          mf.trok / mf.ut.hh1.cv3.all * get(paste("md.hbrA3",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv2.all * get(paste("md.hbrB2",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv3.all * get(paste("md.hbrB3",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv2.all * get(paste("md.hbrC2",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv3.all * get(paste("md.hbrC3",inc,sep=''))) *
                          get(paste("mf.hbrdt",inc,sep='')) * todfact)

    mf.hrprtr.md.cv1 <- (mf.prtutil * (
                         mf.prok / mf.ut.hh1.cv1.notr * get(paste("md.hbrA1",inc,sep='')) +
                         mf.prok / mf.ut.hh2.cv1.notr * get(paste("md.hbrB1",inc,sep='')) +
                         mf.prok / mf.ut.hh34.cv1.notr * get(paste("md.hbrC1",inc,sep=''))) *
                         get(paste("mf.hbrdt",inc,sep='')) * todfact)

    mf.hrprtr.md.cv23 <- (mf.prtutil * (
                          mf.prok / mf.ut.hh1.cv2.notr * get(paste("md.hbrA2",inc,sep='')) +
                          mf.prok / mf.ut.hh1.cv3.notr * get(paste("md.hbrA3",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv2.notr * get(paste("md.hbrB2",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv3.notr * get(paste("md.hbrB3",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv2.notr * get(paste("md.hbrC2",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv3.notr * get(paste("md.hbrC3",inc,sep=''))) *
                          get(paste("mf.hbrdt",inc,sep='')) * todfact)

# Raw HBR Park and Ride Transit Trips
    assign(paste("mf.hrprtr",inc,timeper,sep="."), mf.hrprtr.cw.cv1 + mf.hrprtr.md.cv1 + mf.hrprtr.cw.cv23 + mf.hrprtr.md.cv23)
    assign(paste("mf.hrprtr.cv1",inc,timeper,sep="."), mf.hrprtr.cw.cv1 + mf.hrprtr.md.cv1)
    assign(paste("mf.hrprtr.cv23",inc,timeper,sep="."), mf.hrprtr.cw.cv23 +  mf.hrprtr.md.cv23)
    assign(paste("mf.hrprtr.cw.cv1",inc,timeper,sep="."), mf.hrprtr.cw.cv1)
    assign(paste("mf.hrprtr.cw.cv23",inc,timeper,sep="."), mf.hrprtr.cw.cv23)
    assign(paste("mf.hrprtr.md.cv1",inc,timeper,sep="."), mf.hrprtr.md.cv1)
    assign(paste("mf.hrprtr.md.cv23",inc,timeper,sep="."), mf.hrprtr.md.cv23)
    rm (mf.prtutil)

#allocate trips to lots
    allocateTripsToLots(get(paste("mf.hrprtr",inc,timeper,sep=".")), project.dir, 1, numzones, HBR.vehOccFactor, "hbr")


### HBR Bike Person Trips

# HBR Bike Person Trips - CV0
    mf.hrbk.cv0 <- (mf.bkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hbrA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hbrB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hbrC0",inc,sep=''))) *
                    get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Bike Person Trips - CV1
    mf.hrbk.cv1 <- (mf.bkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hbrA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hbrB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hbrC1",inc,sep=''))) *
                    get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Bike Person Trips - CV23
    mf.hrbk.cv23 <- (mf.bkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hbrA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hbrA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hbrB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hbrB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hbrC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hbrC3",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# Raw HBR Bike Trips
    assign(paste("mf.hrbike",inc,timeper,sep="."), mf.hrbk.cv0 + mf.hrbk.cv1 + mf.hrbk.cv23)

    assign(paste("mf.hrbike.cv0",inc,timeper,sep="."), mf.hrbk.cv0)
    assign(paste("mf.hrbike.cv1",inc,timeper,sep="."), mf.hrbk.cv1)
    assign(paste("mf.hrbike.cv23",inc,timeper,sep="."), mf.hrbk.cv23)

    rm(mf.hrbk.cv0, mf.hrbk.cv1, mf.hrbk.cv23, mf.bkutil)


### HBR Walk Person Trips

# HBR Walk Person Trips - CV0
    mf.hrwk.cv0 <- (mf.wkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hbrA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hbrB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hbrC0",inc,sep=''))) *
                    get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Walk Person Trips - CV1
    mf.hrwk.cv1 <- (mf.wkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hbrA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hbrB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hbrC1",inc,sep=''))) *
                    get(paste("mf.hbrdt",inc,sep='')) * todfact)

# HBR Walk Person Trips - CV23
    mf.hrwk.cv23 <- (mf.wkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hbrA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hbrA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hbrB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hbrB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hbrC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hbrC3",inc,sep=''))) *
                     get(paste("mf.hbrdt",inc,sep='')) * todfact)

# Raw HBR Walk Trips
    assign(paste("mf.hrwalk",inc,timeper,sep="."), mf.hrwk.cv0 + mf.hrwk.cv1 + mf.hrwk.cv23)

    assign(paste("mf.hrwalk.cv0",inc,timeper,sep="."), mf.hrwk.cv0)
    assign(paste("mf.hrwalk.cv1",inc,timeper,sep="."), mf.hrwk.cv1)
    assign(paste("mf.hrwalk.cv23",inc,timeper,sep="."), mf.hrwk.cv23)

    rm(mf.hrwk.cv0, mf.hrwk.cv1, mf.hrwk.cv23, mf.wkutil)

#  REMOVE the Total and Temporary Utilities

    rm(mf.hhcov, mf.trok, mf.prok, mf.trno)
    rm(list=ls()[grep(("mf.tmput"),ls())])
    rm(list=ls()[grep(("mf.ut"),ls())])

  }   ##  END OF TIME OF DAY LOOP

}     ##  END OF INCOME LOOP

detach(malist.hbr)
