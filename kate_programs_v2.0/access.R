#access.R

#Outputs:
#mo.mixthm, mo.mixrhm, mo.tot30t

#Replace ZERO values in mf.wdist with 9999
#This will prevent division by ZERO, which results in garbage mixed use indicator vectors
mf.wdist[mf.wdist[,]==0] <- 9999

#Calculate tothm: Total emp w/in half mile

mo.tothm<-apply(sweep((mf.wdist<=0.34),2,ma.totemp,"*")[],1,sum) +
          apply(sweep(((mf.wdist > .34 & mf.wdist <=1) * 
          ((.50 - (mf.wdist/2))/mf.wdist)),2,ma.totemp,"*")[],1,sum)

#Calculate rethm: Total retail w/in half mile

mo.rethm<-apply(sweep((mf.wdist<=0.34),2,ma.rcs,"*")[],1,sum) +
          apply(sweep(((mf.wdist > .34 & mf.wdist <=1) * 
          ((.50 - (mf.wdist/2))/mf.wdist)),2,ma.rcs,"*")[],1,sum)

#Calculate hhhm: Households w/in half-mile

mo.hhhm<-apply(sweep((mf.wdist<=0.34),2,ma.hh,"*")[],1,sum) +
         apply(sweep(((mf.wdist > .34 & mf.wdist <=1) *
         ((.50 - (mf.wdist/2))/mf.wdist)),2,ma.hh,"*")[],1,sum)


#Calculate hhhm mean
ms.hhhm.mean<-mean(mo.hhhm)

#Calculate tothm mean
ms.tothm.mean<-mean(mo.tothm)

#Calculate inthm mean
ms.inthm.mean<-mean(ma.inthm)

#Calculate rethm mean
ms.rethm.mean<-mean(mo.rethm)

#Calculate mixthm: Mixed Use (Total) w/in half mile

ma.mixthm<-(ma.inthm * (mo.tothm * (ms.inthm.mean/ms.tothm.mean)) *
(mo.hhhm * (ms.inthm.mean/ms.hhhm.mean))) /
(ma.inthm + (mo.tothm * (ms.inthm.mean / ms.tothm.mean)) +
(mo.hhhm * (ms.inthm.mean / ms.hhhm.mean)))

ma.mixthm[!is.finite(ma.mixthm[])]<-.0001
ma.mixthm[ma.mixthm[]==0]<-.0001

#Calculate mixrhm: Mixed Use (retail) w/in half mile

ma.mixrhm<-(ma.inthm * (mo.rethm * (ms.inthm.mean / ms.rethm.mean)) *
(mo.hhhm * (ms.inthm.mean / ms.hhhm.mean))) /
(ma.inthm + (mo.rethm * (ms.inthm.mean / ms.rethm.mean)) +
(mo.hhhm * (ms.inthm.mean / ms.hhhm.mean)))

ma.mixrhm[!is.finite(ma.mixrhm[])]<-.0001
ma.mixrhm[ma.mixrhm[]==0]<-.0001

#Calculate tot30t: Total emp w/in 30 minutes by transit
mf.ttime<-mf.mdtbiv + mf.mdtliv + mf.mdtriv + mf.mdtsciv + mf.mdtbriv + mf.mdtwt1 + mf.mdtwt2 + mf.mdtwalk

ma.tot30t<-apply(sweep((mf.ttime<=20),2,ma.totemp,"*")[],1,sum) +
            apply(sweep(((mf.ttime > 20 & mf.ttime <= 60) *
            ((30 - (mf.ttime/2))/mf.ttime)),2,ma.totemp,"*")[],1,sum)

# Output to csv for estimation purposes
###final <- cbind(1:numzones, ma.mixrhm, ma.mixthm, ma.tot30t)
###write("TAZ, MIXRHM, MIXTHM, TOT30T", file="kate_mixed-use_vectors.csv")
###write.table(final, file="kate_mixed-use_vectors.csv", append=T, row.names=F, col.names=F, sep=",")
