# k.hboms.R
# HBO Mode Choice

print("Running hbo mode choice")

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.hbodtl.dat")
load("mf.hbodtm.dat")
load("mf.hbodth.dat")
load("malist.hbo.dat")
attach(malist.hbo)

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
  mf.Spocketcost <- sweep((HBO.pkfact*mf.amstlD + HBO.opfact*mf.mdstlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBO.pkfact*mf.amhtlD + HBO.opfact*mf.mdhtlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBO.low.cc     # auto operating costs coeff
    pktc   <- HBO.low.pktc   # auto out of pocket costs: parking and tolls coeff
    faresc <- HBO.low.faresc # transit fares coeff
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBO.medium.cc      # auto operating costs coeff
    pktc   <- HBO.medium.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBO.medium.faresc  # transit fares coeff
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBO.high.cc      # auto operating costs coeff
    pktc   <- HBO.high.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBO.high.faresc  # transit fares coeff
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact <- HBO.pkfact
      timeper <- "am"
      ma.hhcov <- ma.pkhhcov
      ma.empcov <- ma.pkempcov
    }
    if (y==2) {
      todfact <- HBO.opfact
      timeper <- "md"
      ma.hhcov <- ma.ophhcov
      ma.empcov <- ma.opempcov
    }

### HBO Drive Alone Utility 

# HBO Drive Alone Utility
    mf.base <- (HBO.ivCoeff * get(paste("mf.",timeper,"stt",sep='')) + sweep(cc * mf.Sopcost, 2, HBO.da.walkCoeff * ma.auov, "+") + pktc * mf.Spocketcost)

# HBO Drive Alone Utility cv0 (No Cars) *** NEW ***
    mf.dautil.cv0 <- exp(mf.base + HBO.da.cv0)

# HBO Drive Alone Utility cv1 (Cars < Workers) *** NEW ***
    mf.dautil.cv1 <- exp(mf.base + HBO.da.cv1)

# HBO Drive Alone Utility cv2 & cv3 (Cars >= Workers) *** NEW ***
    mf.dautil.cv23 <- exp(mf.base + HBO.da.cv23)


### Drive with Passenger Utilities

# Base HBO Drive with Passenger Utility
    mf.base <- (HBO.MC.dpconst + HBO.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBO.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBO.dp.walkCoeff * ma.auov, "+"))

# 1 Person Household HBO Drive with Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.dputil.hh1.cv0 <- exp(mf.base + HBO.dp.hh1 + HBO.dp.cv0)

# 1 Person Household HBO Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh1.cv1 <- exp(mf.base + HBO.dp.hh1 + HBO.dp.cv1)

# 1 Person Household HBO Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh1.cv23 <- exp(mf.base + HBO.dp.hh1 + HBO.dp.cv23)

# 2 Person Household HBO Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh2.cv0 <- exp(mf.base + HBO.dp.hh2 + HBO.dp.cv0)

# 2 Person Household HBO Drive with Passenger Utility cv1 (Cars < Workers) *** NEW ***
    mf.dputil.hh2.cv1 <- exp(mf.base + HBO.dp.hh2 + HBO.dp.cv1)
    
# 2 Person Household HBO Drive with Passenger Utility cv2 & cv3 (Cars >= Workers) *** NEW *** 
    mf.dputil.hh2.cv23 <- exp(mf.base + HBO.dp.hh2 + HBO.dp.cv23)

# 3+ Person Household HBO Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.hh34.cv0 <- exp(mf.base + HBO.dp.hh34 + HBO.dp.cv0)

# 3+ Person Household HBO Drive with Passenger Utility cv1 (Cars < Workers)
    mf.dputil.hh34.cv1 <- exp(mf.base + HBO.dp.hh34 + HBO.dp.cv1)

# 3+ Person Household HBO Drive with Passenger Utility cv2 & cv3 (Cars >= Workers)
    mf.dputil.hh34.cv23 <- exp(mf.base + HBO.dp.hh34 + HBO.dp.cv23)


### Passenger Utilities

