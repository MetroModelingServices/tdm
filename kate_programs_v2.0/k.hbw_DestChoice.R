#k.hbw_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hbwutil.R", sep='/'))

if (metroscope == TRUE)
{
  source(paste(R.path, "k.hbwutil_metroscope.R", sep="/")) 
  source(paste(R.path, "k.metroscopeOutputs.R", sep="/"))
}

load("malist.hbw.dat")
attach(malist.hbw)

source(paste(R.path, "k.hbwdist.R", sep='/'))

save(mf.hbwdtl, file="mf.hbwdtl.dat")
save(mf.hbwdtm, file="mf.hbwdtm.dat")
save(mf.hbwdth, file="mf.hbwdth.dat")

detach(malist.hbw)

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#########################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER               #
#library(reshape)                                                                       #
#out.hwlsl <- melt(mf.hwlsl)                                                            #
#write.table(out.hwlsl, file="mf.hwlsl.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#out.hwlsm <- melt(mf.hwlsm)                                                            #
#write.table(out.hwlsm, file="mf.hwlsm.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#out.hwlsh <- melt(mf.hwlsh)                                                            #
#write.table(out.hwlsh, file="mf.hwlsh.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#########################################################################################

