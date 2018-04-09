# k.hbcms.R
# College Mode Choice

print("Running hbc mode choice")

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.colldtl.dat")
load("mf.colldtm.dat")
load("mf.colldth.dat")
load("malist.col.dat")
attach(malist.col)

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
  mf.Spocketcost <- sweep((HBC.pkfact*mf.amstlD + HBC.opfact*mf.mdstlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBC.pkfact*mf.amhtlD + HBC.opfact*mf.mdhtlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Begin income group loop
for (x in 1:3) {

# Define cost coefficients
  if (x==1) {         # low income
    inc <- "l"
    cc     <- HBC.low.cc     # auto operating costs coeff
    pktc   <- HBC.low.pktc   # auto out of pocket costs: parking and tolls coeff
    faresc <- HBC.low.faresc # transit fares coeff
  }
  if (x==2) {         # mid income
    inc <- "m"
    cc     <- HBC.medium.cc      # auto operating costs coeff
    pktc   <- HBC.medium.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBC.medium.faresc  # transit fares coeff
  }
  if (x==3) {         # high income
    inc <- "h"
    cc     <- HBC.high.cc      # auto operating costs coeff
    pktc   <- HBC.high.pktc    # auto out of pocket costs: parking and tolls coeff
    faresc <- HBC.high.faresc  # transit fares coeff
  }

  if (x==1) {         # transit fares
    mf.trfare <- mf.trfare.li
  } else {
    mf.trfare <- mf.trfare.mhi
  }

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact <- HBC.pkfact
      timeper <- "am"
      ma.hhcov <- ma.pkhhcov
      ma.empcov <- ma.pkempcov
    }
    if (y==2) {
      todfact <- HBC.opfact
      timeper <- "md"
      ma.hhcov <- ma.ophhcov
      ma.empcov <- ma.opempcov
    }


### College Drive Alone Utilities

# Base College Drive Alone Utility
    mf.base <- (HBC.ivCoeff * (get(paste("mf.",timeper,"stt",sep=''))) +
          sweep(cc * mf.Sopcost, 2, HBC.da.walkCoeff * ma.auov, "+") + pktc * mf.Spocketcost)

# College Drive Alone Utility cv0 (No Cars) *** NEW ***
    mf.dautil.cv0  <- exp(mf.base + HBC.da.cv0)

# College Drive Alone Utility cv1 (Cars < Workers)
    mf.dautil.cv1 <- exp(mf.base + HBC.da.cv1)

# College Drive Alone Utility cv2 & cv3 (Cars >= Workers)
    mf.dautil.cv23 <- exp(mf.base + HBC.da.cv23)


### College Drive with Passenger Utilities

# Base College Drive with Passenger Utility
    mf.base <- (HBC.MC.dpconst + HBC.ivCoeff * (get(paste("mf.",timeper,"htt",sep=''))) +
          sweep(HBC.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBC.dp.walkCoeff * ma.auov, "+"))

# College Drive with Passenger Utility cv0 (No Cars) *** NEW ***
    mf.dputil.cv0 <- exp(mf.base + HBC.dp.cv0)

# College Drive with Passenger Utility cv123 (Cars > 0) *** NEW ***
    mf.dputil.cv123 <- exp(mf.base + HBC.dp.cv123)


### College Passenger Utilities

# Base College Passenger Utility
    mf.base <- (HBC.MC.paconst + HBC.ivCoeff * (get(paste("mf.",timeper,"htt",sep=''))) +
          sweep(HBC.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBC.pa.walkCoeff * ma.auov, "+"))

# College Drive with Passenger Utility
    mf.pautil <- exp(mf.base)


### College Transit Utility

# Transit In-Vehicle Time
    mf.trbivt  <- get(paste("mf.", timeper, "tbiv", sep=''))
    mf.trlivt  <- get(paste("mf.", timeper, "tliv", sep=''))
    mf.trrivt  <- get(paste("mf.", timeper, "triv", sep=''))
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

# College Transit Utility
    ivt     <- HBC.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- HBC.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- HBC.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.base <- (trconst + ivt + HBC.tr.wait1Coeff * mf.trwait1 + HBC.tr.wait2Coeff * mf.trwait2 + HBC.tr.walkCoeff * mf.trwalk + HBC.tr.transCoeff * mf.transfers +
                faresc * mf.trfare + oviv)
    mf.base[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# College Transit Utility CV0 (No Cars) *** NEW ***
    mf.trutil.cv0 <- exp(mf.base + HBC.tr.cv0)
    mf.trutil.cv0[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# College Transit Utility CV1 (Cars < Workers) *** NEW ***
    mf.trutil.cv1 <- exp(mf.base + HBC.tr.cv1)
    mf.trutil.cv1[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# College Transit Utility CV23 (Cars >= Workers) *** NEW ***
    mf.trutil.cv23 <- exp(mf.base + HBC.tr.cv23)
    mf.trutil.cv23[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0


# College Park and Ride Transit Utility

    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbc"
    paramSet$cv <- "" 
    paramSet$cvConstant <- PNR.cvConstant 
    #constants
    paramSet$formalConstant <- HBC.formalConstant
    paramSet$informalConstant <- HBC.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff

    mf.prtutil <- calcPNRUtils(timeper, inc, project.dir, HBC.MC.prconst, 1, numzones, paramSet)


### College Bike Utility
    mf.bkutil <- exp(sweep(HBC.MC.bikeconst + HBC.bk.inbikeCoeff * mf.inbike + HBC.bk.ubdistCoeff * mf.ubdist + HBC.bk.cbcostCoeff * mf.cbcost, 2, HBC.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


### College Walk Utility
    mf.wkutil <- exp(sweep(HBC.MC.walkconst + HBC.wk.walkCoeff * mf.wtime, 1, HBC.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


### Compute Total Utilities

print("Calculating total utilities")

# College Utility - CV0, w/o Transit *** NEW ***
    mf.ut.cv0.notr <- mf.dautil.cv0 + mf.dputil.cv0 + mf.pautil + mf.bkutil + mf.wkutil

# College Utility - CV0, w/ Transit *** NEW ***
    mf.ut.cv0.withtr <- mf.ut.cv0.notr + mf.trutil.cv0

# College Utility - CV1, w/o Transit or PnR *** NEW ***
    mf.ut.cv1.notrpr <- mf.dautil.cv1 + mf.dputil.cv123 + mf.pautil + mf.bkutil + mf.wkutil

# College Utility - CV1, w/o Transit *** NEW ***
    mf.ut.cv1.notr <- mf.ut.cv1.notrpr + mf.prtutil

# College Utility - CV1, all modes *** NEW ***
    mf.ut.cv1.all <- mf.ut.cv1.notr + mf.trutil.cv1

# College Utility - CV23, w/o Transit or PnR *** NEW ***
    mf.ut.cv23.notrpr <- mf.dautil.cv23 + mf.dputil.cv123 + mf.pautil + mf.bkutil + mf.wkutil

# College Utility - CV23, w/o Transit *** NEW ***
    mf.ut.cv23.notr <- mf.ut.cv23.notrpr + mf.prtutil

# College Utility - CV23, all modes *** NEW ***
    mf.ut.cv23.all <- mf.ut.cv23.notr + mf.trutil.cv23


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


# College Temporary Utility - CV0
    mf.tmput.cv0 <- mf.trok / mf.ut.cv0.withtr + mf.prok / mf.ut.cv0.notr + mf.trno / mf.ut.cv0.notr

# College Temporary Utility - CV1
    mf.tmput.cv1 <- mf.trok / mf.ut.cv1.all + mf.prok / mf.ut.cv1.notr + mf.trno / mf.ut.cv1.notrpr

# College Temporary Utility - CV23
    mf.tmput.cv23 <- mf.trok / mf.ut.cv23.all + mf.prok / mf.ut.cv23.notr + mf.trno / mf.ut.cv23.notrpr


### College Drive Alone Person Trips

# College Drive Alone Person Trips - CV0
    mf.hcda.cv0 <- (mf.dautil.cv0 * mf.tmput.cv0 * get(paste("md.hbc0",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcda.cv0[ma.collpr == 0] <- 0

# College Drive Alone Person Trips - CV1
    mf.hcda.cv1 <- (mf.dautil.cv1 * mf.tmput.cv1 * get(paste("md.hbc1",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcda.cv1[ma.collpr == 0] <- 0

# College Drive Alone Person Trips - CV23
    mf.hcda.cv23 <- (mf.dautil.cv23 * (mf.tmput.cv23 * get(paste("md.hbc2",inc,sep='')) +
                                       mf.tmput.cv23 * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcda.cv23[ma.collpr == 0] <- 0

# Raw College Drive Alone Person Trips
    assign(paste("mf.hcda", inc, timeper, sep="."), mf.hcda.cv0 + mf.hcda.cv1 + mf.hcda.cv23)

    assign(paste("mf.hcda.cv0", inc, timeper, sep="."), mf.hcda.cv0)
    assign(paste("mf.hcda.cv1", inc, timeper, sep="."), mf.hcda.cv1)
    assign(paste("mf.hcda.cv23", inc, timeper, sep="."), mf.hcda.cv23)

    rm (mf.hcda.cv0, mf.hcda.cv1, mf.hcda.cv23)


### College Drive with Passenger Person Trips

# College Drive with Passenger Person Trips - CV0
    mf.hcdp.cv0 <- (mf.dputil.cv0 * mf.tmput.cv0 * get(paste("md.hbc0",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcdp.cv0[ma.collpr == 0] <- 0

# College Drive with Passenger Person Trips - CV1
    mf.hcdp.cv1 <- (mf.dputil.cv123 * mf.tmput.cv1 * get(paste("md.hbc1",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcdp.cv1[ma.collpr == 0] <- 0

# College Drive with Passenger Person Trips - CV23
    mf.hcdp.cv23 <- (mf.dputil.cv123 * (mf.tmput.cv23 * get(paste("md.hbc2",inc,sep='')) +
                                        mf.tmput.cv23 * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcdp.cv23[ma.collpr == 0] <- 0

# Raw College Drive with Passenger Trips
    assign(paste("mf.hcdp", inc, timeper, sep="."), mf.hcdp.cv0 + mf.hcdp.cv1 + mf.hcdp.cv23)

    assign(paste("mf.hcdp.cv0", inc, timeper, sep="."), mf.hcdp.cv0)
    assign(paste("mf.hcdp.cv1", inc, timeper, sep="."), mf.hcdp.cv1)
    assign(paste("mf.hcdp.cv23", inc, timeper, sep="."), mf.hcdp.cv23)

    rm (mf.hcdp.cv0, mf.hcdp.cv1, mf.hcdp.cv23)


### College Passenger Person Trips

# College Passenger Person Trips - CV0
    mf.hcpa.cv0 <- (mf.pautil * mf.tmput.cv0 * get(paste("md.hbc0",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcpa.cv0[ma.collpr == 0] <- 0

# College Passenger Person Trips - CV1
    mf.hcpa.cv1 <- (mf.pautil * mf.tmput.cv1 * get(paste("md.hbc1",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcpa.cv1[ma.collpr == 0] <- 0

# College Passenger Person Trips - CV23
    mf.hcpa.cv23 <- (mf.pautil * (mf.tmput.cv23 * get(paste("md.hbc2",inc,sep='')) +
                                  mf.tmput.cv23 * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcpa.cv23[ma.collpr == 0] <- 0

# Raw College Passenger Trips
    assign(paste("mf.hcpa", inc, timeper, sep="."), mf.hcpa.cv0 + mf.hcpa.cv1 + mf.hcpa.cv23)

    assign(paste("mf.hcpa.cv0", inc, timeper, sep="."), mf.hcpa.cv0)
    assign(paste("mf.hcpa.cv1", inc, timeper, sep="."), mf.hcpa.cv1)
    assign(paste("mf.hcpa.cv23", inc, timeper, sep="."), mf.hcpa.cv23)

    rm (mf.hcpa.cv0, mf.hcpa.cv1, mf.hcpa.cv23)


### College Transit Person Trips

# College Transit Person Trips - CV0
    mf.hctr.cv0 <- (((mf.trutil.cv0 * get(paste("md.hbc0",inc,sep=''))) / mf.ut.cv0.withtr) * sweep(todfact * get(paste("mf.colldt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))
    mf.hctr.cv0[ma.collpr == 0] <- 0

# College Transit Person Trips - CV1
    mf.hctr.cv1 <- (((mf.trutil.cv1 * get(paste("md.hbc1",inc,sep=''))) / mf.ut.cv1.all) * sweep(todfact * get(paste("mf.colldt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))
    mf.hctr.cv1[ma.collpr == 0] <- 0

# College Transit Person Trips - CV23
    mf.hctr.cv23 <- (((mf.trutil.cv23 * get(paste("md.hbc2",inc,sep='')) +
                       mf.trutil.cv23 * get(paste("md.hbc3",inc,sep=''))) / mf.ut.cv23.all) * sweep(todfact * get(paste("mf.colldt",inc,sep='')) * ma.hhcov, 2, ma.empcov, "*"))
    mf.hctr.cv23[ma.collpr == 0] <- 0

# Raw College Transit Person Trips
    assign(paste("mf.hctr", inc, timeper, sep="."), mf.hctr.cv0 + mf.hctr.cv1 + mf.hctr.cv23)

    assign(paste("mf.hctr.cv0", inc, timeper, sep="."), mf.hctr.cv0)
    assign(paste("mf.hctr.cv1",inc, timeper, sep="."), mf.hctr.cv1)
    assign(paste("mf.hctr.cv23",inc, timeper, sep="."), mf.hctr.cv23)


### College Park and Ride Transit Person Trips

    mf.hcprtr.cw.cv1 <- (mf.prtutil * (mf.trok / mf.ut.cv1.all * get(paste("md.hbc1",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcprtr.cw.cv1[ma.collpr == 0] <- 0

    mf.hcprtr.cw.cv23 <- (mf.prtutil * (mf.trok / mf.ut.cv23.all * get(paste("md.hbc2",inc,sep='')) +
                                        mf.trok / mf.ut.cv23.all * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcprtr.cw.cv23[ma.collpr == 0] <- 0

    mf.hcprtr.md.cv1 <- (mf.prtutil * (mf.prok / mf.ut.cv1.notr * get(paste("md.hbc1",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcprtr.md.cv1[ma.collpr == 0] <- 0
    
    mf.hcprtr.md.cv23 <- (mf.prtutil * (mf.prok / mf.ut.cv23.notr * get(paste("md.hbc2",inc,sep='')) +
                                        mf.prok / mf.ut.cv23.notr * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcprtr.md.cv23[ma.collpr == 0] <- 0

# Raw College Park and Ride Transit Trips
    assign(paste("mf.hcprtr", inc, timeper, sep="."), mf.hcprtr.cw.cv1 + mf.hcprtr.cw.cv23 + mf.hcprtr.md.cv1 + mf.hcprtr.md.cv23)

    assign(paste("mf.hcprtr.cv1", inc, timeper, sep="."), mf.hcprtr.cw.cv1 + mf.hcprtr.md.cv1)
    assign(paste("mf.hcprtr.cv23", inc, timeper, sep="."), mf.hcprtr.cw.cv23 + mf.hcprtr.md.cv23)
    assign(paste("mf.hcprtr.cw.cv1", inc, timeper, sep="."), mf.hcprtr.cw.cv1)
    assign(paste("mf.hcprtr.cw.cv23", inc, timeper, sep="."), mf.hcprtr.cw.cv23)
    assign(paste("mf.hcprtr.md.cv1", inc, timeper, sep="."), mf.hcprtr.md.cv1)
    assign(paste("mf.hcprtr.md.cv23", inc, timeper, sep="."), mf.hcprtr.md.cv23)

    rm (mf.prtutil)

#allocate trips to lots
    allocateTripsToLots(get(paste("mf.hcprtr", inc, timeper, sep=".")), project.dir, 1, numzones, HBC.vehOccFactor, "hbc")


### College Bike Person Trips

# College Bike Person Trips - CV0
    mf.hcbk.cv0 <- (mf.bkutil * mf.tmput.cv0 * get(paste("md.hbc0",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcbk.cv0[ma.collpr == 0] <- 0

# College Bike Person Trips - CV1
    mf.hcbk.cv1 <- (mf.bkutil * mf.tmput.cv1 * get(paste("md.hbc1",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcbk.cv1[ma.collpr == 0] <- 0

# College Bike Person Trips - CV23
    mf.hcbk.cv23 <- (mf.bkutil * (mf.tmput.cv23 * get(paste("md.hbc2",inc,sep='')) +
                                  mf.tmput.cv23 * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcbk.cv23[ma.collpr == 0] <- 0

# Raw College Bike Trips
    assign(paste("mf.hcbike", inc, timeper, sep="."), mf.hcbk.cv0 + mf.hcbk.cv1 + mf.hcbk.cv23)

    assign(paste("mf.hcbike.cv0", inc, timeper, sep="."), mf.hcbk.cv0)
    assign(paste("mf.hcbike.cv1", inc, timeper, sep="."), mf.hcbk.cv1)
    assign(paste("mf.hcbike.cv23", inc, timeper, sep="."), mf.hcbk.cv23)

    rm(mf.hcbk.cv0,mf.hcbk.cv1,mf.hcbk.cv23)


### College Walk Person Trips

# College Walk Person Trips - CV0
    mf.hcwk.cv0 <- (mf.wkutil * mf.tmput.cv0 * get(paste("md.hbc0",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcwk.cv0[ma.collpr == 0] <- 0

# College Walk Person Trips - CV1
    mf.hcwk.cv1 <- (mf.wkutil * mf.tmput.cv1 * get(paste("md.hbc1",inc,sep='')) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcwk.cv1[ma.collpr == 0] <- 0

# College Walk Person Trips - CV23
    mf.hcwk.cv23 <- (mf.wkutil * (mf.tmput.cv23 * get(paste("md.hbc2",inc,sep='')) +
                                  mf.tmput.cv23 * get(paste("md.hbc3",inc,sep=''))) * get(paste("mf.colldt",inc,sep='')) * todfact)
    mf.hcwk.cv23[ma.collpr == 0] <- 0

# Raw College Walk Trips
    assign(paste("mf.hcwalk", inc, timeper, sep="."), mf.hcwk.cv0 + mf.hcwk.cv1 + mf.hcwk.cv23)

    assign(paste("mf.hcwalk.cv0", inc, timeper, sep="."), mf.hcwk.cv0)
    assign(paste("mf.hcwalk.cv1", inc, timeper, sep="."), mf.hcwk.cv1)
    assign(paste("mf.hcwalk.cv23", inc, timeper, sep="."), mf.hcwk.cv23)

    rm(mf.hcwk.cv0,mf.hcwk.cv1,mf.hcwk.cv23)


#  REMOVE the Total and Temporary Utilities

    rm(mf.hhcov, mf.trok, mf.prok, mf.trno)
    rm(list=ls()[grep(("mf.tmput"),ls())])
    rm(list=ls()[grep(("mf.ut"),ls())])

  }   ##  END OF TIME OF DAY LOOP

}     ##  END OF INCOME LOOP

detach(malist.col)
