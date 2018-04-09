# k.hbwutil.R 
# calculates LOGSUMS with travel times only - NO CONSTANTS OR COSTS
# modified by PB to incorporate SP survey results and PnR lot choice model
# modified for Metro implementation by AAB, Jan/Feb 2011

# Modify calibration constants HERE
dpconst   <- 0
paconst   <- 0
tranconst <- 0
prconst   <- -6.12
bikeconst <- 0
walkconst <- 0

#coefficients
ivCoeff = -0.03608

# Modify peaking factors HERE
pkfact <- 0.6058      # apply to AM skims
opfact <- 1 - pkfact  # apply to MD skims

# Drive Alone Operating Cost
mf.Sopcost <- sweep((autocost*mf.tdist), 2, ma.ltpkg, "+")
mf.Hopcost <- mf.Sopcost

if (toll == TRUE)
{
		print("About to calculate toll costs")
		
		# Adjust Toll Time to reflect difference in elasticity between assignment and model (.25)

		mf.amstlTadj <- mf.amstl*(.25)
		mf.amstlD <- (mf.amstlTadj/60)*pkvot
		
		mf.amhtlTadj <- mf.amhtl*(.25)
		mf.amhtlD <- (mf.amhtlTadj/60)*pkvot
		
		# Add Tolls
		mf.Sopcost <- mf.amstlD
		mf.Hopcost <- mf.amhtlD
}

inc <- "m"
cc  <- -0.5417

# HBW Drive Alone Utility
  mf.dautil <- exp (-0.03608*(mf.amstt)
      + sweep (cc * mf.Sopcost, 2, -0.09956*ma.auov, "+"))

# HBW Drive with Passenger Utility
  mf.dputil <- exp (dpconst - 0.03608 * (mf.amhtt)
      + sweep (cc * (mf.Hopcost*0.5), 2, -0.09956*(ma.auov + 5), "+"))

# HBW Passenger Utility
  mf.pautil <- exp (paconst - 0.03608 * (mf.amhtt)
      + sweep (cc * (mf.Hopcost*0.5), 2, -0.09956*(ma.auov + 5), "+"))

# HBW Transit Utility (weighted average)
    mf.amtiv = ivCoeff * (mf.amtbiv + mf.amtliv + mf.amtsciv + mf.amtriv + mf.amtbriv)

    am_trconst = (tranconst + mf.amtvehc + mf.amtstpc) * 0  # remove multiplication by 0 if constants are to be included in logsums

  mf.triv <- mf.amtiv
  trconst = am_trconst
  mf.trwt1 <- mf.amtwt1
  mf.trwt1 [mf.trwt1[,]>30 & mf.trwt1[,]<9990] <- 30
  mf.trwt2 <- mf.amtwt2
  mf.trwt2 [mf.trwt2[,]>30 & mf.trwt2[,]<9990] <- 30
  mf.trwalk <- mf.amtwalk
  mf.trwalk [mf.trwalk[,]>30 & mf.trwalk[,]<9990] <- 30
  mf.transfers <- mf.amtxfr

  mf.trutil <- exp (trconst + mf.triv - 0.05760*mf.trwt1 - 0.04002*mf.trwt2 - 0.09956*mf.trwalk - 0.3*mf.transfers + (cc * mf.trfare))
  mf.trutil [mf.trwt1[,]>9990 & mf.trwt1[,]<=99999] <- 0

# HBW Park and Ride Transit Utility (weighted average)
  
    # Drive Alone Utility
    mf.dautil_pnr <- exp (-0.03608*(mf.amstt) + cc * mf.Sopcost + 0*cc * autocost*mf.tdist)

    #lot choice parameters
    #general
    paramSet = list()
    paramSet$purpose = "hbw"
    #constants
    paramSet$formalConstant = 0 
    paramSet$informalConstant = 0
    #nesting coefficients
    paramSet$pnrNestCoeff = 0.75
    paramSet$formalNestCoeff = 0.5
    paramSet$informalNestCoeff = 0.5
    #lot coefficients
    paramSet$lotParkCostCoeff = 0
    
    #calculate daily logsum
    mf.prtutil = calcPNRUtilsDestChoice(log(mf.dautil_pnr), log(mf.trutil), project.dir, prconst, paramSet)

# HBW Bike Utility
  mf.bkutil <- exp (bikeconst - 0.8*mf.ubdist - 0.365*mf.cbcost)

# HBW Walk Utility
  mf.wkutil <- exp (walkconst - 4.307*log(mf.wdist))
  mf.wkutil [mf.wdist[,]>5 & mf.wdist[,]<=99999] <- 0

# HBW Logsum
  mf.logsum <- log(mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil)

## Transpose of HBW Logsum to create PM2 table - Save out temporary data tables for Metroscope analysis
  mf.logsum.pm <- t(mf.logsum)
  save(mf.logsum.pm, file="mf.logsum.pm.dat")
  
  if(toll == TRUE) {
    mf.pm2toll <- t( mf.amstl / tollvalue)
  } else {
    mf.pm2toll <- mf.amstt * 0
  }
  save(mf.pm2toll, file="mf.pm2toll.dat")
  
  mf.pm2stt <- t(mf.amstt)
  save(mf.pm2stt, file="mf.pm2stt.dat")
  
  mf.totutil.am  <- mf.dautil + mf.dputil + mf.pautil + mf.trutil + mf.prtutil + mf.bkutil + mf.wkutil
  mf.tranutil.am <- mf.trutil + mf.prtutil
  
  mf.trshutil.am <- mf.tranutil.am / mf.totutil.am
  mf.trshutil.pm <- t(mf.trshutil.am)
  
  save(mf.trshutil.pm, file="mf.trshutil.pm.dat")
