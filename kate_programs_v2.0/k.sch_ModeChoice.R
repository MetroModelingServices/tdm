#k.sch_ModeChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

source(paste(R.path, "k.LoadMatricesEns_other.R", sep='/'))

load(file="mf.schdt.dat")
source(paste(R.path, "k.schms.R", sep='/'))
source(paste(R.path, "k.msoutsch.R", sep='/'))

rm(list=ls())
