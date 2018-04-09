## k.metroscopeOutputs.R
## created by PGB 8/2011
##
## loads files saved during hbw mode split run, reformats and prints a csv for use in Metroscope analysis
## requires that the reshape R package is installed

library(reshape)

## Load temporary files for Metroscope outputs
load("mf.logsum.pm.dat")
load("mf.pm2stt.dat")
load("mf.pm2toll.dat")
load("mf.trshutil.pm.dat")

## Formula for calculating Adjusted PM2STT based on transit utility mode share, tolling, and PM2 SOV travel time
mf.adjstt <- exp(((0.8046 * mf.trshutil.pm) + (-0.08860 * mf.pm2toll) + (-1.1844 * log(mf.pm2stt))) / -1.1844)

# Reformat PM2 logsum data files
met.logsum.temp <- mf.logsum.pm
colnames(met.logsum.temp) <- (1:numzones)
met.logsum <- melt(met.logsum.temp)

## Reformat adjusted PM2STT data files
met.adjstt.temp <- mf.adjstt
colnames(met.adjstt.temp) <- (1:numzones)
met.adjstt <- melt(met.adjstt.temp)

# Reformat PM2 SOV travel times
met.pm2stt.temp <- mf.pm2stt
colnames(met.pm2stt.temp) <- (1:numzones)
met.pm2stt <- melt(met.pm2stt.temp)

# Reformat PM2 transit utility share data files
met.trshutil.temp <- mf.trshutil.pm
colnames(met.trshutil.temp) <- (1:numzones)
met.trshutil <- melt(met.trshutil.temp)

# Reformat PM2 toll percentage
met.pm2toll.temp <- mf.pm2toll
colnames(met.pm2toll.temp) <- (1:numzones)
met.pm2toll <- melt(met.pm2toll.temp)

metroscopeOutput <- cbind(met.adjstt[,1:2],
                    round(met.adjstt[,3:3],digits=4))

## Write final csv for use in Metroscope modeling
write("FROM,TO,ADJPM2STT",    file=paste("AdjustedPM2STTforMetroscope_",year,".csv",sep=""), sep=",")
write.table(metroscopeOutput, file=paste("AdjustedPM2STTforMetroscope_",year,".csv",sep=""), sep=",", append=TRUE, row.names=FALSE, col.names=FALSE)

## Uncomment the following lines (remove one # from the beginning) to produce more detailed summaries of Metroscope outputs

## Creat zonal summaries for Metroscope inputs/outputs
cells <- c(1, 139, 160, 387, 546, 670, 730, 817, 866, 1007, 1065, 1189, 1322, 1492, 1628)

logsumarray   <- matrix(nrow=length(cells), ncol=length(cells), dimnames = list(cells, cells))
tranutilarray <- matrix(nrow=length(cells), ncol=length(cells), dimnames = list(cells, cells))
tollarray     <- matrix(nrow=length(cells), ncol=length(cells), dimnames = list(cells, cells))
pm2sttarray   <- matrix(nrow=length(cells), ncol=length(cells), dimnames = list(cells, cells))
adjsttarray   <- matrix(nrow=length(cells), ncol=length(cells), dimnames = list(cells, cells))

i <- 1
for (x in cells) {
  j <- 1
  for (y in cells) {
    logsumarray[i,j]   <- round(mf.logsum.pm[x,y],2)
    tranutilarray[i,j] <- round(mf.trshutil.pm[x,y],2)
    tollarray[i,j]     <- round(mf.pm2toll[x,y],2)
    pm2sttarray[i,j]   <- round(mf.pm2stt[x,y],2)
    adjsttarray[i,j]   <- round(mf.adjstt[x,y],2)
    j <- j + 1
  }
  i <- i + 1
}

write("PM2 Logsum",      file = "MetroscopeZoneCheck.rpt", sep= " ")
write.table(logsumarray, file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write("\n",              file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)

write("Transit Utility Share", file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write.table(tranutilarray,     file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write("\n",                    file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)

write("Toll Share",    file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write.table(tollarray, file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write("\n",            file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)

write("Original PM2STT", file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write.table(pm2sttarray, file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write("\n",              file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)

write("Adjusted PM2STT", file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write.table(adjsttarray, file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)
write("\n",              file = "MetroscopeZoneCheck.rpt", sep= " ", append = TRUE)

metroscopeOutput <- cbind(met.logsum[,1:2],
                    round(met.logsum[,3:3],digits=4),
                    round(met.trshutil[,3:3],digits=4),
                    round(met.pm2toll[,3:3],digits=4),
                    round(met.pm2stt[,3:3],digits=4),
                    round(met.adjstt[,3:3],digits=4))

## Write final csv for use in Metroscope modeling
write("FROM,TO,LOGSUM,MODESHARE,TOLLSHARE,PM2STT,ADJPM2STT", file=paste("AdjustedPM2STTforMetroscope_",year,".csv",sep=""), sep=",")
write.table(metroscopeOutput, file=paste("AdjustedPM2STTforMetroscope_",year,".csv",sep=""), sep=",", append=TRUE, row.names=FALSE, col.names=FALSE)
