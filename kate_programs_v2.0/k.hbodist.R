#k.hbodist.R

# Weighted Average Logsum
mf.hols <- HBO.lsLowWeight*mf.holsl + HBO.lsMidWeight*mf.holsm + HBO.lsHighWeight*mf.holsh

east2westhill<-as.matrix(array(0,c(numzones,numzones)))
east2westhill[ensemble.gw==2,ensemble.gw==1]<-1

westhill2east<-as.matrix(array(0,c(numzones,numzones)))
westhill2east[ensemble.gw==1,ensemble.gw==2]<-1

east2westriv<-as.matrix(array(0,c(numzones,numzones)))
east2westriv[ensemble.gr==2,ensemble.gr==1]<-1

westriv2east<-as.matrix(array(0,c(numzones,numzones)))
westriv2east[ensemble.gr==1,ensemble.gr==2]<-1

#############################################################
#  Raw HBO Utility                                          #
#############################################################
mf.util <- exp(sweep(HBO.lsCoeff * mf.hols
                   + HBO.logdistXorwaCoeff * mf.orwa * log (mf.tdist + 1)
                   + HBO.logdistXwaorCoeff * mf.waor * log (mf.tdist + 1)
                   + HBO.logdistXnoXingCoeff * ((mf.orwa + mf.waor)==0) * log (mf.tdist + 1)
                   + HBO.logdistXewWestHillsCoeff * east2westhill * log (mf.tdist + 1)
                   + HBO.logdistXweWestHillsCoeff * westhill2east * log (mf.tdist + 1)
                   + HBO.logdistXewWillRiverCoeff * east2westriv * log (mf.tdist + 1)
                   + HBO.logdistXweWillRiverCoeff * westriv2east * log (mf.tdist + 1)
                   , 2, log (HBO.aerCoeff * ma.aer
                   + HBO.amfCoeff * ma.amf + HBO.conCoeff * ma.con
                   + HBO.eduCoeff * ma.edu + HBO.fsdCoeff * ma.fsd
                   + HBO.govCoeff * ma.gov + HBO.hssCoeff * ma.hss
                   + HBO.mfgCoeff * ma.mfg + HBO.mhtCoeff * ma.mht
                   + HBO.osvCoeff * ma.osv + HBO.pbsCoeff * ma.pbs
                   + HBO.rcsCoeff * ma.rcs + HBO.twuCoeff * ma.twu
                   + HBO.wtCoeff * ma.wt + HBO.hhCoeff * ma.hh + 1), "+"))

ma.utsum <- apply(mf.util,1,sum)
mf.utsum <- matrix(ma.utsum,length(ma.utsum),length(ma.utsum))

# Low Income Distribution
mf.hbodtl <- matrix(0,numzones,numzones)
mf.hbodtl[mf.utsum!=0] <- mf.util[mf.utsum!=0]/mf.utsum[mf.utsum!=0]
mf.hbodtl <- sweep(mf.hbodtl,1,ma.hboprl,"*")

if (mce) {
  ma.holdcls <- log(ma.utsum)
#  save (ma.hboldcls, file="ma.hboldcls.dat")
#  write.table(ma.hboldcls, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hboldcls.csv", col.names=c("hboldcls"))
#  write.table(ma.hboprl, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hboprl.csv", col.names=c("hboprl"))
}

# Middle Income Distribution
mf.hbodtm <- matrix(0,numzones,numzones)
mf.hbodtm[mf.utsum!=0] <- mf.util[mf.utsum!=0]/mf.utsum[mf.utsum!=0]
mf.hbodtm <- sweep(mf.hbodtm,1,ma.hboprm,"*")

if (mce) {
  ma.homdcls <- log(ma.utsum)
#  save (ma.hbomdcls, file="ma.hbomdcls.dat")
#  write.table(ma.hbomdcls, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hbomdcls.csv", col.names=c("hbomdcls"))
#  write.table(ma.hboprm, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hboprm.csv", col.names=c("hboprm"))
}

# High Income Distribution
mf.hbodth <- matrix(0,numzones,numzones)
mf.hbodth[mf.utsum!=0] <- mf.util[mf.utsum!=0]/mf.utsum[mf.utsum!=0]
mf.hbodth <- sweep(mf.hbodth,1,ma.hboprh,"*")

if (mce) {
  ma.hohdcls <- log(ma.utsum)
#  save (ma.hbohdcls, file="ma.hbohdcls.dat")
#  write.table(ma.hbohdcls, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hbohdcls.csv", col.names=c("hbohdcls"))
#  write.table(ma.hboprh, sep=",", row.names=F, file="../_mceInputs/nonskims/ma.hboprh.csv", col.names=c("hboprh"))
}

if (mce) {
  purpose_dc <- 'ho'

  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_dest_choice_",purpose_dc,".omx",sep='')
  create_omx(omxFileName, numzones, numzones, 7)

  write_omx(file=omxFileName,
            matrix=get(paste("ma.",purpose_dc,"ldcls",sep='')),
            name=paste("ma.",purpose_dc,"ldcls",sep=''),
            replace=TRUE)

  write_omx(file=omxFileName,
            matrix=get(paste("ma.",purpose_dc,"mdcls",sep='')),
            name=paste("ma.",purpose_dc,"mdcls",sep=''),
            replace=TRUE)

  write_omx(file=omxFileName,
            matrix=get(paste("ma.",purpose_dc,"hdcls",sep='')),
            name=paste("ma.",purpose_dc,"hdcls",sep=''),
            replace=TRUE)
}

#############################################################
#  Total HBO Distribution                                   #
#############################################################
mf.hbodt <- mf.hbodtl + mf.hbodtm + mf.hbodth

# Remove temporary matrices 
rm(ma.utsum,mf.utsum,mf.util)

# 8-district summaries
if (file.access("hbodist.rpt", mode=0) == 0) {system ("rm hbodist.rpt")}

distsum("mf.hbodt", "HBoth Distribution - Total", "ga", 3, "hbodist", project, initials)
distsum("mf.hbodtl", "HBoth Distribution - LowInc", "ga", 3, "hbodist", project, initials)
distsum("mf.hbodtm", "HBoth Distribution - MidInc", "ga", 3, "hbodist", project, initials)
distsum("mf.hbodth", "HBoth Distribution - HighInc", "ga", 3, "hbodist", project, initials)

