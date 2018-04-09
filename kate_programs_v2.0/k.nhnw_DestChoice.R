#k.nhnw_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.nhnwutil.R", sep='/'))

load("ma.nhnwpr.dat")

source(paste(R.path, "k.nhnwdist.R", sep='/'))

save(mf.nhnwdt, file="mf.nhnwdt.dat")

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

###########################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER                 #
#library(reshape)                                                                         #
#out.nhnwls <- melt(mf.nhnwls)                                                            #
#write.table(out.nhnwls, file="mf.nhnwls.csv", sep=",", row.names=FALSE, col.names=FALSE) #
###########################################################################################

