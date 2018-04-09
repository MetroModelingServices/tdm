#k.sch_DestChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

source(paste(R.path, "k.LoadMatricesEns_other.R", sep='/'))

load("ma.schpr.dat")
load("ma.schat.dat")

source(paste(R.path, "k.schdist.R", sep='/'))

save(mf.schdt, file="mf.schdt.dat")
