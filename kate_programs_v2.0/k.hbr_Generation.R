#k.hbr_Generation.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

stage <- 'Generation'
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

#  Pre Generation
source(paste(R.path, "access.R", sep='/'))
save(ma.mixrhm,file="ma.mixrhm.dat")
save(ma.mixthm,file="ma.mixthm.dat")

source(paste(R.path, "k.whia.R", sep='/'))
   #save (mf.w0hia, file="mf.w0hia.dat")
   #save (mf.w1hia, file="mf.w1hia.dat")
   #save (mf.w2hia, file="mf.w2hia.dat")
   #save (mf.w3hia, file="mf.w3hia.dat")

source(paste(R.path, "k.chwi.R", sep='/'))
   #save (mf.cval, file="mf.cval.dat")

#####  Calculate auto and transit composite skims for lot choice later
####source(paste(R.path, "k.hbrpnrSkims.R", sep='/'))

#  Generation
source(paste(R.path, "k.hbrgen.R", sep='/'))

source(paste(R.path, "k.GenerationCleanup.R", sep='/'))

memory.size(max=TRUE)
