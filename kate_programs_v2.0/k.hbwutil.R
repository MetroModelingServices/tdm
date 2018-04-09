# k.hbwutil.R
# HBW Destination Choice Logsums

# Auto Operating Cost
mf.Sopcost <- autocost * mf.tdist
mf.Hopcost <- mf.Sopcost

# Auto Out of Pocket Cost
mf.Spocketcost <- sweep((mf.Sopcost * 0), 2, 0.5 * ma.ltpkg, "+")
mf.Hpocketcost <- sweep((mf.Hopcost * 0), 2, 0.5 * ma.ltpkg, "+")

if (toll == TRUE)
{
  print("About to calculate toll costs")

  # Adjust Toll Time to reflect difference in elasticity between assignment and model (.25)

  mf.amstlTadj <- mf.amstl*(.25)
  mf.mdstlTadj <- mf.mdstl*(.25)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(.25)
  mf.mdhtlTadj <- mf.mdhtl*(.25)

  mf.amhtlD <- (mf.amhtlTadj/60)*pkvot
  mf.mdhtlD <- (mf.mdhtlTadj/60)*opvot

  # Add Tolls
  mf.Spocketcost <- sweep((HBW.pkfact*mf.amstlD + HBW.opfact*mf.mdstlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((HBW.pkfact*mf.amhtlD + HBW.opfact*mf.mdhtlD), 2, 0.5 * ma.ltpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
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

# HBW Drive Alone Utility
    mf.dautil <- exp(HBW.ivCoeff * (HBW.pkfact * mf.amstt + HBW.opfact * mf.mdstt) + 
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, HBW.da.walkCoeff * ma.auov, "+"))

# HBW Drive with Passenger Utility
    mf.dputil <- exp(HBW.LS.dpconst + HBW.ivCoeff * (HBW.pkfact * mf.amhtt + HBW.opfact * mf.mdhtt) +
               sweep(HBW.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBW.dp.walkCoeff * ma.auov, "+"))

# HBW Passenger Utility
    mf.pautil <- exp(HBW.LS.paconst + HBW.ivCoeff * (HBW.pkfact * mf.amhtt + HBW.opfact * mf.mdhtt) + 
               sweep(HBW.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBW.pa.walkCoeff * ma.auov, "+"))

# HBW Transit Utility
    mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
    mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)
    
    mf.amtconst <- (HBW.LS.tranconst + mf.amtvehc + mf.amtstpc)
    mf.mdtconst <- (HBW.LS.tranconst + mf.mdtvehc + mf.mdtstpc)
    
    ivt <- HBW.pkfact * HBW.ivCoeff * mf.amtiv + HBW.opfact * HBW.ivCoeff * mf.mdtiv
    trconst <- HBW.pkfact * mf.amtconst + HBW.opfact * mf.mdtconst
    mf.trwait1 <- HBW.pkfact * mf.amtwt1 + HBW.opfact * mf.mdtwt1
    mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
    mf.trwait2 <- HBW.pkfact * mf.amtwt2 + HBW.opfact * mf.mdtwt2
    mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    mf.trwalk <- HBW.pkfact * mf.amtwalk + HBW.opfact * mf.mdtwalk
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    mf.transfers <- HBW.pkfact * mf.amtxfr + HBW.opfact * mf.mdtxfr

    oviv <- HBW.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (HBW.pkfact * mf.amtiv + HBW.opfact * mf.mdtiv))

    mf.trutil <- exp(trconst + ivt + oviv + HBW.tr.wait1Coeff * mf.trwait1 + HBW.tr.wait2Coeff * mf.trwait2 + HBW.tr.walkCoeff * mf.trwalk + HBW.tr.transCoeff * mf.transfers + cc * mf.trfare)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBW Park and Ride Transit Utility

    # Drive Alone Utility (no parking charge or walk time)
    mf.dautil_pnr <- exp(HBW.ivCoeff * (HBW.pkfact * mf.amstt + HBW.opfact * mf.mdstt) + sweep(cc * mf.Sopcost, 2, 0.5 * ma.ltpkg, "-"))
    
    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbw"
    #constants
    paramSet$formalConstant <- HBW.formalConstant
    paramSet$informalConstant <- HBW.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff
    
    #calculate daily logsum
    mf.prtutil <- calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, HBW.LS.prconst, paramSet)

# HBW Bike Utility
  mf.bkutil <- exp(HBW.LS.bikeconst + HBW.bk.ubdistCoeff * mf.ubdist + HBW.bk.cbcostCoeff * mf.cbcost)

# HBW Walk Utility
  mf.wkutil <- exp(HBW.LS.walkconst + HBW.wk.walkCoeff * mf.wtime)
  mf.wkutil[mf.wtime[,]>100] <- 0

# HBW Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)
  assign(paste("mf.hwls", inc, sep=''), mf.logsum)

}
