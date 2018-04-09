# k.nhwms.R 
# NHW Mode Choice

print("Running nhw mode choice")

load("ma.nhwpr.dat")
load("ma.mixrhm.dat")
load("ma.mixthm.dat")
load("mf.nhwdt.dat")

if (mce) {
  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_nhw.omx",sep='')
  create_omx(omxFileName, numzones, numzones, 7)
}

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

  mf.amstlTadj <- mf.amstl*(.75)
  mf.mdstlTadj <- mf.mdstl*(.75)

  mf.amstlD <- (mf.amstlTadj/60)*pkvot
  mf.mdstlD <- (mf.mdstlTadj/60)*opvot

  mf.amhtlTadj <- mf.amhtl*(.75)
  mf.mdhtlTadj <- mf.mdhtl*(.75)

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

# Begin time of day loop
  for (y in 1:2) {
    if (y==1) {
      todfact <- NHW.pkfact
      timeper <- "am"
      ma.hhcov <- ma.pkhhcov
      ma.empcov <- ma.pkempcov
    }
    if (y==2) {
      todfact <- NHW.opfact
      timeper <- "md"
      ma.hhcov <- ma.ophhcov
      ma.empcov <- ma.opempcov
    }

### NHW Drive Alone Utility
    mf.dautil <- exp(NHW.ivCoeff * (get(paste("mf.",timeper,"stt",sep=''))) +
               sweep(cc * mf.Sopcost + pktc * mf.Spocketcost, 2, NHW.da.walkCoeff * ma.auov, "+"))


### NHW Drive with Passenger Utility
    mf.dputil <- exp(NHW.MC.dpconst + NHW.ivCoeff * (get(paste("mf.",timeper,"htt",sep=''))) +
               sweep(NHW.dp.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHW.dp.walkCoeff * ma.auov, "+"))

### NHW Passenger Utility
    mf.pautil <- exp(NHW.MC.paconst + NHW.ivCoeff * (get(paste("mf.",timeper,"htt",sep=''))) +
               sweep(NHW.pa.autoCostFac * (cc * mf.Hopcost + pktc * mf.Hpocketcost), 2, NHW.pa.walkCoeff * ma.auov, "+"))

### NHW Transit Utility

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

# NHW Transit Utility
    ivt     <- NHW.ivCoeff * (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt)
    trconst <- NHW.MC.tranconst + mf.trvehc + mf.trstpc
    oviv    <- NHW.tr.trOVIVCoeff * ((mf.trwait1 + mf.trwait2 + mf.trwalk) / (mf.trbivt + mf.trlivt + mf.trscivt + mf.trrivt + mf.trbrivt))

    mf.trutil <- exp(trconst + ivt + NHW.tr.wait1Coeff * mf.trwait1 + NHW.tr.wait2Coeff  * mf.trwait2 + NHW.tr.walkCoeff * mf.trwalk +
                     NHW.tr.transCoeff * mf.transfers + faresc * mf.trfare + oviv)
    mf.trutil[mf.trwait1[,]>9990 & mf.trwait1[,]<=99999] <- 0


# NHW Bike Utility
    mf.bkutil <- exp(sweep(NHW.MC.bikeconst + NHW.bk.inbikeCoeff * mf.inbike + NHW.bk.ubdistCoeff * mf.ubdist + NHW.bk.nbcostCoeff * mf.nbcost, 2, NHW.bk.logMixTotACoeff * log(ma.mixthm + 1), "+"))


# NHW Walk Utility
    mf.wkutil <- exp(sweep(NHW.MC.walkconst + NHW.wk.walkCoeff * mf.wtime, 1, NHW.wk.logMixRetPCoeff * log(ma.mixrhm + 1), "+"))
    mf.wkutil[mf.wtime[,]>100] <- 0


#####  Compute Total Utilities and Save in Temporary Matrices

    print("Calculating total utilities")

#Coverage Factor Matrices
    mf.hhcov        <- matrix(ma.hhcov, numzones, numzones)
    mf.empcov       <- matrix(ma.empcov, numzones, numzones)
    tmf.empcov      <- t(mf.empcov)


# Transit Access Available at Both Trip Ends
    mf.trok <- mf.empcov * tmf.empcov

# Transit Access Unavailable
    mf.trno <- 1 - mf.trok

# Total Utility of All Modes Less Transit
    mf.ut.notr <- mf.dautil + mf.dputil + mf.pautil + mf.bkutil + mf.wkutil

# Total Utility of All Modes
    mf.ut.all <- mf.ut.notr + mf.trutil

# Define Peak/Off-peak names for saving out final P->A tables
    if (timeper == 'am') { timeper2 <- 'pk' } else { timeper2 <- 'op' }

# Raw NHW Drive Alone Trips
    assign(paste("mf.nhwda", timeper2, sep="."), mf.dautil * (mf.trok/mf.ut.all + mf.trno/mf.ut.notr) * mf.nhwdt * todfact)

# Raw NHW Drive with Passenger Trips
    assign(paste("mf.nhwdp", timeper2, sep="."), mf.dputil * (mf.trok/mf.ut.all + mf.trno/mf.ut.notr) * mf.nhwdt * todfact)

# Raw NHW Passenger Trips
    assign(paste("mf.nhwpa", timeper2, sep="."), mf.pautil * (mf.trok/mf.ut.all + mf.trno/mf.ut.notr) * mf.nhwdt * todfact)

# Raw NHW Transit Trips
    assign(paste("mf.nhwtr", timeper2, sep="."), mf.trutil * (mf.trok/mf.ut.all) * mf.nhwdt * todfact)

# Raw NHW Bike Trips
    assign(paste("mf.nhwbike", timeper2, sep="."), mf.bkutil * (mf.trok/mf.ut.all + mf.trno/mf.ut.notr) * mf.nhwdt * todfact)

# Raw NHW Walk Trips
    assign(paste("mf.nhwwalk", timeper2, sep="."), mf.wkutil * (mf.trok/mf.ut.all + mf.trno/mf.ut.notr) * mf.nhwdt * todfact)

# Save out mode by each timeperiod
    save(list=paste("mf.nhwda.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwda.",timeper2,".dat",sep=''))
    save(list=paste("mf.nhwdp.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwdp.",timeper2,".dat",sep=''))
    save(list=paste("mf.nhwpa.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwpa.",timeper2,".dat",sep=''))
    save(list=paste("mf.nhwtr.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwtr.",timeper2,".dat",sep=''))
    save(list=paste("mf.nhwwalk.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwwalk.",timeper2,".dat",sep=''))
    save(list=paste("mf.nhwbike.",timeper2,sep=''), file=paste(project.dir,"/model/mf.nhwbike.",timeper2,".dat",sep=''))

    if (mce) {
      modes <- c('da', 'dp', 'pa', 'tr', 'bike', 'walk')
      for (m in 1:length(modes)) {
        write_omx(file=omxFileName,
                  matrix=get(paste("mf.nhw",modes[m],".",timeper2,sep='')),
                  name=paste("mf.nhw",modes[m],".",timeper2,sep=''),
                  replace=TRUE)
      }
    }
  }  ##  END OF TIME OF DAY LOOP

rm(mf.nhwdt)
