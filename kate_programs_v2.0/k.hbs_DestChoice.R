#k.hbs_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hbsutil.R", sep='/'))

load("malist.hbs.dat")
attach(malist.hbs)

source(paste(R.path, "k.hbsdist.R", sep='/'))

save(mf.hbsdtl, file="mf.hbsdtl.dat")
save(mf.hbsdtm, file="mf.hbsdtm.dat")
save(mf.hbsdth, file="mf.hbsdth.dat")

detach(malist.hbs)

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#######################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER             #
#library(reshape)                                                                     #
#out.hsls <- melt(mf.hsls)                                                            #
#write.table(out.hsls, file="mf.hsls.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#######################################################################################

