# k.hbsms.R
# HBS Mode Choice

print("Running hbs mode choice")

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.hbsdtl.dat")
load("mf.hbsdtm.dat")
load("mf.hbsdth.dat")
load("malist.hbs.dat")
attach(malist.hbs)

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
  mf.Spocketcost <- sweep((HBS.pkfact*mf.amstlD + HBS.opfact*mf.mdstlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBS.pkfact*mf.amhtlD + HBS.opfact*mf.mdhtlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBS.low.cc     # auto operating costs coeff
    pktc   <- HBS.low.pktc   # auto out of pocket costs: parking and tolls coeff
    faresc <- HBS.low.faresc # transit fares coeff
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBS.medium.cc      # auto operating costs coeff
    pktc   <- HBS.medium.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBS.medium.faresc  # transit fares coeff
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBS.high.cc      # auto operating costs coeff
    pktc   <- HBS.high.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBS.high.faresc  # transit fares coeff
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact <- HBS.pkfact
      timeper <- "am"
      ma.hhcov <- ma.pkhhcov
      ma.empcov <- ma.pkempcov
    }
    if (y==2) {
      todfact <- HBS.opfact
      timeper <- "md"
      ma.hhcov <- ma.ophhcov
      ma.empcov <- ma.opempcov
    }

### HBS Drive Alone Utility 

# HBS Drive Alone Utility
    mf.base <- (HBS.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + sweep(cc * mf.Sopcost, 2, HBS.da.walkCoeff * ma.auov, "+") + pktc * mf.Spocketcost)

# HBS Drive Alone Utility cv0 (No Cars) *** NEW ***
    mf.dautil.cv0 <- exp(mf.base + HBS.da.cv0)

# HBS Drive Alone Utility cv1 (Cars < Workers) *** NEW ***
    mf.dautil.cv1 <- exp(mf.base + HBS.da.cv1)

# HBS Drive Alone Utility cv2 & cv3 (Cars >= Workers) *** NEW ***
    mf.dautil.cv23 <- exp(mf.base + HBS.da.cv23)


### Drive with Passenger Utilities

# Base HBS Drive with Passenger Utility
    mf.base <- (HBS.MC.dpconst + HBS.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBS.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBS.dp.walkCoeff * ma.auov, "+"))

# 1 Person Household HBS Drive with Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.dputil.hh1.cv0 <- exp(mf.base + HBS.dp.hh1 + HBS.dp.cv0)

# 1 Person Household HBS Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh1.cv1 <- exp(mf.base + HBS.dp.hh1 + HBS.dp.cv1)

# 1 Person Household HBS Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh1.cv23 <- exp(mf.base + HBS.dp.hh1 + HBS.dp.cv23)

# 2 Person Household HBS Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh2.cv0 <- exp(mf.base + HBS.dp.hh2 + HBS.dp.cv0)

# 2 Person Household HBS Drive with Passenger Utility cv1 (Cars < Workers) *** NEW ***
    mf.dputil.hh2.cv1 <- exp(mf.base + HBS.dp.hh2 + HBS.dp.cv1)
    
# 2 Person Household HBS Drive with Passenger Utility cv2 & cv3 (Cars >= Workers) *** NEW *** 
    mf.dputil.hh2.cv23 <- exp(mf.base + HBS.dp.hh2 + HBS.dp.cv23)

# 3+ Person Household HBS Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh34.cv0 <- exp(mf.base + HBS.dp.hh34 + HBS.dp.cv0)

# 3+ Person Household HBS Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh34.cv1 <- exp(mf.base + HBS.dp.hh34 + HBS.dp.cv1)

# 3+ Person Household HBS Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh34.cv23 <- exp(mf.base + HBS.dp.hh34 + HBS.dp.cv23)


### Passenger Utilities

# Base HBS Passenger Utility
    mf.base <- (HBS.MC.paconst + HBS.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) + 
          sweep(HBS.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBS.pa.walkCoeff * ma.auov, "+"))

# 1 Person Household HBS Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.pautil.hh1.cv0 <- exp(mf.base + HBS.pa.hh1 + HBS.pa.cv0)

