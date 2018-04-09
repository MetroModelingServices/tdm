## Creates work / non-work summaries of trip tables based on defined trip purpose
## Call from ./model directory using following command line argument at the CYGWIN prompt:
##
## > R -q --slave --vanilla --args gc < V:/tbm/kate/programs_v1.0/k.ms_wnw.R
##
## Where --args gc defines the ensemble to be used in the summary ('gc' in this example)
##
## Creates four trip tables in the ./model directory, with the prefix of the ensemble name specified above


source("../k.model_setup.R")
source(paste(R.path, "metro_R_functions.R", sep='/'))

name <- commandArgs(1)

ens.in       <- scan(paste("../ens/ens", name, "csv", sep="."), what=list(zone=0,val=0), quiet=TRUE, sep=",")
ensemble.ens <- ens.in$val

load("mf.hwda.dat")
load("mf.hwdp.dat")
load("mf.hwpa.dat")
load("mf.hwtr.dat")
load("mf.hwprtr.dat")
load("mf.hwbike.dat")
load("mf.hwwalk.dat")
hwtrtot <- mf.hwtr.sum + mf.hwprtr.sum
hwpertot <- hwtrtot + mf.hwda.sum + mf.hwdp.sum + mf.hwpa.sum + mf.hwbike.sum + mf.hwwalk.sum

load("mf.hsda.dat")
load("mf.hsdp.dat")
load("mf.hspa.dat")
load("mf.hstr.dat")
load("mf.hsprtr.dat")
load("mf.hsbike.dat")
load("mf.hswalk.dat")
hstrtot <- mf.hstr.sum + mf.hsprtr.sum
hspertot <- hstrtot + mf.hsda.sum + mf.hsdp.sum + mf.hspa.sum + mf.hsbike.sum + mf.hswalk.sum

load("mf.hrda.dat")
load("mf.hrdp.dat")
load("mf.hrpa.dat")
load("mf.hrtr.dat")
load("mf.hrprtr.dat")
load("mf.hrbike.dat")
load("mf.hrwalk.dat")
hrtrtot <- mf.hrtr.sum + mf.hrprtr.sum
hrpertot <- hrtrtot + mf.hrda.sum + mf.hrdp.sum + mf.hrpa.sum + mf.hrbike.sum + mf.hrwalk.sum

load("mf.hoda.dat")
load("mf.hodp.dat")
load("mf.hopa.dat")
load("mf.hotr.dat")
load("mf.hoprtr.dat")
load("mf.hobike.dat")
load("mf.howalk.dat")
hotrtot <- mf.hotr.sum + mf.hoprtr.sum
hopertot <- hotrtot + mf.hoda.sum + mf.hodp.sum + mf.hopa.sum + mf.hobike.sum + mf.howalk.sum

load("mf.schveh.dat")
load("mf.schtr.dat")
load("mf.schpas.dat")
load("mf.schbus.dat")
load("mf.schwalk.dat")
load("mf.schbike.dat")
schtrtot <- mf.schtr
schpertot <- schtrtot + mf.schveh + mf.schpas + mf.schwalk + mf.schbike + mf.schbus

load("mf.hcda.dat")
load("mf.hcdp.dat")
load("mf.hcpa.dat")
load("mf.hctr.dat")
load("mf.hcprtr.dat")
load("mf.hcbike.dat")
load("mf.hcwalk.dat")
hctrtot <- mf.hctr + mf.hcprtr
hcpertot <- hctrtot + mf.hcda + mf.hcdp + mf.hcpa + mf.hcbike + mf.hcwalk

load("mf.nhwda.dat")
load("mf.nhwdp.dat")
load("mf.nhwpa.dat")
load("mf.nhwtr.dat")
load("mf.nhwbike.dat")
load("mf.nhwwalk.dat")
nhwtrtot <- mf.nhwtr 
nhwpertot <- nhwtrtot + mf.nhwda + mf.nhwdp + mf.nhwpa + mf.nhwbike + mf.nhwwalk

load("mf.nhnwda.dat")
load("mf.nhnwdp.dat")
load("mf.nhnwpa.dat")
load("mf.nhnwtr.dat")
load("mf.nhnwbike.dat")
load("mf.nhnwwalk.dat")
nhnwtrtot <- mf.nhnwtr
nhnwpertot <- nhnwtrtot + mf.nhnwda + mf.nhnwdp + mf.nhnwpa +  mf.nhnwbike + mf.nhnwwalk

dataList           <- read.csv(paste(airport_dir,"sov_trips_Daily.csv",sep='/'),sep=",",header=F)
mf.SOVairportTrips <- t(array(dataList[,3], dim=c(numzones,numzones)))

dataList           <- read.csv(paste(airport_dir,"hov_trips_Daily.csv",sep='/'),sep=",",header=F)
mf.HOVairportTrips <- t(array(dataList[,3], dim=c(numzones,numzones)))

dataList           <- read.csv(paste(airport_dir,"lrt_trips_Daily.csv",sep='/'),sep=",",header=F)
mf.LRTairportTrips <- t(array(dataList[,3], dim=c(numzones,numzones)))

mf.pdxaupr <- mf.SOVairportTrips + mf.HOVairportTrips * 2.24
mf.pdxlrt <- mf.LRTairportTrips
mf.pdxpertot <- mf.pdxaupr + mf.pdxlrt

mf.hwpertot <- hwpertot
mf.hwtrtot <- hwtrtot
mf.nwpertot <- hspertot + hrpertot + hopertot + schpertot + hcpertot + nhwpertot + nhnwpertot + mf.pdxpertot
mf.nwtrtot <- hstrtot + hrtrtot + hotrtot + schtrtot + hctrtot + nhwtrtot + nhnwtrtot + mf.pdxlrt

outfile <- file(paste(name,"_wnw_district_summary.csv",sep=""),"w")

cat("mf.hwpertot","\n",1:max(ensemble.ens),"\n",sep=",",file=outfile)
write.table(round(district_squeeze(mf.hwpertot,ensemble.ens),3),outfile,sep=",",col.names=F)
cat("mf.hwtrtot","\n",1:max(ensemble.ens),"\n",sep=",",file=outfile)
write.table(round(district_squeeze(mf.hwtrtot,ensemble.ens),3),outfile,sep=",",col.names=F)
cat("mf.nwpertot","\n",1:max(ensemble.ens),"\n",sep=",",file=outfile)
write.table(round(district_squeeze(mf.nwpertot,ensemble.ens),3),outfile,sep=",",col.names=F)
cat("mf.nwtrtot","\n",1:max(ensemble.ens),"\n",sep=",",file=outfile)
write.table(round(district_squeeze(mf.nwtrtot,ensemble.ens),3),outfile,sep=",",col.names=F)
