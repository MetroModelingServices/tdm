#k.nhw_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.nhwutil.R", sep='/'))

load("ma.nhwpr.dat")

source(paste(R.path, "k.nhwdist.R", sep='/'))

save(mf.nhwdt, file="mf.nhwdt.dat")

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#########################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER               #
#library(reshape)                                                                       #
#out.nhwls <- melt(mf.nhwls)                                                            #
#write.table(out.nhwls, file="mf.nhwls.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#########################################################################################

