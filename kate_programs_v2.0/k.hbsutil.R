# k.hbsutil.R
# HBS Destination Choice Logsums

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

# HBS Drive Alone Utility
    mf.dautil <- exp(HBS.ivCoeff * (HBS.pkfact * mf.amstt + HBS.opfact * mf.mdstt) + 
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, HBS.da.walkCoeff * ma.auov, "+"))

# HBS Drive with Passenger Utility
    mf.dputil <- exp(HBS.LS.dpconst + HBS.ivCoeff * (HBS.pkfact * mf.amhtt + HBS.opfact * mf.mdhtt) +
               sweep(HBS.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBS.dp.walkCoeff * ma.auov, "+"))

# HBS Passenger Utility
    mf.pautil <- exp(HBS.LS.paconst + HBS.ivCoeff * (HBS.pkfact * mf.amhtt + HBS.opfact * mf.mdhtt) + 
               sweep(HBS.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBS.pa.walkCoeff * ma.auov, "+"))

# HBS Transit Utility
    mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
    mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)
    
    mf.amtconst <- (HBS.LS.tranconst + mf.amtvehc + mf.amtstpc)
    mf.mdtconst <- (HBS.LS.tranconst + mf.mdtvehc + mf.mdtstpc)
    
    ivt <- HBS.pkfact * HBS.ivCoeff * mf.amtiv + HBS.opfact * HBS.ivCoeff * mf.mdtiv
    trconst <- HBS.pkfact * mf.amtconst + HBS.opfact * mf.mdtconst
    mf.trwait1 <- HBS.pkfact * mf.amtwt1 + HBS.opfact * mf.mdtwt1
    mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
    mf.trwait2 <- HBS.pkfact * mf.amtwt2 + HBS.opfact * mf.mdtwt2
    mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    mf.trwalk <- HBS.pkfact * mf.amtwalk + HBS.opfact * mf.mdtwalk
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    mf.transfers <- HBS.pkfact * mf.amtxfr + HBS.opfact * mf.mdtxfr

    oviv <- HBS.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (HBS.pkfact * mf.amtiv + HBS.opfact * mf.mdtiv))

    mf.trutil <- exp(trconst + ivt + oviv + HBS.tr.wait1Coeff * mf.trwait1 + HBS.tr.wait2Coeff * mf.trwait2 + HBS.tr.walkCoeff * mf.trwalk + HBS.tr.transCoeff * mf.transfers + cc * mf.trfare)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBS Park and Ride Transit Utility

    # Drive Alone Utility (no parking charge or walk time)
    mf.dautil_pnr <- exp(HBS.ivCoeff * (HBS.pkfact * mf.amstt + HBS.opfact * mf.mdstt) + sweep(cc * mf.Sopcost, 2, 0.5 * ma.stpkg, "-"))
    
    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbs"
    #constants
    paramSet$formalConstant <- HBS.formalConstant
    paramSet$informalConstant <- HBS.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff
    
    #calculate daily logsum
    mf.prtutil <- calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, HBS.LS.prconst, paramSet)

# HBS Bike Utility
  mf.bkutil <- exp(HBS.LS.bikeconst + HBS.bk.ubdistCoeff * mf.ubdist + HBS.bk.nbcostCoeff * mf.nbcost)

# HBS Walk Utility
  mf.wkutil <- exp(HBS.LS.walkconst + HBS.wk.walkCoeff * mf.wtime)
  mf.wkutil[mf.wtime[,]>100] <- 0

# HBS Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)
  assign(paste("mf.hsls", inc, sep=''), mf.logsum)

}
