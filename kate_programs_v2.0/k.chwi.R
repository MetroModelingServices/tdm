#k.chwi.R  
#Car Ownership Model

# mf.cval column order, by hia:
# listed as c <# cars> w <# workers>
#
# CVAL0 (mf.cval[,1:256])
#     c0w0, c0w1, c0w2, c0w3,
# CVAL1 (mf.cval[,257:448])
#     c1w2, c1w3, c2w3
# CVAL2 (mf.cval[,449:640])
#     c1w1, c2w2, c3w3 
# CVAL3 (mf.cval[,641:1024])
#     c1w0, c2w0, c2w1, c3w0, c3w1, c3w2

# Constants & Coefficients
car0.const       <- -1.302779
car1.const       <- -1.4954
car2.const       <- -1.826844
car0.incomeCoeff <- -1.674538
car1.incomeCoeff <- -0.8833405
car2.incomeCoeff <- -0.1749333
car0.sfPctCoeff  <- -2.072108
car1.sfPctCoeff  <- -1.563306
car2.sfPctCoeff  <- 0
car0.tot30tCoeff <- 0.016892
car1.tot30tCoeff <- 0.0102004
car2.tot30tCoeff <- 0.0037696
car0.mixthmCoeff <- 0.4233423
car1.mixthmCoeff <- 0.2223324
car2.mixthmCoeff <- 0.1544361

# Utility Expression
utilCalcCar <- function(numcars,sf)
{
  exp(get(paste("car",numcars,".const",sep='')) +
      get(paste("car",numcars,".h1w0Coeff",sep='')) +
      get(paste("car",numcars,".h1w1Coeff",sep='')) +
      get(paste("car",numcars,".h2w0Coeff",sep='')) +
      get(paste("car",numcars,".h2w1Coeff",sep='')) +
      get(paste("car",numcars,".h2w2Coeff",sep='')) +
      get(paste("car",numcars,".h3w0Coeff",sep='')) +
      get(paste("car",numcars,".h3w1Coeff",sep='')) +
      get(paste("car",numcars,".h3w2Coeff",sep='')) +
      get(paste("car",numcars,".h3w3Coeff",sep='')) +
      get(paste("car",numcars,".h4w0Coeff",sep='')) +
      get(paste("car",numcars,".h4w1Coeff",sep='')) +
      get(paste("car",numcars,".h4w2Coeff",sep='')) +
      get(paste("car",numcars,".h4w3Coeff",sep='')) +
      get(paste("car",numcars,".incomeCoeff",sep='')) * i + 
      get(paste("car",numcars,".tot30tCoeff",sep='')) * (ma.tot30t/1000) + 
      get(paste("car",numcars,".mixthmCoeff",sep='')) * log(ma.mixthm + 1) + 
      get(paste("car",numcars,".sfPctCoeff",sep='')) * sf)
}

#hia placeholder
x <- 0

