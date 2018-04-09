#k.hbc_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hbcutil.R", sep='/'))

load("malist.col.dat")
attach(malist.col)

source(paste(R.path, "k.hbcdist.R", sep='/'))

save(mf.colldtl, file="mf.colldtl.dat")
save(mf.colldtm, file="mf.colldtm.dat")
save(mf.colldth, file="mf.colldth.dat")

detach(malist.col)

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#######################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER             #
#library(reshape)                                                                     #
#out.hcls <- melt(mf.hcls)                                                            #
#write.table(out.hcls, file="mf.hcls.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#######################################################################################

