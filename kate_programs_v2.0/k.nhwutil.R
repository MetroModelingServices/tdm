# k.nhwutil.R
# NHW Destination Choice Logsums

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

  mf.amstlTadj <- mf.amstl*(.25)
  mf.mdstlTadj <- mf.mdstl*(.25)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(.25)
  mf.mdhtlTadj <- mf.mdhtl*(.25)

  mf.amhtlD <- (mf.amhtlTadj/60)*pkvot
  mf.mdhtlD <- (mf.mdhtlTadj/60)*opvot

  # Add Tolls
  mf.Spocketcost <- sweep((NHW.pkfact*mf.amstlD + NHW.opfact*mf.mdstlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amstl, mf.mdstl, mf.amstlTadj, mf.mdstlTadj, mf.amstlD, mf.mdstlD)

  mf.Hpocketcost <- sweep((NHW.pkfact*mf.amhtlD + NHW.opfact*mf.mdhtlD), 2, 0.5 * ma.stpkg, "+")
  rm (mf.amhtl, mf.mdhtl, mf.amhtlTadj, mf.mdhtlTadj, mf.amhtlD, mf.mdhtlD)
}

# Define cost coefficients
cc     <- NHW.all.cc     # auto operating costs coeff
pktc   <- NHW.all.pktc   # auto out of pocket costs: parking and tolls coeff
faresc <- NHW.all.faresc # transit fares coeff


# NHW Drive Alone Utility
mf.dautil <- exp(NHW.ivCoeff * (NHW.pkfact * mf.amstt + NHW.opfact * mf.mdstt) +
           sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, NHW.da.walkCoeff * ma.auov, "+"))

# NHW Drive with Passenger Utility
mf.dputil <- exp(NHW.LS.dpconst + NHW.ivCoeff * (NHW.pkfact * mf.amhtt + NHW.opfact * mf.mdhtt) +
           sweep(NHW.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHW.dp.walkCoeff * ma.auov, "+"))

# NHW Passenger Utility
mf.pautil <- exp(NHW.LS.paconst + NHW.ivCoeff * (NHW.pkfact * mf.amhtt + NHW.opfact * mf.mdhtt) + 
           sweep(NHW.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHW.pa.walkCoeff * ma.auov, "+"))

# NHW Transit Utility (weighted average)
mf.amtiv <- (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)
mf.mdtiv <- (mf.mdtbiv + mf.mdtliv + mf.mdtsciv + mf.mdtriv + mf.mdtbriv)

mf.amtconst <- (NHW.LS.tranconst + mf.amtvehc + mf.amtstpc)
mf.mdtconst <- (NHW.LS.tranconst + mf.mdtvehc + mf.mdtstpc)

ivt <- NHW.pkfact * NHW.ivCoeff * mf.amtiv + NHW.opfact * NHW.ivCoeff * mf.mdtiv
trconst <- NHW.pkfact * mf.amtconst + NHW.opfact * mf.mdtconst
mf.trwait1 <- NHW.pkfact * mf.amtwt1 + NHW.opfact * mf.mdtwt1
mf.trwait1 [mf.trwait1[,]>30 & mf.trwait1[,]<9990] <- 30
mf.trwait2 <- NHW.pkfact * mf.amtwt2 + NHW.opfact * mf.mdtwt2
mf.trwait2 [mf.trwait2[,]>30 & mf.trwait2[,]<9990] <- 30
mf.trwalk <- NHW.pkfact * mf.amtwalk + NHW.opfact * mf.mdtwalk
mf.trwalk[mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
mf.transfers <- NHW.pkfact * mf.amtxfr + NHW.opfact * mf.mdtxfr

oviv <- NHW.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (NHW.pkfact * mf.amtiv + NHW.opfact * mf.mdtiv))

mf.trutil <- exp(trconst + ivt + oviv + NHW.tr.wait1Coeff * mf.trwait1 + NHW.tr.wait2Coeff * mf.trwait2 + NHW.tr.walkCoeff * mf.trwalk + NHW.tr.transCoeff * mf.transfers + cc * mf.trfare)
mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0

# NHW Bike Utility
mf.bkutil <- exp(NHW.LS.bikeconst + NHW.bk.ubdistCoeff * mf.ubdist + NHW.bk.nbcostCoeff * mf.nbcost)

# NHW Walk Utility
mf.wkutil <- exp(NHW.LS.walkconst + NHW.wk.walkCoeff * mf.wtime)
mf.wkutil[mf.wtime[,]>100] <- 0

# NHW Logsum
mf.nhwls <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.bkutil + mf.wkutil)