#Begin Worker Loop (0-3)
for (w in 0:3) {
  
  #Begin HH Loop (1-4)
  for (h in 1:4) {

    if(h==1 && w==0) {
      car0.h1w0Coeff <- 4.922765  ;car1.h1w0Coeff <- 6.356808 ;car2.h1w0Coeff <- 2.754803 } else {
      car0.h1w0Coeff <- 0         ;car1.h1w0Coeff <- 0        ;car2.h1w0Coeff <- 0}
    if(h==1 && w==1) {                          
      car0.h1w1Coeff <- 3.863208  ;car1.h1w1Coeff <- 5.924453 ;car2.h1w1Coeff <- 2.394431 } else {
      car0.h1w1Coeff <- 0         ;car1.h1w1Coeff <- 0        ;car2.h1w1Coeff <- 0}
    if(h==2 && w==0) {                          
      car0.h2w0Coeff <- 1.607405  ;car1.h2w0Coeff <- 4.059444 ;car2.h2w0Coeff <- 2.543868 } else {
      car0.h2w0Coeff <- 0         ;car1.h2w0Coeff <- 0        ;car2.h2w0Coeff <- 0}
    if(h==2 && w==1) {                          
      car0.h2w1Coeff <- 0.9720941 ;car1.h2w1Coeff <- 3.490486 ;car2.h2w1Coeff <- 2.034579 } else {
      car0.h2w1Coeff <- 0         ;car1.h2w1Coeff <- 0        ;car2.h2w1Coeff <- 0}
    if(h==2 && w==2) {                          
      car0.h2w2Coeff <- 0.7961496 ;car1.h2w2Coeff <- 2.9585   ;car2.h2w2Coeff <- 1.853741 } else {
      car0.h2w2Coeff <- 0         ;car1.h2w2Coeff <- 0        ;car2.h2w2Coeff <- 0}
    if(h==3 && w==0) {                          
      car0.h3w0Coeff <- 2.63248   ;car1.h3w0Coeff <- 3.471202 ;car2.h3w0Coeff <- 2.016871 } else {
      car0.h3w0Coeff <- 0         ;car1.h3w0Coeff <- 0        ;car2.h3w0Coeff <- 0}
    if(h==3 && w==1) {                          
      car0.h3w1Coeff <- 0.75      ;car1.h3w1Coeff <- 3.511281 ;car2.h3w1Coeff <- 1.786667 } else {
      car0.h3w1Coeff <- 0         ;car1.h3w1Coeff <- 0        ;car2.h3w1Coeff <- 0}
    if(h==3 && w==2) {                          
      car0.h3w2Coeff <- 0.4636874 ;car1.h3w2Coeff <- 2.601056 ;car2.h3w2Coeff <- 1.53352  } else {
      car0.h3w2Coeff <- 0         ;car1.h3w2Coeff <- 0        ;car2.h3w2Coeff <- 0}
    if(h==3 && w==3) {                          
      car0.h3w3Coeff <- 0         ;car1.h3w3Coeff <- 2.601056 ;car2.h3w3Coeff <- 0.7325695} else {
      car0.h3w3Coeff <- 0         ;car1.h3w3Coeff <- 0        ;car2.h3w3Coeff <- 0}
    if(h==4 && w==0) {                          
      car0.h4w0Coeff <- 1         ;car1.h4w0Coeff <- 2.807935 ;car2.h4w0Coeff <- 1.280168 } else {
      car0.h4w0Coeff <- 0         ;car1.h4w0Coeff <- 0        ;car2.h4w0Coeff <- 0}
    if(h==4 && w==1) {                          
      car0.h4w1Coeff <- 0.5       ;car1.h4w1Coeff <- 3.234649 ;car2.h4w1Coeff <- 2.246101 } else {
      car0.h4w1Coeff <- 0         ;car1.h4w1Coeff <- 0        ;car2.h4w1Coeff <- 0}
    if(h==4 && w==2) {                          
      car0.h4w2Coeff <- 0.25      ;car1.h4w2Coeff <- 2.886127 ;car2.h4w2Coeff <- 2.050581 } else {
      car0.h4w2Coeff <- 0         ;car1.h4w2Coeff <- 0        ;car2.h4w2Coeff <- 0}

    car0.h4w3Coeff   <- 0         ;car1.h4w3Coeff <- 0        ;car2.h4w3Coeff <- 0

    #Begin Income Loop (1-4)
    for (i in 1:4) {
      
## UTILITY CALCULATIONS
      Util.Car0.SFDU <- utilCalcCar(0,1)
      Util.Car0.MFDU <- utilCalcCar(0,0) 
      Util.Car1.SFDU <- utilCalcCar(1,1)
      Util.Car1.MFDU <- utilCalcCar(1,0)
      Util.Car2.SFDU <- utilCalcCar(2,1)
      Util.Car2.MFDU <- utilCalcCar(2,0)
      Util.Car3      <- ma.mixthm * 0 + exp(0)
      
      Util.Sum.SFDU <- Util.Car0.SFDU + Util.Car1.SFDU + Util.Car2.SFDU + Util.Car3
      Util.Sum.MFDU <- Util.Car0.MFDU + Util.Car1.MFDU + Util.Car2.MFDU + Util.Car3

## PROBABILITY AND CAR OWNERSHIP ESTIMATE
    
      x <- x+1
      y <- x+3

# c0whia 

      # SFDU 
      ma.tempS0 <- Util.Car0.SFDU / Util.Sum.SFDU * ma.sfp
      mf.tempS0 <- ma.tempS0 * mf.whia[,x:y] 

      # MFDU 
      ma.tempM0 <- Util.Car0.MFDU / Util.Sum.MFDU * (1-ma.sfp)
      mf.tempM0 <- ma.tempM0 * mf.whia[,x:y] 

      mf.temp0 <- mf.tempS0 + mf.tempM0 

      if(x==1) mf.c0whia <- mf.temp0
      else     mf.c0whia <- cbind(mf.c0whia, mf.temp0)
          
# c1whia

      # SFDU
      ma.tempS1 <- Util.Car1.SFDU / Util.Sum.SFDU * ma.sfp
      mf.tempS1 <- ma.tempS1 * mf.whia[,x:y]
       
      # MFDU
      ma.tempM1 <- Util.Car1.MFDU / Util.Sum.MFDU * (1-ma.sfp)
      mf.tempM1 <- ma.tempM1 * mf.whia[,x:y]

      mf.temp1 <- mf.tempS1 + mf.tempM1

      if(x==1) mf.c1whia <- mf.temp1
      else     mf.c1whia <- cbind(mf.c1whia, mf.temp1)

# c2whia

      # SFDU
      ma.tempS2 <- Util.Car2.SFDU / Util.Sum.SFDU * ma.sfp
      mf.tempS2 <- ma.tempS2 * mf.whia[,x:y]

      # MFDU
      ma.tempM2 <- Util.Car2.MFDU / Util.Sum.MFDU * (1-ma.sfp)
      mf.tempM2 <- ma.tempM2 * mf.whia[,x:y]

      mf.temp2 <- mf.tempS2 + mf.tempM2

      if(x==1) mf.c2whia <- mf.temp2
      else     mf.c2whia <- cbind(mf.c2whia, mf.temp2)
      
# c3whia

      # SFDU 
      ma.tempS3 <- Util.Car3 / Util.Sum.SFDU * ma.sfp
      mf.tempS3 <- ma.tempS3 * mf.whia[,x:y] 

      # MFDU       
      ma.tempM3 <- Util.Car3 / Util.Sum.MFDU * (1-ma.sfp)
      mf.tempM3 <- ma.tempM3 * mf.whia[,x:y]

      mf.temp3 <- mf.tempS3 + mf.tempM3 

      if(x==1) mf.c3whia <- mf.temp3
      else     mf.c3whia <- cbind(mf.c3whia, mf.temp3)
     
      x <- y
    }
  }
}

