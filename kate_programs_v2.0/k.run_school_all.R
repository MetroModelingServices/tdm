#k.run_school_all.R

##  School Model

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

source(paste(R.path, "k.LoadMatricesEns_other.R", sep='/'))

source(paste(R.path, "k.kid.R", sep='/'))
source(paste(R.path, "k.schgen.R", sep='/'))
source(paste(R.path, "k.schdist.R", sep='/'))

save(mf.schdt, file="mf.schdt.dat")

source(paste(R.path, "k.schms.R", sep='/'))
source(paste(R.path, "k.msoutsch.R", sep='/'))

rm(list=ls())
