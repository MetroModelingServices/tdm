# k.hbcutil.R 
# HBC Destination Choice Logsums

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

# College Drive Alone Utility
    mf.dautil <- exp(HBC.ivCoeff * (HBC.pkfact * mf.amstt + HBC.opfact * mf.mdstt) + 
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, HBC.da.walkCoeff * ma.auov, "+"))

# College Drive with Passenger Utility
    mf.dputil <- exp(HBC.LS.dpconst + HBC.ivCoeff * (HBC.pkfact * mf.amhtt + HBC.opfact * mf.mdhtt) +
               sweep(HBC.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBC.dp.walkCoeff * ma.auov, "+"))

# College Passenger Utility
    mf.pautil <- exp(HBC.LS.paconst + HBC.ivCoeff * (HBC.pkfact * mf.amhtt + HBC.opfact * mf.mdhtt) + 
               sweep(HBC.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBC.pa.walkCoeff * ma.auov, "+"))

# College Transit Utility (weighted average)
    mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
    mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)
    
    mf.amtconst <- (HBC.LS.tranconst + mf.amtvehc + mf.amtstpc)
    mf.mdtconst <- (HBC.LS.tranconst + mf.mdtvehc + mf.mdtstpc)
    
    ivt <- HBC.pkfact * HBC.ivCoeff * mf.amtiv + HBC.opfact * HBC.ivCoeff * mf.mdtiv
    trconst <- HBC.pkfact * mf.amtconst + HBC.opfact * mf.mdtconst
    mf.trwait1 <- HBC.pkfact * mf.amtwt1 + HBC.opfact * mf.mdtwt1
    mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
    mf.trwait2 <- HBC.pkfact * mf.amtwt2 + HBC.opfact * mf.mdtwt2
    mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    mf.trwalk <- HBC.pkfact * mf.amtwalk + HBC.opfact * mf.mdtwalk
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    mf.transfers <- HBC.pkfact * mf.amtxfr + HBC.opfact * mf.mdtxfr

    oviv <- HBC.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (HBC.pkfact * mf.amtiv + HBC.opfact * mf.mdtiv))

    mf.trutil <- exp(trconst + ivt + oviv + HBC.tr.wait1Coeff * mf.trwait1 + HBC.tr.wait2Coeff * mf.trwait2 + HBC.tr.walkCoeff * mf.trwalk + HBC.tr.transCoeff * mf.transfers + cc * mf.trfare)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# College Park and Ride Transit Utility

    # Drive Alone Utility (no parking charge or walk time)
    mf.dautil_pnr <- exp(HBC.ivCoeff * (HBC.pkfact * mf.amstt + HBC.opfact * mf.mdstt) + sweep(cc * mf.Sopcost, 2, 0.5 * ma.ltpkg, "-"))
    
    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbc"
    #constants
    paramSet$formalConstant <- HBC.formalConstant
    paramSet$informalConstant <- HBC.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff
    
    #calculate daily logsum
    mf.prtutil <- calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, HBC.LS.prconst, paramSet)

# College Bike Utility
  mf.bkutil <- exp(HBC.LS.bikeconst + HBC.bk.ubdistCoeff * mf.ubdist + HBC.bk.cbcostCoeff * mf.cbcost)

# College Walk Utility
  mf.wkutil <- exp(HBC.LS.walkconst + HBC.wk.walkCoeff * mf.wtime)
  mf.wkutil[mf.wtime[,]>100] <- 0

# College Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)
  assign(paste("mf.hcls", inc, sep=''), mf.logsum)

}