### BUILD MF.CVAL ###

#CVAL0
mf.cval <- mf.c0whia

#CVAL1
mf.cval <- cbind(mf.cval, mf.c1whia[,129:256], mf.c2whia[,193:256])

#CVAL2
mf.cval <- cbind(mf.cval, mf.c1whia[,65:128], mf.c2whia[,129:192], mf.c3whia[,193:256])

#CVAL3
mf.cval <- cbind(mf.cval, mf.c1whia[,1:64], mf.c2whia[,1:128], mf.c3whia[,1:192])

### SUMMARY STATISTICS (for diagnostic purposes only)

## Total HH by CVAL Category
Sum.CVAL0<-sum(mf.cval[,1:256])
Sum.CVAL1<-sum(mf.cval[,257:448])
Sum.CVAL2<-sum(mf.cval[,449:640])
Sum.CVAL3<-sum(mf.cval[,641:1024])

## Total HH by Auto Group
Sum.0CarHH <- sum(mf.c0whia)
Sum.1CarHH <- sum(mf.c1whia)
Sum.2CarHH <- sum(mf.c2whia)
Sum.3CarHH <- sum(mf.c3whia)

## Total Cars
Sum.AllCars <- Sum.1CarHH + Sum.2CarHH * 2 + Sum.3CarHH * 3.43 #3.43 is 2015 factor for 3+ car households

