#k.hbr_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hbrutil.R", sep='/'))

load("malist.hbr.dat")
attach(malist.hbr)

source(paste(R.path, "k.hbrdist.R", sep='/'))

save(mf.hbrdtl, file="mf.hbrdtl.dat")
save(mf.hbrdtm, file="mf.hbrdtm.dat")
save(mf.hbrdth, file="mf.hbrdth.dat")

detach(malist.hbr)

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#######################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER             #
#library(reshape)                                                                     #
#out.hrls <- melt(mf.hrls)                                                            #
#write.table(out.hrls, file="mf.hrls.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#######################################################################################