# 1 Person Household HBS Passenger Utility cv123 (Cars > 0) *** EDITED ***
    mf.pautil.hh1.cv123 <- exp(mf.base + HBS.pa.hh1 + HBS.pa.cv123)

# 2 Person Household HBS Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh2.cv0 <- exp(mf.base + HBS.pa.hh2 + HBS.pa.cv0)
    
# 2 Person Household HBS Passenger Utility cv123 (Cars > 0) *** NEW ***
    mf.pautil.hh2.cv123 <- exp(mf.base + HBS.pa.hh2 + HBS.pa.cv123)

# 3+ Person Household HBS Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh34.cv0 <- exp(mf.base + HBS.pa.hh34 + HBS.pa.cv0)

# 3+ Person Household HBS Passenger Utility cv123 (Cars > 0)
    mf.pautil.hh34.cv123 <- exp(mf.base + HBS.pa.hh34 + HBS.pa.cv123)


### HBS Transit Utilities

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

# Base HBS Transit Utility
    ivt     <- HBS.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- HBS.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- HBS.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.base <- (trconst + ivt + HBS.tr.wait1Coeff * mf.trwait1 + HBS.tr.wait2Coeff * mf.trwait2 + HBS.tr.walkCoeff * mf.trwalk + HBS.tr.transCoeff * mf.transfers +
          sweep(faresc * mf.trfare, 2, HBS.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") +
          sweep(oviv, 1, HBS.tr.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.base[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBS Transit Utility cv0 (No Cars)
    mf.trutil.cv0 <- exp(mf.base + HBS.tr.cv0)
    mf.trutil.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBS Transit Utility cv1 (Cars < Workers)
    mf.trutil.cv1 <- exp(mf.base + HBS.tr.cv1)
    mf.trutil.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBS Transit Utility cv2 (Cars = Workers)
    mf.trutil.cv2 <- exp(mf.base + HBS.tr.cv2)
    mf.trutil.cv2[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBS Transit Utility cv3 (Cars > Workers)
    mf.trutil.cv3 <- exp(mf.base + HBS.tr.cv3)
    mf.trutil.cv3[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0


### HBS Park and Ride Transit Utility

    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbs"
    paramSet$cv <- "" 
    paramSet$cvConstant <- PNR.cvConstant 
    #constants
    paramSet$formalConstant <- HBS.formalConstant
    paramSet$informalConstant <- HBS.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff

    mf.prtutil <- calcPNRUtils(timeper, inc, project.dir, HBS.MC.prconst, 1, numzones, paramSet)


### HBS Bike Utility
    mf.bkutil <- exp(sweep(HBS.MC.bikeconst + HBS.bk.inbikeCoeff * mf.inbike + HBS.bk.ubdistCoeff * mf.ubdist + HBS.bk.nbcostCoeff * mf.nbcost, 2, HBS.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


### HBS Walk Utilities
    mf.wkutil <- exp(sweep(HBS.MC.walkconst + HBS.wk.walkCoeff * mf.wtime, 1, HBS.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


##### Compute Total Utilities and Save in Temporary Matrices 

print("Calculating total utilities")

# HBS Utility - HH1, CV0, w/o Transit
    mf.ut.hh1.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh1.cv0 + mf.pautil.hh1.cv0 + mf.bkutil + mf.wkutil)

# HBS Utility - HH1, CV0, w/ Transit
    mf.ut.hh1.cv0.withtr <- (mf.ut.hh1.cv0.notr + mf.trutil.cv0)

# HBS Utility - HH1, CV1, w/o Transit or PnR
    mf.ut.hh1.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh1.cv1 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH1, CV1, all modes
    mf.ut.hh1.cv1.all <- (mf.ut.hh1.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBS Utility - HH1, CV1, w/o Transit
    mf.ut.hh1.cv1.notr <- (mf.ut.hh1.cv1.notrpr + mf.prtutil)

# HBS Utility - HH1, CV2, w/o Transit or PnR
    mf.ut.hh1.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH1, CV2, all modes
    mf.ut.hh1.cv2.all <- (mf.ut.hh1.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBS Utility - HH1, CV2, w/o Transit
    mf.ut.hh1.cv2.notr <- (mf.ut.hh1.cv2.notrpr + mf.prtutil)

# HBS Utility - HH1, CV3, w/o Transit or PnR
    mf.ut.hh1.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH1, CV3, all modes
    mf.ut.hh1.cv3.all <- (mf.ut.hh1.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBS Utility - HH1, CV3, w/o Transit
    mf.ut.hh1.cv3.notr <- (mf.ut.hh1.cv3.notrpr + mf.prtutil)

# HBS Utility - HH2, CV0, w/o Transit
    mf.ut.hh2.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh2.cv0 + mf.pautil.hh2.cv0 + mf.bkutil + mf.wkutil)

# HBS Utility - HH2, CV0, w/ Transit
    mf.ut.hh2.cv0.withtr <- (mf.ut.hh2.cv0.notr + mf.trutil.cv0)

# HBS Utility - HH2, CV1, w/o Transit or PnR
    mf.ut.hh2.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh2.cv1 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH2, CV1, all modes
    mf.ut.hh2.cv1.all <- (mf.ut.hh2.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBS Utility - HH2, CV1, w/o Transit
    mf.ut.hh2.cv1.notr <- (mf.ut.hh2.cv1.notrpr + mf.prtutil)

# HBS Utility - HH2, CV2, w/o Transit or PnR
    mf.ut.hh2.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH2, CV2, all modes
    mf.ut.hh2.cv2.all <- (mf.ut.hh2.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBS Utility - HH2, CV2, w/o Transit
    mf.ut.hh2.cv2.notr <- (mf.ut.hh2.cv2.notrpr + mf.prtutil)

# HBS Utility - HH2, CV3, w/o Transit or PnR
    mf.ut.hh2.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH2, CV3, all modes
    mf.ut.hh2.cv3.all <- (mf.ut.hh2.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBS Utility - HH2, CV3, w/o Transit
    mf.ut.hh2.cv3.notr <- (mf.ut.hh2.cv3.notrpr + mf.prtutil)

# HBS Utility - HH34, CV0, w/o Transit
    mf.ut.hh34.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh34.cv0 + mf.pautil.hh34.cv0 + mf.bkutil + mf.wkutil)

# HBS Utility - HH34, CV0, w/ Transit
    mf.ut.hh34.cv0.withtr <- (mf.ut.hh34.cv0.notr + mf.trutil.cv0)

# HBS Utility - HH34, CV1, w/o Transit or PnR
    mf.ut.hh34.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh34.cv1 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH34, CV1, all modes
    mf.ut.hh34.cv1.all <- (mf.ut.hh34.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBS Utility - HH34, CV1, w/o Transit
    mf.ut.hh34.cv1.notr <- (mf.ut.hh34.cv1.notrpr + mf.prtutil)

# HBS Utility - HH34, CV2, w/o Transit or PnR
    mf.ut.hh34.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH34, CV2, all modes
    mf.ut.hh34.cv2.all <- (mf.ut.hh34.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBS Utility - HH34, CV2, w/o Transit
    mf.ut.hh34.cv2.notr <- (mf.ut.hh34.cv2.notrpr + mf.prtutil)

# HBS Utility - HH34, CV3, w/o Transit or PnR
    mf.ut.hh34.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBS Utility - HH34, CV3, all modes
    mf.ut.hh34.cv3.all <- (mf.ut.hh34.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBS Utility - HH34, CV3, w/o Transit
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


# HBS Temporary Utility - HH1, CV0
   mf.tmput.hh1.cv0 <- (mf.trok / mf.ut.hh1.cv0.withtr + mf.prok / mf.ut.hh1.cv0.notr + mf.trno / mf.ut.hh1.cv0.notr)

# HBS Temporary Utility - HH1, CV1
    mf.tmput.hh1.cv1 <- (mf.trok / mf.ut.hh1.cv1.all + mf.prok / mf.ut.hh1.cv1.notr + mf.trno / mf.ut.hh1.cv1.notrpr)

# HBS Temporary Utility - HH1, CV2
    mf.tmput.hh1.cv2 <- (mf.trok / mf.ut.hh1.cv2.all + mf.prok / mf.ut.hh1.cv2.notr + mf.trno / mf.ut.hh1.cv2.notrpr)

# HBS Temporary Utility - HH1, CV3
    mf.tmput.hh1.cv3 <- (mf.trok / mf.ut.hh1.cv3.all + mf.prok / mf.ut.hh1.cv3.notr + mf.trno / mf.ut.hh1.cv3.notrpr)

# HBS Temporary Utility - HH2, CV0
    mf.tmput.hh2.cv0 <- (mf.trok / mf.ut.hh2.cv0.withtr + mf.prok / mf.ut.hh2.cv0.notr + mf.trno / mf.ut.hh2.cv0.notr)

# HBS Temporary Utility - HH2, CV1
    mf.tmput.hh2.cv1 <- (mf.trok / mf.ut.hh2.cv1.all + mf.prok / mf.ut.hh2.cv1.notr + mf.trno / mf.ut.hh2.cv1.notrpr)

# HBS Temporary Utility - HH2, CV2
    mf.tmput.hh2.cv2 <- (mf.trok / mf.ut.hh2.cv2.all + mf.prok / mf.ut.hh2.cv2.notr + mf.trno / mf.ut.hh2.cv2.notrpr)

# HBS Temporary Utility - HH2, CV3
    mf.tmput.hh2.cv3 <- (mf.trok / mf.ut.hh2.cv3.all + mf.prok / mf.ut.hh2.cv3.notr + mf.trno / mf.ut.hh2.cv3.notrpr)

# HBS Temporary Utility - HH34, CV0
    mf.tmput.hh34.cv0 <- (mf.trok / mf.ut.hh34.cv0.withtr + mf.prok / mf.ut.hh34.cv0.notr + mf.trno / mf.ut.hh34.cv0.notr)

# HBS Temporary Utility - HH34, CV1
    mf.tmput.hh34.cv1 <- (mf.trok / mf.ut.hh34.cv1.all + mf.prok / mf.ut.hh34.cv1.notr + mf.trno / mf.ut.hh34.cv1.notrpr)

# HBS Temporary Utility - HH34, CV2
    mf.tmput.hh34.cv2 <- (mf.trok / mf.ut.hh34.cv2.all + mf.prok / mf.ut.hh34.cv2.notr + mf.trno / mf.ut.hh34.cv2.notrpr)

# HBS Temporary Utility - HH34, CV3
    mf.tmput.hh34.cv3 <- (mf.trok / mf.ut.hh34.cv3.all + mf.prok / mf.ut.hh34.cv3.notr + mf.trno / mf.ut.hh34.cv3.notrpr)


### HBS Drive Alone Person Trips

# HBS Drive Alone Person Trips - CV0 
    mf.hsda.cv0 <- ((
                     mf.dautil.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbsA0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbsB0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbsC0",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Drive Alone Person Trips - CV1 
    mf.hsda.cv1 <- ((
                     mf.dautil.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hbsA1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hbsB1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hbsC1",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Drive Alone Person Trips - CV23 
    mf.hsda.cv23 <- ((
                      mf.dautil.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hbsA2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hbsA3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hbsB2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hbsB3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hbsC2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hbsC3",inc,sep=''))) *
                      get(paste("mf.hbsdt",inc,sep='')) * todfact)
  
# Raw HBS Drive Alone Trips
    assign(paste("mf.hsda",inc,timeper,sep="."), mf.hsda.cv0 + mf.hsda.cv1 + mf.hsda.cv23)

    assign(paste("mf.hsda.cv0",inc,timeper,sep="."), mf.hsda.cv0)
    assign(paste("mf.hsda.cv1",inc,timeper,sep="."), mf.hsda.cv1)
    assign(paste("mf.hsda.cv23",inc,timeper,sep="."), mf.hsda.cv23)

    rm (mf.hsda.cv0, mf.hsda.cv1, mf.hsda.cv23, mf.dautil.cv0, mf.dautil.cv1, mf.dautil.cv23)


### HBS Drive with Passenger Person Trips

# HBS Drive with Passenger Person Trips - CV0
    mf.hsdp.cv0 <- ((
                     mf.dputil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbsA0",inc,sep='')) +
                     mf.dputil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbsB0",inc,sep='')) +
                     mf.dputil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbsC0",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Drive with Passenger Person Trips - CV1
    mf.hsdp.cv1 <- ((
                     mf.dputil.hh1.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hbsA1",inc,sep='')) +
                     mf.dputil.hh2.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hbsB1",inc,sep='')) +
                     mf.dputil.hh34.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hbsC1",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Drive with Passenger Person Trips - CV23
    mf.hsdp.cv23 <- ((
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hbsA2",inc,sep='')) +
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hbsA3",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hbsB2",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hbsB3",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hbsC2",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hbsC3",inc,sep=''))) *
                      get(paste("mf.hbsdt",inc,sep='')) * todfact)

# Raw HBS Drive with Passenger Trips
    assign(paste("mf.hsdp",inc,timeper,sep="."), mf.hsdp.cv0 + mf.hsdp.cv1 + mf.hsdp.cv23)

    assign(paste("mf.hsdp.cv0",inc,timeper,sep="."), mf.hsdp.cv0)
    assign(paste("mf.hsdp.cv1",inc,timeper,sep="."), mf.hsdp.cv1)
    assign(paste("mf.hsdp.cv23",inc,timeper,sep="."), mf.hsdp.cv23)

    rm (mf.hsdp.cv0, mf.hsdp.cv1, mf.hsdp.cv23,
        mf.dputil.hh1.cv0, mf.dputil.hh1.cv1, mf.dputil.hh1.cv23,
        mf.dputil.hh2.cv0, mf.dputil.hh2.cv1, mf.dputil.hh2.cv23,
        mf.dputil.hh34.cv0, mf.dputil.hh34.cv1, mf.dputil.hh34.cv23)


### HBS Passenger Person Trips

# HBS Passenger Person Trips - CV0
    mf.hspa.cv0 <- ((
                     mf.pautil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hbsA0",inc,sep='')) +
                     mf.pautil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hbsB0",inc,sep='')) +
                     mf.pautil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hbsC0",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Passenger Person Trips - CV1
    mf.hspa.cv1 <- (( 
                     mf.pautil.hh1.cv123 * mf.tmput.hh1.cv1 * get(paste("md.hbsA1",inc,sep='')) +
                     mf.pautil.hh2.cv123 * mf.tmput.hh2.cv1 * get(paste("md.hbsB1",inc,sep='')) +
                     mf.pautil.hh34.cv123 * mf.tmput.hh34.cv1 * get(paste("md.hbsC1",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Passenger Person Trips - CV23
    mf.hspa.cv23 <- ((
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv2 * get(paste("md.hbsA2",inc,sep='')) +
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv3 * get(paste("md.hbsA3",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv2 * get(paste("md.hbsB2",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv3 * get(paste("md.hbsB3",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv2 * get(paste("md.hbsC2",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv3 * get(paste("md.hbsC3",inc,sep=''))) *
                      get(paste("mf.hbsdt",inc,sep='')) * todfact)

# Raw HBS Passenger Trips
    assign(paste("mf.hspa",inc,timeper,sep="."), mf.hspa.cv0 + mf.hspa.cv1 + mf.hspa.cv23)

    assign(paste("mf.hspa.cv0",inc,timeper,sep="."), mf.hspa.cv0)
    assign(paste("mf.hspa.cv1",inc,timeper,sep="."), mf.hspa.cv1)
    assign(paste("mf.hspa.cv23",inc,timeper,sep="."), mf.hspa.cv23)

    rm (mf.hspa.cv0, mf.hspa.cv1, mf.hspa.cv23,
        mf.pautil.hh1.cv0, mf.pautil.hh1.cv123,
        mf.pautil.hh2.cv0, mf.pautil.hh2.cv123,
        mf.pautil.hh34.cv0, mf.pautil.hh34.cv123)


### HBS Transit Person Trips

# HBS Transit Person Trips - CV0
    mf.hstr.cv0 <- ((
                    (mf.trutil.cv0 / mf.ut.hh1.cv0.withtr) * get(paste("md.hbsA0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh2.cv0.withtr) * get(paste("md.hbsB0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh34.cv0.withtr) * get(paste("md.hbsC0",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbsdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBS Transit Person Trips - CV1
    mf.hstr.cv1 <- ((
                    (mf.trutil.cv1 / mf.ut.hh1.cv1.all) * get(paste("md.hbsA1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh2.cv1.all) * get(paste("md.hbsB1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh34.cv1.all) * get(paste("md.hbsC1",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbsdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBS Transit Person Trips - Household Size = 2, CV 1-3
    mf.hstr.cv23 <- ((
                     (mf.trutil.cv2 / mf.ut.hh1.cv2.all) * get(paste("md.hbsA2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh1.cv3.all) * get(paste("md.hbsA3",inc,sep='')) +
                     (mf.trutil.cv2 / mf.ut.hh2.cv2.all) * get(paste("md.hbsB2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh2.cv3.all) * get(paste("md.hbsB3",inc,sep='')) + 
                     (mf.trutil.cv2 / mf.ut.hh34.cv2.all) * get(paste("md.hbsC2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh34.cv3.all) * get(paste("md.hbsC3",inc,sep=''))) *
                      sweep(todfact * get(paste("mf.hbsdt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# Raw HBS Transit Person Trips
    assign(paste("mf.hstr",inc,timeper,sep="."), mf.hstr.cv0 + mf.hstr.cv1 + mf.hstr.cv23)

    assign(paste("mf.hstr.cv0",inc,timeper,sep="."), mf.hstr.cv0)
    assign(paste("mf.hstr.cv1",inc,timeper,sep="."), mf.hstr.cv1)
    assign(paste("mf.hstr.cv23",inc,timeper,sep="."), mf.hstr.cv23)

    rm (mf.hstr.cv0, mf.hstr.cv1, mf.hstr.cv23, mf.trutil.cv0, mf.trutil.cv1, mf.trutil.cv2, mf.trutil.cv3)


### HBS Park and Ride Transit Person Trips

    mf.hsprtr.cw.cv1 <- (mf.prtutil * (
                         mf.trok / mf.ut.hh1.cv1.all * get(paste("md.hbsA1",inc,sep='')) +
                         mf.trok / mf.ut.hh2.cv1.all * get(paste("md.hbsB1",inc,sep='')) +
                         mf.trok / mf.ut.hh34.cv1.all * get(paste("md.hbsC1",inc,sep=''))) *
                         get(paste("mf.hbsdt",inc,sep='')) * todfact)

    mf.hsprtr.cw.cv23 <- (mf.prtutil * (
                          mf.trok / mf.ut.hh1.cv2.all * get(paste("md.hbsA2",inc,sep='')) +
                          mf.trok / mf.ut.hh1.cv3.all * get(paste("md.hbsA3",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv2.all * get(paste("md.hbsB2",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv3.all * get(paste("md.hbsB3",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv2.all * get(paste("md.hbsC2",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv3.all * get(paste("md.hbsC3",inc,sep=''))) *
                          get(paste("mf.hbsdt",inc,sep='')) * todfact)

    mf.hsprtr.md.cv1 <- (mf.prtutil * (
                         mf.prok / mf.ut.hh1.cv1.notr * get(paste("md.hbsA1",inc,sep='')) +
                         mf.prok / mf.ut.hh2.cv1.notr * get(paste("md.hbsB1",inc,sep='')) +
                         mf.prok / mf.ut.hh34.cv1.notr * get(paste("md.hbsC1",inc,sep=''))) *
                         get(paste("mf.hbsdt",inc,sep='')) * todfact)

    mf.hsprtr.md.cv23 <- (mf.prtutil * (
                          mf.prok / mf.ut.hh1.cv2.notr * get(paste("md.hbsA2",inc,sep='')) +
                          mf.prok / mf.ut.hh1.cv3.notr * get(paste("md.hbsA3",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv2.notr * get(paste("md.hbsB2",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv3.notr * get(paste("md.hbsB3",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv2.notr * get(paste("md.hbsC2",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv3.notr * get(paste("md.hbsC3",inc,sep=''))) *
                          get(paste("mf.hbsdt",inc,sep='')) * todfact)

# Raw HBS Park and Ride Transit Trips
    assign(paste("mf.hsprtr",inc,timeper,sep="."), mf.hsprtr.cw.cv1 + mf.hsprtr.md.cv1 + mf.hsprtr.cw.cv23 + mf.hsprtr.md.cv23)
    assign(paste("mf.hsprtr.cv1",inc,timeper,sep="."), mf.hsprtr.cw.cv1 + mf.hsprtr.md.cv1)
    assign(paste("mf.hsprtr.cv23",inc,timeper,sep="."), mf.hsprtr.cw.cv23 +  mf.hsprtr.md.cv23)
    assign(paste("mf.hsprtr.cw.cv1",inc,timeper,sep="."), mf.hsprtr.cw.cv1)
    assign(paste("mf.hsprtr.cw.cv23",inc,timeper,sep="."), mf.hsprtr.cw.cv23)
    assign(paste("mf.hsprtr.md.cv1",inc,timeper,sep="."), mf.hsprtr.md.cv1)
    assign(paste("mf.hsprtr.md.cv23",inc,timeper,sep="."), mf.hsprtr.md.cv23)
    rm (mf.prtutil)

#allocate trips to lots
    allocateTripsToLots(get(paste("mf.hsprtr",inc,timeper,sep=".")), project.dir, 1, numzones, HBS.vehOccFactor, "hbs")


### HBS Bike Person Trips

# HBS Bike Person Trips - CV0
    mf.hsbk.cv0 <- (mf.bkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hbsA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hbsB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hbsC0",inc,sep=''))) *
                    get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Bike Person Trips - CV1
    mf.hsbk.cv1 <- (mf.bkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hbsA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hbsB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hbsC1",inc,sep=''))) *
                    get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Bike Person Trips - CV23
    mf.hsbk.cv23 <- (mf.bkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hbsA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hbsA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hbsB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hbsB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hbsC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hbsC3",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# Raw HBS Bike Trips
    assign(paste("mf.hsbike",inc,timeper,sep="."), mf.hsbk.cv0 + mf.hsbk.cv1 + mf.hsbk.cv23)

    assign(paste("mf.hsbike.cv0",inc,timeper,sep="."), mf.hsbk.cv0)
    assign(paste("mf.hsbike.cv1",inc,timeper,sep="."), mf.hsbk.cv1)
    assign(paste("mf.hsbike.cv23",inc,timeper,sep="."), mf.hsbk.cv23)

    rm(mf.hsbk.cv0, mf.hsbk.cv1, mf.hsbk.cv23, mf.bkutil)


### HBS Walk Person Trips

# HBS Walk Person Trips - CV0
    mf.hswk.cv0 <- (mf.wkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hbsA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hbsB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hbsC0",inc,sep=''))) *
                    get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Walk Person Trips - CV1
    mf.hswk.cv1 <- (mf.wkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hbsA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hbsB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hbsC1",inc,sep=''))) *
                    get(paste("mf.hbsdt",inc,sep='')) * todfact)

# HBS Walk Person Trips - CV23
    mf.hswk.cv23 <- (mf.wkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hbsA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hbsA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hbsB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hbsB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hbsC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hbsC3",inc,sep=''))) *
                     get(paste("mf.hbsdt",inc,sep='')) * todfact)

# Raw HBS Walk Trips
    assign(paste("mf.hswalk",inc,timeper,sep="."), mf.hswk.cv0 + mf.hswk.cv1 + mf.hswk.cv23)

    assign(paste("mf.hswalk.cv0",inc,timeper,sep="."), mf.hswk.cv0)
    assign(paste("mf.hswalk.cv1",inc,timeper,sep="."), mf.hswk.cv1)
    assign(paste("mf.hswalk.cv23",inc,timeper,sep="."), mf.hswk.cv23)

    rm(mf.hswk.cv0, mf.hswk.cv1, mf.hswk.cv23, mf.wkutil)

#  REMOVE the Total and Temporary Utilities

    rm(mf.hhcov, mf.trok, mf.prok, mf.trno)
    rm(list=ls()[grep(("mf.tmput"),ls())])
    rm(list=ls()[grep(("mf.ut"),ls())])

  }   ##  END OF TIME OF DAY LOOP

}     ##  END OF INCOME LOOP

detach(malist.hbs)