## Total HH by Auto Group and Household Size
#Sum.0CarHHh1 <- apply(mf.c0whia[,c(1:16,65:80,129:144,193:208)],1,sum)
#Sum.0CarHHh2 <- apply(mf.c0whia[,c(17:32,81:96,145:160,209:224)],1,sum)
#Sum.0CarHHh3 <- apply(mf.c0whia[,c(33:48,97:112,161:176,225:240)],1,sum)
#Sum.0CarHHh4 <- apply(mf.c0whia[,c(49:64,113:128,177:192,241:256)],1,sum)
#Sum.1CarHHh1 <- apply(mf.c1whia[,c(1:16,65:80,129:144,193:208)],1,sum)   
#Sum.1CarHHh2 <- apply(mf.c1whia[,c(17:32,81:96,145:160,209:224)],1,sum)  
#Sum.1CarHHh3 <- apply(mf.c1whia[,c(33:48,97:112,161:176,225:240)],1,sum) 
#Sum.1CarHHh4 <- apply(mf.c1whia[,c(49:64,113:128,177:192,241:256)],1,sum)
#Sum.2CarHHh1 <- apply(mf.c2whia[,c(1:16,65:80,129:144,193:208)],1,sum)   
#Sum.2CarHHh2 <- apply(mf.c2whia[,c(17:32,81:96,145:160,209:224)],1,sum)  
#Sum.2CarHHh3 <- apply(mf.c2whia[,c(33:48,97:112,161:176,225:240)],1,sum) 
#Sum.2CarHHh4 <- apply(mf.c2whia[,c(49:64,113:128,177:192,241:256)],1,sum)
#Sum.3CarHHh1 <- apply(mf.c3whia[,c(1:16,65:80,129:144,193:208)],1,sum)   
#Sum.3CarHHh2 <- apply(mf.c3whia[,c(17:32,81:96,145:160,209:224)],1,sum)  
#Sum.3CarHHh3 <- apply(mf.c3whia[,c(33:48,97:112,161:176,225:240)],1,sum) 
#Sum.3CarHHh4 <- apply(mf.c3whia[,c(49:64,113:128,177:192,241:256)],1,sum)
#Sum.AllCarHHh <- Sum.0CarHHh1 + Sum.0CarHHh2 + Sum.0CarHHh3 + Sum.0CarHHh4 +
#                 Sum.1CarHHh1 + Sum.1CarHHh2 + Sum.1CarHHh3 + Sum.1CarHHh4 +
#                 Sum.2CarHHh1 + Sum.2CarHHh2 + Sum.2CarHHh3 + Sum.2CarHHh4 +
#                 Sum.3CarHHh1 + Sum.3CarHHh2 + Sum.3CarHHh3 + Sum.3CarHHh4
#
## Total HH by Auto Group and Income Level
#Sum.0CarHHi1 <- apply(mf.c0whia[,c(1:4,17:20,33:36,49:52,65:68,81:84,97:100,113:116,129:132,145:148,161:164,177:180,193:196,209:212,225:228,241:244)],1,sum)
#Sum.0CarHHi2 <- apply(mf.c0whia[,c(5:8,21:24,37:40,53:56,69:72,85:88,101:104,117:120,133:136,149:152,165:168,181:184,197:200,213:216,229:232,245:248)],1,sum)
#Sum.0CarHHi3 <- apply(mf.c0whia[,c(9:12,25:28,41:44,57:60,73:76,89:92,105:108,121:124,137:140,153:156,169:172,185:188,201:204,217:220,233:236,249:252)],1,sum)
#Sum.0CarHHi4 <- apply(mf.c0whia[,c(13:16,29:32,45:48,61:64,77:80,93:96,109:112,125:128,141:144,157:160,173:176,189:192,205:208,221:224,237:240,253:256)],1,sum)
#Sum.1CarHHi1 <- apply(mf.c1whia[,c(1:4,17:20,33:36,49:52,65:68,81:84,97:100,113:116,129:132,145:148,161:164,177:180,193:196,209:212,225:228,241:244)],1,sum)   
#Sum.1CarHHi2 <- apply(mf.c1whia[,c(5:8,21:24,37:40,53:56,69:72,85:88,101:104,117:120,133:136,149:152,165:168,181:184,197:200,213:216,229:232,245:248)],1,sum)  
#Sum.1CarHHi3 <- apply(mf.c1whia[,c(9:12,25:28,41:44,57:60,73:76,89:92,105:108,121:124,137:140,153:156,169:172,185:188,201:204,217:220,233:236,249:252)],1,sum) 
#Sum.1CarHHi4 <- apply(mf.c1whia[,c(13:16,29:32,45:48,61:64,77:80,93:96,109:112,125:128,141:144,157:160,173:176,189:192,205:208,221:224,237:240,253:256)],1,sum)
#Sum.2CarHHi1 <- apply(mf.c2whia[,c(1:4,17:20,33:36,49:52,65:68,81:84,97:100,113:116,129:132,145:148,161:164,177:180,193:196,209:212,225:228,241:244)],1,sum)   
#Sum.2CarHHi2 <- apply(mf.c2whia[,c(5:8,21:24,37:40,53:56,69:72,85:88,101:104,117:120,133:136,149:152,165:168,181:184,197:200,213:216,229:232,245:248)],1,sum)  
#Sum.2CarHHi3 <- apply(mf.c2whia[,c(9:12,25:28,41:44,57:60,73:76,89:92,105:108,121:124,137:140,153:156,169:172,185:188,201:204,217:220,233:236,249:252)],1,sum) 
#Sum.2CarHHi4 <- apply(mf.c2whia[,c(13:16,29:32,45:48,61:64,77:80,93:96,109:112,125:128,141:144,157:160,173:176,189:192,205:208,221:224,237:240,253:256)],1,sum)
#Sum.3CarHHi1 <- apply(mf.c3whia[,c(1:4,17:20,33:36,49:52,65:68,81:84,97:100,113:116,129:132,145:148,161:164,177:180,193:196,209:212,225:228,241:244)],1,sum)   
#Sum.3CarHHi2 <- apply(mf.c3whia[,c(5:8,21:24,37:40,53:56,69:72,85:88,101:104,117:120,133:136,149:152,165:168,181:184,197:200,213:216,229:232,245:248)],1,sum)  
#Sum.3CarHHi3 <- apply(mf.c3whia[,c(9:12,25:28,41:44,57:60,73:76,89:92,105:108,121:124,137:140,153:156,169:172,185:188,201:204,217:220,233:236,249:252)],1,sum) 
#Sum.3CarHHi4 <- apply(mf.c3whia[,c(13:16,29:32,45:48,61:64,77:80,93:96,109:112,125:128,141:144,157:160,173:176,189:192,205:208,221:224,237:240,253:256)],1,sum)
#Sum.AllCarHHi <- Sum.0CarHHi1 + Sum.0CarHHi2 + Sum.0CarHHi3 + Sum.0CarHHi4 +
#                 Sum.1CarHHi1 + Sum.1CarHHi2 + Sum.1CarHHi3 + Sum.1CarHHi4 +
#                 Sum.2CarHHi1 + Sum.2CarHHi2 + Sum.2CarHHi3 + Sum.2CarHHi4 +
#                 Sum.3CarHHi1 + Sum.3CarHHi2 + Sum.3CarHHi3 + Sum.3CarHHi4

