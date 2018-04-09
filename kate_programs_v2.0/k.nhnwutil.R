# k.nhnwutil.R
# NHNW Destination Choice Logsums

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
  mf.Spocketcost <- sweep((NHNW.pkfact*mf.amstlD + NHNW.opfact*mf.mdstlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((NHNW.pkfact*mf.amhtlD + NHNW.opfact*mf.mdhtlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Define cost coefficients
cc     <- NHNW.all.cc     # auto operating costs coeff
pktc   <- NHNW.all.pktc   # auto out of pocket costs: parking and tolls coeff
faresc <- NHNW.all.faresc # transit fares coeff

# NHNW Drive Alone Utility
mf.dautil <- exp(NHNW.ivCoeff * (NHNW.pkfact * mf.amstt + NHNW.opfact * mf.mdstt) +
           sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, NHNW.da.walkCoeff * ma.auov, "+"))

# NHNW Drive with Passenger Utility
mf.dputil <- exp(NHNW.LS.dpconst + NHNW.ivCoeff * (NHNW.pkfact * mf.amhtt + NHNW.opfact * mf.mdhtt) +
           sweep(NHNW.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHNW.dp.walkCoeff * ma.auov, "+"))

# NHNW Passenger Utility
mf.pautil <- exp(NHNW.LS.paconst + NHNW.ivCoeff * (NHNW.pkfact * mf.amhtt + NHNW.opfact * mf.mdhtt) + 
           sweep(NHNW.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHNW.pa.walkCoeff * ma.auov, "+"))

# NHNW Transit Utility (weighted average)
mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)

mf.amtconst <- (NHNW.LS.tranconst + mf.amtvehc + mf.amtstpc)
mf.mdtconst <- (NHNW.LS.tranconst + mf.mdtvehc + mf.mdtstpc)

ivt <- NHNW.pkfact * NHNW.ivCoeff * mf.amtiv + NHNW.opfact * NHNW.ivCoeff * mf.mdtiv
trconst <- NHNW.pkfact * mf.amtconst + NHNW.opfact * mf.mdtconst
mf.trwait1 <- NHNW.pkfact * mf.amtwt1 + NHNW.opfact * mf.mdtwt1
mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
mf.trwait2 <- NHNW.pkfact * mf.amtwt2 + NHNW.opfact * mf.mdtwt2
mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
mf.trwalk <- NHNW.pkfact * mf.amtwalk + NHNW.opfact * mf.mdtwalk
mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
mf.transfers <- NHNW.pkfact * mf.amtxfr + NHNW.opfact * mf.mdtxfr

oviv <- NHNW.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (NHNW.pkfact * mf.amtiv + NHNW.opfact * mf.mdtiv))

mf.trutil <- exp(trconst + ivt + oviv + NHNW.tr.wait1Coeff * mf.trwait1 + NHNW.tr.wait2Coeff * mf.trwait2 + NHNW.tr.walkCoeff * mf.trwalk + NHNW.tr.transCoeff * mf.transfers + cc * mf.trfare)
mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# NHNW Bike Utility
mf.bkutil <- exp(NHNW.LS.bikeconst + NHNW.bk.ubdistCoeff * mf.ubdist + NHNW.bk.nbcostCoeff * mf.nbcost)

# NHNW Walk Utility
mf.wkutil <- exp(NHNW.LS.walkconst + NHNW.wk.walkCoeff * mf.wtime)
mf.wkutil[mf.wtime[,]>100] <- 0

# NHNW Logsum
mf.nhnwls <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.bkutil + mf.wkutil)