# Base HBO Passenger Utility
    mf.base <- (HBO.MC.paconst + HBO.ivCoeff * get(paste("mf.",timeper,"htt",sep='')) +
          sweep(HBO.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBO.pa.walkCoeff * ma.auov, "+"))

# 1 Person Household HBO Passenger Utility cv0 (No Cars)  *** NEW ***
    mf.pautil.hh1.cv0 <- exp(mf.base + HBO.pa.hh1 + HBO.pa.cv0)

# 1 Person Household HBO Passenger Utility cv123 (Cars > 0) *** EDITED ***
    mf.pautil.hh1.cv123 <- exp(mf.base + HBO.pa.hh1 + HBO.pa.cv123)

# 2 Person Household HBO Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh2.cv0 <- exp(mf.base + HBO.pa.hh2 + HBO.pa.cv0)
    
# 2 Person Household HBO Passenger Utility cv123 (Cars > 0) *** NEW ***
    mf.pautil.hh2.cv123 <- exp(mf.base + HBO.pa.hh2 + HBO.pa.cv123)

# 3+ Person Household HBO Passenger Utility cv0 (No Cars) *** NEW ***
    mf.pautil.hh34.cv0 <- exp(mf.base + HBO.pa.hh34 + HBO.pa.cv0)

# 3+ Person Household HBO Passenger Utility cv123 (Cars > 0)
    mf.pautil.hh34.cv123 <- exp(mf.base + HBO.pa.hh34 + HBO.pa.cv123)


### HBO Transit Utilities

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