rm(car0.const,car1.const,car2.const,
   car0.incomeCoeff,car1.incomeCoeff,car2.incomeCoeff,
   car0.sfPctCoeff,car1.sfPctCoeff,car2.sfPctCoeff ,
   car0.tot30tCoeff,car1.tot30tCoeff,car2.tot30tCoeff,
   car0.mixthmCoeff,car1.mixthmCoeff,car2.mixthmCoeff,
   car0.h1w0Coeff,car0.h1w1Coeff,car0.h2w0Coeff,car0.h2w1Coeff,car0.h2w2Coeff,
   car0.h3w0Coeff,car0.h3w1Coeff,car0.h3w2Coeff,car0.h3w3Coeff,
   car0.h4w0Coeff,car0.h4w1Coeff,car0.h4w2Coeff,car0.h4w3Coeff,
   car1.h1w0Coeff,car1.h1w1Coeff,car1.h2w0Coeff,car1.h2w1Coeff,car1.h2w2Coeff,
   car1.h3w0Coeff,car1.h3w1Coeff,car1.h3w2Coeff,car1.h3w3Coeff,
   car1.h4w0Coeff,car1.h4w1Coeff,car1.h4w2Coeff,car1.h4w3Coeff,
   car2.h1w0Coeff,car2.h1w1Coeff,car2.h2w0Coeff,car2.h2w1Coeff,car2.h2w2Coeff,
   car2.h3w0Coeff,car2.h3w1Coeff,car2.h3w2Coeff,car2.h3w3Coeff,
   car2.h4w0Coeff,car2.h4w1Coeff,car2.h4w2Coeff,car2.h4w3Coeff,
   w,h,i,x,y,
   Util.Car0.SFDU,Util.Car0.MFDU,Util.Car1.SFDU,Util.Car1.MFDU,Util.Car2.SFDU,Util.Car2.MFDU,Util.Car3,Util.Sum.SFDU,Util.Sum.MFDU,
   ma.tempS0,ma.tempM0,ma.tempS1,ma.tempM1,ma.tempS2,ma.tempM2,ma.tempS3,ma.tempM3,
   mf.tempS0,mf.tempM0,mf.tempS1,mf.tempM1,mf.tempS2,mf.tempM2,mf.tempS3,mf.tempM3,
   mf.temp0,mf.temp1,mf.temp2,mf.temp3)

