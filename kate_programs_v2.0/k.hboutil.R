# k.hboutil.R
# HBO Destination Choice Logsums

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

# HBO Drive Alone Utility
    mf.dautil <- exp(HBO.ivCoeff * (HBO.pkfact * mf.amstt + HBO.opfact * mf.mdstt) + 
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, HBO.da.walkCoeff * ma.auov, "+"))

# HBO Drive with Passenger Utility
    mf.dputil <- exp(HBO.LS.dpconst + HBO.ivCoeff * (HBO.pkfact * mf.amhtt + HBO.opfact * mf.mdhtt) +
               sweep(HBO.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBO.dp.walkCoeff * ma.auov, "+"))

# HBO Passenger Utility
    mf.pautil <- exp(HBO.LS.paconst + HBO.ivCoeff * (HBO.pkfact * mf.amhtt + HBO.opfact * mf.mdhtt) + 
               sweep(HBO.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, HBO.pa.walkCoeff * ma.auov, "+"))

# HBO Transit Utility
    mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
    mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)
    
    mf.amtconst <- (HBO.LS.tranconst + mf.amtvehc + mf.amtstpc)
    mf.mdtconst <- (HBO.LS.tranconst + mf.mdtvehc + mf.mdtstpc)
    
    ivt <- HBO.pkfact * HBO.ivCoeff * mf.amtiv + HBO.opfact * HBO.ivCoeff * mf.mdtiv
    trconst <- HBO.pkfact * mf.amtconst + HBO.opfact * mf.mdtconst
    mf.trwait1 <- HBO.pkfact * mf.amtwt1 + HBO.opfact * mf.mdtwt1
    mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
    mf.trwait2 <- HBO.pkfact * mf.amtwt2 + HBO.opfact * mf.mdtwt2
    mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
    mf.trwalk <- HBO.pkfact * mf.amtwalk + HBO.opfact * mf.mdtwalk
    mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
    mf.transfers <- HBO.pkfact * mf.amtxfr + HBO.opfact * mf.mdtxfr

    oviv <- HBO.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (HBO.pkfact * mf.amtiv + HBO.opfact * mf.mdtiv))

    mf.trutil <- exp(trconst + ivt + oviv + HBO.tr.wait1Coeff * mf.trwait1 + HBO.tr.wait2Coeff * mf.trwait2 + HBO.tr.walkCoeff * mf.trwalk + HBO.tr.transCoeff * mf.transfers + cc * mf.trfare)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# HBO Park and Ride Transit Utility

    # Drive Alone Utility (no parking charge or walk time)
    mf.dautil_pnr <- exp(HBO.ivCoeff * (HBO.pkfact * mf.amstt + HBO.opfact * mf.mdstt) + sweep(cc * mf.Sopcost, 2, 0.5 * ma.stpkg, "-"))
    
    #lot choice parameters
    #general
    paramSet <- list()
    paramSet$purpose <- "hbo"
    #constants
    paramSet$formalConstant <- HBO.formalConstant
    paramSet$informalConstant <- HBO.informalConstant
    #nesting coefficients
    paramSet$pnrNestCoeff <- PNR.pnrNestCoeff
    paramSet$formalNestCoeff <- PNR.formalNestCoeff
    paramSet$informalNestCoeff <- PNR.informalNestCoeff
    #lot coefficients
    paramSet$lotParkCostCoeff <- PNR.lotParkCostCoeff
    
    #calculate daily logsum
    mf.prtutil <- calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, HBO.LS.prconst, paramSet)

# HBO Bike Utility
  mf.bkutil <- exp(HBO.LS.bikeconst + HBO.bk.ubdistCoeff * mf.ubdist + HBO.bk.nbcostCoeff * mf.nbcost)

# HBO Walk Utility
  mf.wkutil <- exp(HBO.LS.walkconst + HBO.wk.walkCoeff * mf.wtime)
  mf.wkutil[mf.wtime[,]>100] <- 0

# HBO Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)
  assign(paste("mf.hols", inc, sep=''), mf.logsum)

}
