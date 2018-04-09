# k.hbrutil.R
# HBR Destination Choice Logsums

# Auto Operating Cost
mf.Sopcost <- autocost * mf.tdist
mf.Hopcost <- mf.Sopcost

# Auto Out of Pocket Cost
mf.Spocketcost <- sweep((mf.Sopcost * 0), 2, 0.5 * ma.stpkg, "+")
mf.Hpocketcost <- sweep((mf.Hopcost * 0), 2, 0.5 * ma.stpkg, "+")

if (toll == TRUE)
{
  print("About to calculate toll costs")

  # Adjust Toll Time to reflect difference in elasticity between assignment and model (.25)

  mf.amstlTadj <- mf.amstl*(1.125)*(.25)
  mf.mdstlTadj <- mf.mdstl*(1.25)*(.25)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(1.125)*(.25)
  mf.mdhtlTadj <- mf.mdhtl*(1.25)*(.25)

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

# HBR Drive Alone Utility
    mf.dautil <- exp(HBR.ivCoeff * (HBR.pkfact * mf.amstt + HBR.opfact * mf.mdstt) + 
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, HBR.da.walkCoeff * ma.auov, "+"))

# HBR Drive with Passenger Utility
    mf.dputil <- exp(HBR.LS.dpconst + HBR.ivCoeff * (HBR.pkfact * mf.amhtt + HBR.opfact * mf.mdhtt) +
               sweep(HBR.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBR.dp.walkCoeff * ma.auov, "+"))

# HBR Passenger Utility
    mf.pautil <- exp(HBR.LS.paconst + HBR.ivCoeff * (HBR.pkfact * mf.amhtt + HBR.opfact * mf.mdhtt) + 
               sweep(HBR.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBR.pa.walkCoeff * ma.auov, "+"))

# HBR Transit Utility
    mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
    mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)
    
    mf.amtconst <- (HBR.LS.tranconst + mf.amtvehc + mf.amtstpc)
    mf.mdtconst <- (HBR.LS.tranconst + mf.mdtvehc + mf.mdtstpc)
    
    ivt <- HBR.pkfact * HBR.ivCoeff * mf.amtiv + HBR.opfact * HBR.ivCoeff * mf.mdtiv
    trconst <- HBR.pkfact * mf.amtconst + HBR.opfact * mf.mdtconst
    mf.trwait1 <- HBR.pkfact * mf.amtwt1 + HBR.opfact * mf.mdtwt1
    mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
    mf.trwait2 <- HBR.pkfact * mf.amtwt2 + HBR.opfact * mf.mdtwt2
    mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    mf.trwalk <- HBR.pkfact * mf.amtwalk + HBR.opfact * mf.mdtwalk
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    mf.transfers <- HBR.pkfact * mf.amtxfr + HBR.opfact * mf.mdtxfr

    oviv <- HBR.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (HBR.pkfact * mf.amtiv + HBR.opfact * mf.mdtiv))

    mf.trutil <- exp(trconst + ivt + oviv + HBR.tr.wait1Coeff * mf.trwait1 + HBR.tr.wait2Coeff * mf.trwait2 + HBR.tr.walkCoeff * mf.trwalk + HBR.tr.transCoeff * mf.transfers + cc * mf.trfare)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBR Park and Ride Transit Utility

    # Drive Alone Utility (no parking charge or walk time)
    mf.dautil_pnr <- exp(HBR.ivCoeff * (HBR.pkfact * mf.amstt + HBR.opfact * mf.mdstt) + sweep(cc * mf.Sopcost, 2, 0.5 * ma.stpkg, "-"))
    
    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbr"
    #constants
    paramSet$formalConstant <- HBR.formalConstant
    paramSet$informalConstant <- HBR.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff
    
    #calculate daily logsum
    mf.prtutil <- calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, HBR.LS.prconst, paramSet)

# HBR Bike Utility
  mf.bkutil <- exp(HBR.LS.bikeconst + HBR.bk.ubdistCoeff * mf.ubdist + HBR.bk.nbcostCoeff * mf.nbcost)

# HBR Walk Utility
  mf.wkutil <- exp(HBR.LS.walkconst + HBR.wk.walkCoeff * mf.wtime)
  mf.wkutil[mf.wtime[,]>100] <- 0

# HBR Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)
  assign(paste("mf.hrls", inc, sep=''), mf.logsum)

}
