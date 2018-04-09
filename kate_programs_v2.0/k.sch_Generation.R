#k.sch_Generation.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

source(paste(R.path, "k.LoadMatricesEns_other.R", sep='/'))

source(paste(R.path, "k.kid.R", sep='/'))
source(paste(R.path, "k.schgen.R", sep='/'))

save(ma.schpr, file="ma.schpr.dat")
save(ma.schat, file="ma.schat.dat")

rm(list=ls())
