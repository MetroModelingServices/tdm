# k.writeLotsFinal.R
# writes final PnR lot info to CSV
# (all purposes, adjusted shadow prices) 

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

load(paste(project.dir,"/model/lottaz.RData",sep=''))
write.csv(lottaz, file=(paste(project.dir,"/model/lottaz_final.csv",sep='')), row.names=F)
load(paste(project.dir,"/model/lottazinf.RData",sep=''))
write.csv(lottazinf, file=(paste(project.dir,"/model/lottazinf_final.csv",sep='')), row.names=F)
