#k.hbo_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'DestChoice'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.hboutil.R", sep='/'))

load("malist.hbo.dat")
attach(malist.hbo)

source(paste(R.path, "k.hbodist.R", sep='/'))

save(mf.hbodtl, file="mf.hbodtl.dat")
save(mf.hbodtm, file="mf.hbodtm.dat")
save(mf.hbodth, file="mf.hbodth.dat")

detach(malist.hbo)

#source(paste(R.path, "k.DestChoiceCleanup.R", sep='/'))

memory.size(max=TRUE)

#######################################################################################
## ONLY NECESSARY FOR EXPORTING CSVs FOR TEST RUNS - CAN BE REMOVED AFTER             #
#library(reshape)                                                                     
#out.hols <- melt(mf.hols)                                                            #
#write.table(out.hols, file="mf.hols.csv", sep=",", row.names=FALSE, col.names=FALSE) #
#######################################################################################