# Base HBO Transit Utility
    ivt     <- HBO.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- HBO.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- HBO.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.base <- (trconst + ivt + HBO.tr.wait1Coeff * mf.trwait1 + HBO.tr.wait2Coeff * mf.trwait2 + HBO.tr.walkCoeff * mf.trwalk + HBO.tr.transCoeff * mf.transfers +
          sweep(faresc * mf.trfare, 2, HBO.tr.logMixTotACoeff * log(ma.mixthm + 1), "+") +
          sweep(oviv, 1, HBO.tr.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.base[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBO Transit Utility cv0 (No Cars)
    mf.trutil.cv0 <- exp(mf.base + HBO.tr.cv0)
    mf.trutil.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBO Transit Utility cv1 (Cars < Workers)
    mf.trutil.cv1 <- exp(mf.base + HBO.tr.cv1)
    mf.trutil.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBO Transit Utility cv2 (Cars = Workers)
    mf.trutil.cv2 <- exp(mf.base + HBO.tr.cv2)
    mf.trutil.cv2[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBO Transit Utility cv3 (Cars > Workers)
    mf.trutil.cv3 <- exp(mf.base + HBO.tr.cv3)
    mf.trutil.cv3[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0


### HBO Park and Ride Transit Utility

    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbo"
    paramSet$cv <- "" 
    paramSet$cvConstant <- PNR.cvConstant 
    #constants
    paramSet$formalConstant <- HBO.formalConstant
    paramSet$informalConstant <- HBO.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff

    mf.prtutil <- calcPNRUtils(timeper, inc, project.dir, HBO.MC.prconst, 1, numzones, paramSet)


### HBO Bike Utility
    mf.bkutil <- exp(sweep(HBO.MC.bikeconst + HBO.bk.inbikeCoeff * mf.inbike + HBO.bk.ubdistCoeff * mf.ubdist + HBO.bk.nbcostCoeff * mf.nbcost, 2, HBO.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


### HBO Walk Utilities
    mf.wkutil <- exp(sweep(HBO.MC.walkconst + HBO.wk.walkCoeff * mf.wtime, 1, HBO.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


##### Compute Total Utilities and Save in Temporary Matrices 

print("Calculating total utilities")

# HBO Utility - HH1, CV0, w/o Transit
    mf.ut.hh1.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh1.cv0 + mf.pautil.hh1.cv0 + mf.bkutil + mf.wkutil)

# HBO Utility - HH1, CV0, w/ Transit
    mf.ut.hh1.cv0.withtr <- (mf.ut.hh1.cv0.notr + mf.trutil.cv0)

# HBO Utility - HH1, CV1, w/o Transit or PnR
    mf.ut.hh1.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh1.cv1 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH1, CV1, all modes
    mf.ut.hh1.cv1.all <- (mf.ut.hh1.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBO Utility - HH1, CV1, w/o Transit
    mf.ut.hh1.cv1.notr <- (mf.ut.hh1.cv1.notrpr + mf.prtutil)

# HBO Utility - HH1, CV2, w/o Transit or PnR
    mf.ut.hh1.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH1, CV2, all modes
    mf.ut.hh1.cv2.all <- (mf.ut.hh1.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBO Utility - HH1, CV2, w/o Transit
    mf.ut.hh1.cv2.notr <- (mf.ut.hh1.cv2.notrpr + mf.prtutil)

# HBO Utility - HH1, CV3, w/o Transit or PnR
    mf.ut.hh1.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh1.cv23 + mf.pautil.hh1.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH1, CV3, all modes
    mf.ut.hh1.cv3.all <- (mf.ut.hh1.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBO Utility - HH1, CV3, w/o Transit
    mf.ut.hh1.cv3.notr <- (mf.ut.hh1.cv3.notrpr + mf.prtutil)

# HBO Utility - HH2, CV0, w/o Transit
    mf.ut.hh2.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh2.cv0 + mf.pautil.hh2.cv0 + mf.bkutil + mf.wkutil)

# HBO Utility - HH2, CV0, w/ Transit
    mf.ut.hh2.cv0.withtr <- (mf.ut.hh2.cv0.notr + mf.trutil.cv0)

# HBO Utility - HH2, CV1, w/o Transit or PnR
    mf.ut.hh2.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh2.cv1 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH2, CV1, all modes
    mf.ut.hh2.cv1.all <- (mf.ut.hh2.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBO Utility - HH2, CV1, w/o Transit
    mf.ut.hh2.cv1.notr <- (mf.ut.hh2.cv1.notrpr + mf.prtutil)

# HBO Utility - HH2, CV2, w/o Transit or PnR
    mf.ut.hh2.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH2, CV2, all modes
    mf.ut.hh2.cv2.all <- (mf.ut.hh2.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBO Utility - HH2, CV2, w/o Transit
    mf.ut.hh2.cv2.notr <- (mf.ut.hh2.cv2.notrpr + mf.prtutil)

# HBO Utility - HH2, CV3, w/o Transit or PnR
    mf.ut.hh2.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh2.cv23 + mf.pautil.hh2.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH2, CV3, all modes
    mf.ut.hh2.cv3.all <- (mf.ut.hh2.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBO Utility - HH2, CV3, w/o Transit
    mf.ut.hh2.cv3.notr <- (mf.ut.hh2.cv3.notrpr + mf.prtutil)

# HBO Utility - HH34, CV0, w/o Transit
    mf.ut.hh34.cv0.notr <- (mf.dautil.cv0 + mf.dputil.hh34.cv0 + mf.pautil.hh34.cv0 + mf.bkutil + mf.wkutil)

# HBO Utility - HH34, CV0, w/ Transit
    mf.ut.hh34.cv0.withtr <- (mf.ut.hh34.cv0.notr + mf.trutil.cv0)

# HBO Utility - HH34, CV1, w/o Transit or PnR
    mf.ut.hh34.cv1.notrpr <- (mf.dautil.cv1 + mf.dputil.hh34.cv1 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH34, CV1, all modes
    mf.ut.hh34.cv1.all <- (mf.ut.hh34.cv1.notrpr + mf.prtutil + mf.trutil.cv1)

# HBO Utility - HH34, CV1, w/o Transit
    mf.ut.hh34.cv1.notr <- (mf.ut.hh34.cv1.notrpr + mf.prtutil)

# HBO Utility - HH34, CV2, w/o Transit or PnR
    mf.ut.hh34.cv2.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH34, CV2, all modes
    mf.ut.hh34.cv2.all <- (mf.ut.hh34.cv2.notrpr + mf.prtutil + mf.trutil.cv2)

# HBO Utility - HH34, CV2, w/o Transit
    mf.ut.hh34.cv2.notr <- (mf.ut.hh34.cv2.notrpr + mf.prtutil)

# HBO Utility - HH34, CV3, w/o Transit or PnR
    mf.ut.hh34.cv3.notrpr <- (mf.dautil.cv23 + mf.dputil.hh34.cv23 + mf.pautil.hh34.cv123 + mf.bkutil + mf.wkutil)

# HBO Utility - HH34, CV3, all modes
    mf.ut.hh34.cv3.all <- (mf.ut.hh34.cv3.notrpr + mf.prtutil + mf.trutil.cv3)

# HBO Utility - HH34, CV3, w/o Transit
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


# HBO Temporary Utility - HH1, CV0
   mf.tmput.hh1.cv0 <- (mf.trok / mf.ut.hh1.cv0.withtr + mf.prok / mf.ut.hh1.cv0.notr + mf.trno / mf.ut.hh1.cv0.notr)

# HBO Temporary Utility - HH1, CV1
    mf.tmput.hh1.cv1 <- (mf.trok / mf.ut.hh1.cv1.all + mf.prok / mf.ut.hh1.cv1.notr + mf.trno / mf.ut.hh1.cv1.notrpr)

# HBO Temporary Utility - HH1, CV2
    mf.tmput.hh1.cv2 <- (mf.trok / mf.ut.hh1.cv2.all + mf.prok / mf.ut.hh1.cv2.notr + mf.trno / mf.ut.hh1.cv2.notrpr)

# HBO Temporary Utility - HH1, CV3
    mf.tmput.hh1.cv3 <- (mf.trok / mf.ut.hh1.cv3.all + mf.prok / mf.ut.hh1.cv3.notr + mf.trno / mf.ut.hh1.cv3.notrpr)

# HBO Temporary Utility - HH2, CV0
    mf.tmput.hh2.cv0 <- (mf.trok / mf.ut.hh2.cv0.withtr + mf.prok / mf.ut.hh2.cv0.notr + mf.trno / mf.ut.hh2.cv0.notr)

# HBO Temporary Utility - HH2, CV1
    mf.tmput.hh2.cv1 <- (mf.trok / mf.ut.hh2.cv1.all + mf.prok / mf.ut.hh2.cv1.notr + mf.trno / mf.ut.hh2.cv1.notrpr)

# HBO Temporary Utility - HH2, CV2
    mf.tmput.hh2.cv2 <- (mf.trok / mf.ut.hh2.cv2.all + mf.prok / mf.ut.hh2.cv2.notr + mf.trno / mf.ut.hh2.cv2.notrpr)

# HBO Temporary Utility - HH2, CV3
    mf.tmput.hh2.cv3 <- (mf.trok / mf.ut.hh2.cv3.all + mf.prok / mf.ut.hh2.cv3.notr + mf.trno / mf.ut.hh2.cv3.notrpr)

# HBO Temporary Utility - HH34, CV0
    mf.tmput.hh34.cv0 <- (mf.trok / mf.ut.hh34.cv0.withtr + mf.prok / mf.ut.hh34.cv0.notr + mf.trno / mf.ut.hh34.cv0.notr)

# HBO Temporary Utility - HH34, CV1
    mf.tmput.hh34.cv1 <- (mf.trok / mf.ut.hh34.cv1.all + mf.prok / mf.ut.hh34.cv1.notr + mf.trno / mf.ut.hh34.cv1.notrpr)

# HBO Temporary Utility - HH34, CV2
    mf.tmput.hh34.cv2 <- (mf.trok / mf.ut.hh34.cv2.all + mf.prok / mf.ut.hh34.cv2.notr + mf.trno / mf.ut.hh34.cv2.notrpr)

# HBO Temporary Utility - HH34, CV3
    mf.tmput.hh34.cv3 <- (mf.trok / mf.ut.hh34.cv3.all + mf.prok / mf.ut.hh34.cv3.notr + mf.trno / mf.ut.hh34.cv3.notrpr)


### HBO Drive Alone Person Trips

# HBO Drive Alone Person Trips - CV0 
    mf.hoda.cv0 <- ((
                     mf.dautil.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hboA0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hboB0",inc,sep='')) +
                     mf.dautil.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hboC0",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Drive Alone Person Trips - CV1 
    mf.hoda.cv1 <- ((
                     mf.dautil.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hboA1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hboB1",inc,sep='')) +
                     mf.dautil.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hboC1",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Drive Alone Person Trips - CV23 
    mf.hoda.cv23 <- ((
                      mf.dautil.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hboA2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hboA3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hboB2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hboB3",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hboC2",inc,sep='')) +
                      mf.dautil.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hboC3",inc,sep=''))) *
                      get(paste("mf.hbodt",inc,sep='')) * todfact)
  
# Raw HBO Drive Alone Trips
    assign(paste("mf.hoda",inc,timeper,sep="."), mf.hoda.cv0 + mf.hoda.cv1 + mf.hoda.cv23)

    assign(paste("mf.hoda.cv0",inc,timeper,sep="."), mf.hoda.cv0)
    assign(paste("mf.hoda.cv1",inc,timeper,sep="."), mf.hoda.cv1)
    assign(paste("mf.hoda.cv23",inc,timeper,sep="."), mf.hoda.cv23)

    rm (mf.hoda.cv0, mf.hoda.cv1, mf.hoda.cv23, mf.dautil.cv0, mf.dautil.cv1, mf.dautil.cv23)


### HBO Drive with Passenger Person Trips

# HBO Drive with Passenger Person Trips - CV0
    mf.hodp.cv0 <- ((
                     mf.dputil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hboA0",inc,sep='')) +
                     mf.dputil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hboB0",inc,sep='')) +
                     mf.dputil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hboC0",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Drive with Passenger Person Trips - CV1
    mf.hodp.cv1 <- ((
                     mf.dputil.hh1.cv1 * mf.tmput.hh1.cv1 * get(paste("md.hboA1",inc,sep='')) +
                     mf.dputil.hh2.cv1 * mf.tmput.hh2.cv1 * get(paste("md.hboB1",inc,sep='')) +
                     mf.dputil.hh34.cv1 * mf.tmput.hh34.cv1 * get(paste("md.hboC1",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Drive with Passenger Person Trips - CV23
    mf.hodp.cv23 <- ((
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv2 * get(paste("md.hboA2",inc,sep='')) +
                      mf.dputil.hh1.cv23 * mf.tmput.hh1.cv3 * get(paste("md.hboA3",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv2 * get(paste("md.hboB2",inc,sep='')) +
                      mf.dputil.hh2.cv23 * mf.tmput.hh2.cv3 * get(paste("md.hboB3",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv2 * get(paste("md.hboC2",inc,sep='')) +
                      mf.dputil.hh34.cv23 * mf.tmput.hh34.cv3 * get(paste("md.hboC3",inc,sep=''))) *
                      get(paste("mf.hbodt",inc,sep='')) * todfact)

# Raw HBO Drive with Passenger Trips
    assign(paste("mf.hodp",inc,timeper,sep="."), mf.hodp.cv0 + mf.hodp.cv1 + mf.hodp.cv23)

    assign(paste("mf.hodp.cv0",inc,timeper,sep="."), mf.hodp.cv0)
    assign(paste("mf.hodp.cv1",inc,timeper,sep="."), mf.hodp.cv1)
    assign(paste("mf.hodp.cv23",inc,timeper,sep="."), mf.hodp.cv23)

    rm (mf.hodp.cv0, mf.hodp.cv1, mf.hodp.cv23,
        mf.dputil.hh1.cv0, mf.dputil.hh1.cv1, mf.dputil.hh1.cv23,
        mf.dputil.hh2.cv0, mf.dputil.hh2.cv1, mf.dputil.hh2.cv23,
        mf.dputil.hh34.cv0, mf.dputil.hh34.cv1, mf.dputil.hh34.cv23)


### HBO Passenger Person Trips

# HBO Passenger Person Trips - CV0
    mf.hopa.cv0 <- ((
                     mf.pautil.hh1.cv0 * mf.tmput.hh1.cv0 * get(paste("md.hboA0",inc,sep='')) +
                     mf.pautil.hh2.cv0 * mf.tmput.hh2.cv0 * get(paste("md.hboB0",inc,sep='')) +
                     mf.pautil.hh34.cv0 * mf.tmput.hh34.cv0 * get(paste("md.hboC0",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Passenger Person Trips - CV1
    mf.hopa.cv1 <- (( 
                     mf.pautil.hh1.cv123 * mf.tmput.hh1.cv1 * get(paste("md.hboA1",inc,sep='')) +
                     mf.pautil.hh2.cv123 * mf.tmput.hh2.cv1 * get(paste("md.hboB1",inc,sep='')) +
                     mf.pautil.hh34.cv123 * mf.tmput.hh34.cv1 * get(paste("md.hboC1",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Passenger Person Trips - CV23
    mf.hopa.cv23 <- ((
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv2 * get(paste("md.hboA2",inc,sep='')) +
                      mf.pautil.hh1.cv123 * mf.tmput.hh1.cv3 * get(paste("md.hboA3",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv2 * get(paste("md.hboB2",inc,sep='')) +
                      mf.pautil.hh2.cv123 * mf.tmput.hh2.cv3 * get(paste("md.hboB3",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv2 * get(paste("md.hboC2",inc,sep='')) +
                      mf.pautil.hh34.cv123 * mf.tmput.hh34.cv3 * get(paste("md.hboC3",inc,sep=''))) *
                      get(paste("mf.hbodt",inc,sep='')) * todfact)

# Raw HBO Passenger Trips
    assign(paste("mf.hopa",inc,timeper,sep="."), mf.hopa.cv0 + mf.hopa.cv1 + mf.hopa.cv23)

    assign(paste("mf.hopa.cv0",inc,timeper,sep="."), mf.hopa.cv0)
    assign(paste("mf.hopa.cv1",inc,timeper,sep="."), mf.hopa.cv1)
    assign(paste("mf.hopa.cv23",inc,timeper,sep="."), mf.hopa.cv23)

    rm (mf.hopa.cv0, mf.hopa.cv1, mf.hopa.cv23,
        mf.pautil.hh1.cv0, mf.pautil.hh1.cv123,
        mf.pautil.hh2.cv0, mf.pautil.hh2.cv123,
        mf.pautil.hh34.cv0, mf.pautil.hh34.cv123)


### HBO Transit Person Trips

# HBO Transit Person Trips - CV0
    mf.hotr.cv0 <- ((
                    (mf.trutil.cv0 / mf.ut.hh1.cv0.withtr) * get(paste("md.hboA0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh2.cv0.withtr) * get(paste("md.hboB0",inc,sep='')) +
                    (mf.trutil.cv0 / mf.ut.hh34.cv0.withtr) * get(paste("md.hboC0",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbodt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBO Transit Person Trips - CV1
    mf.hotr.cv1 <- ((
                    (mf.trutil.cv1 / mf.ut.hh1.cv1.all) * get(paste("md.hboA1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh2.cv1.all) * get(paste("md.hboB1",inc,sep='')) +
                    (mf.trutil.cv1 / mf.ut.hh34.cv1.all) * get(paste("md.hboC1",inc,sep=''))) *
                     sweep(todfact * get(paste("mf.hbodt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# HBO Transit Person Trips - Household Size = 2, CV 1-3
    mf.hotr.cv23 <- ((
                     (mf.trutil.cv2 / mf.ut.hh1.cv2.all) * get(paste("md.hboA2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh1.cv3.all) * get(paste("md.hboA3",inc,sep='')) +
                     (mf.trutil.cv2 / mf.ut.hh2.cv2.all) * get(paste("md.hboB2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh2.cv3.all) * get(paste("md.hboB3",inc,sep='')) + 
                     (mf.trutil.cv2 / mf.ut.hh34.cv2.all) * get(paste("md.hboC2",inc,sep='')) +
                     (mf.trutil.cv3 / mf.ut.hh34.cv3.all) * get(paste("md.hboC3",inc,sep=''))) *
                      sweep(todfact * get(paste("mf.hbodt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))

# Raw HBO Transit Person Trips
    assign(paste("mf.hotr",inc,timeper,sep="."), mf.hotr.cv0 + mf.hotr.cv1 + mf.hotr.cv23)

    assign(paste("mf.hotr.cv0",inc,timeper,sep="."), mf.hotr.cv0)
    assign(paste("mf.hotr.cv1",inc,timeper,sep="."), mf.hotr.cv1)
    assign(paste("mf.hotr.cv23",inc,timeper,sep="."), mf.hotr.cv23)

    rm (mf.hotr.cv0, mf.hotr.cv1, mf.hotr.cv23, mf.trutil.cv0, mf.trutil.cv1, mf.trutil.cv2, mf.trutil.cv3)


### HBO Park and Ride Transit Person Trips

    mf.hoprtr.cw.cv1 <- (mf.prtutil * (
                         mf.trok / mf.ut.hh1.cv1.all * get(paste("md.hboA1",inc,sep='')) +
                         mf.trok / mf.ut.hh2.cv1.all * get(paste("md.hboB1",inc,sep='')) +
                         mf.trok / mf.ut.hh34.cv1.all * get(paste("md.hboC1",inc,sep=''))) *
                         get(paste("mf.hbodt",inc,sep='')) * todfact)

    mf.hoprtr.cw.cv23 <- (mf.prtutil * (
                          mf.trok / mf.ut.hh1.cv2.all * get(paste("md.hboA2",inc,sep='')) +
                          mf.trok / mf.ut.hh1.cv3.all * get(paste("md.hboA3",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv2.all * get(paste("md.hboB2",inc,sep='')) +
                          mf.trok / mf.ut.hh2.cv3.all * get(paste("md.hboB3",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv2.all * get(paste("md.hboC2",inc,sep='')) +
                          mf.trok / mf.ut.hh34.cv3.all * get(paste("md.hboC3",inc,sep=''))) *
                          get(paste("mf.hbodt",inc,sep='')) * todfact)

    mf.hoprtr.md.cv1 <- (mf.prtutil * (
                         mf.prok / mf.ut.hh1.cv1.notr * get(paste("md.hboA1",inc,sep='')) +
                         mf.prok / mf.ut.hh2.cv1.notr * get(paste("md.hboB1",inc,sep='')) +
                         mf.prok / mf.ut.hh34.cv1.notr * get(paste("md.hboC1",inc,sep=''))) *
                         get(paste("mf.hbodt",inc,sep='')) * todfact)

    mf.hoprtr.md.cv23 <- (mf.prtutil * (
                          mf.prok / mf.ut.hh1.cv2.notr * get(paste("md.hboA2",inc,sep='')) +
                          mf.prok / mf.ut.hh1.cv3.notr * get(paste("md.hboA3",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv2.notr * get(paste("md.hboB2",inc,sep='')) +
                          mf.prok / mf.ut.hh2.cv3.notr * get(paste("md.hboB3",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv2.notr * get(paste("md.hboC2",inc,sep='')) +
                          mf.prok / mf.ut.hh34.cv3.notr * get(paste("md.hboC3",inc,sep=''))) *
                          get(paste("mf.hbodt",inc,sep='')) * todfact)

# Raw HBO Park and Ride Transit Trips
    assign(paste("mf.hoprtr",inc,timeper,sep="."), mf.hoprtr.cw.cv1 + mf.hoprtr.md.cv1 + mf.hoprtr.cw.cv23 + mf.hoprtr.md.cv23)
    assign(paste("mf.hoprtr.cv1",inc,timeper,sep="."), mf.hoprtr.cw.cv1 + mf.hoprtr.md.cv1)
    assign(paste("mf.hoprtr.cv23",inc,timeper,sep="."), mf.hoprtr.cw.cv23 +  mf.hoprtr.md.cv23)
    assign(paste("mf.hoprtr.cw.cv1",inc,timeper,sep="."), mf.hoprtr.cw.cv1)
    assign(paste("mf.hoprtr.cw.cv23",inc,timeper,sep="."), mf.hoprtr.cw.cv23)
    assign(paste("mf.hoprtr.md.cv1",inc,timeper,sep="."), mf.hoprtr.md.cv1)
    assign(paste("mf.hoprtr.md.cv23",inc,timeper,sep="."), mf.hoprtr.md.cv23)
    rm (mf.prtutil)

#allocate trips to lots
    allocateTripsToLots(get(paste("mf.hoprtr",inc,timeper,sep=".")), project.dir, 1, numzones, HBO.vehOccFactor, "hbo")


### HBO Bike Person Trips

# HBO Bike Person Trips - CV0
    mf.hobk.cv0 <- (mf.bkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hboA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hboB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hboC0",inc,sep=''))) *
                    get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Bike Person Trips - CV1
    mf.hobk.cv1 <- (mf.bkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hboA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hboB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hboC1",inc,sep=''))) *
                    get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Bike Person Trips - CV23
    mf.hobk.cv23 <- (mf.bkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hboA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hboA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hboB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hboB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hboC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hboC3",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# Raw HBO Bike Trips
    assign(paste("mf.hobike",inc,timeper,sep="."), mf.hobk.cv0 + mf.hobk.cv1 + mf.hobk.cv23)

    assign(paste("mf.hobike.cv0",inc,timeper,sep="."), mf.hobk.cv0)
    assign(paste("mf.hobike.cv1",inc,timeper,sep="."), mf.hobk.cv1)
    assign(paste("mf.hobike.cv23",inc,timeper,sep="."), mf.hobk.cv23)

    rm(mf.hobk.cv0, mf.hobk.cv1, mf.hobk.cv23, mf.bkutil)


### HBO Walk Person Trips

# HBO Walk Person Trips - CV0
    mf.howk.cv0 <- (mf.wkutil * (
                    mf.tmput.hh1.cv0 * get(paste("md.hboA0",inc,sep='')) +
                    mf.tmput.hh2.cv0 * get(paste("md.hboB0",inc,sep='')) +
                    mf.tmput.hh34.cv0 * get(paste("md.hboC0",inc,sep=''))) *
                    get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Walk Person Trips - CV1
    mf.howk.cv1 <- (mf.wkutil * (
                    mf.tmput.hh1.cv1 * get(paste("md.hboA1",inc,sep='')) +
                    mf.tmput.hh2.cv1 * get(paste("md.hboB1",inc,sep='')) +
                    mf.tmput.hh34.cv1 * get(paste("md.hboC1",inc,sep=''))) *
                    get(paste("mf.hbodt",inc,sep='')) * todfact)

# HBO Walk Person Trips - CV23
    mf.howk.cv23 <- (mf.wkutil * (
                     mf.tmput.hh1.cv2 * get(paste("md.hboA2",inc,sep='')) +
                     mf.tmput.hh1.cv3 * get(paste("md.hboA3",inc,sep='')) +
                     mf.tmput.hh2.cv2 * get(paste("md.hboB2",inc,sep='')) +
                     mf.tmput.hh2.cv3 * get(paste("md.hboB3",inc,sep='')) +
                     mf.tmput.hh34.cv2 * get(paste("md.hboC2",inc,sep='')) +
                     mf.tmput.hh34.cv3 * get(paste("md.hboC3",inc,sep=''))) *
                     get(paste("mf.hbodt",inc,sep='')) * todfact)

# Raw HBO Walk Trips
    assign(paste("mf.howalk",inc,timeper,sep="."), mf.howk.cv0 + mf.howk.cv1 + mf.howk.cv23)

    assign(paste("mf.howalk.cv0",inc,timeper,sep="."), mf.howk.cv0)
    assign(paste("mf.howalk.cv1",inc,timeper,sep="."), mf.howk.cv1)
    assign(paste("mf.howalk.cv23",inc,timeper,sep="."), mf.howk.cv23)

    rm(mf.howk.cv0, mf.howk.cv1, mf.howk.cv23, mf.wkutil)

#  REMOVE the Total and Temporary Utilities

    rm(mf.hhcov, mf.trok, mf.prok, mf.trno)
    rm(list=ls()[grep(("mf.tmput"),ls())])
    rm(list=ls()[grep(("mf.ut"),ls())])

  }   ##  END OF TIME OF DAY LOOP

}     ##  END OF INCOME LOOP

detach(malist.hbo)
