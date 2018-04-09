#k.nhnwgen.R

#NHNW Trip Production Rates
r1 <- 1.165517   #  Worker<Size, 1 PerHH
r2 <- 1.651685   #  Worker<Size, 2 PerHH
r3 <- 1.956316   #  Worker<Size, 3 PerHH
r4 <- 3.161211   #  Worker<Size, 4+ PerHH
r5 <- 0.511022   #  Worker=Size, 1 PerHH
r6 <- 0.9187314  #  Worker=Size, 2 PerHH
r7 <- 1.425926   #  Worker=Size, 3 PerHH

# workers  HHsize
nhnw01 <- apply(mf.w0hia[,1:16],1,sum)*r1*NHNW.gen.calibrationFac
nhnw02 <- apply(mf.w0hia[,17:32],1,sum)*r2*NHNW.gen.calibrationFac
nhnw03 <- apply(mf.w0hia[,33:48],1,sum)*r3*NHNW.gen.calibrationFac
nhnw04 <- apply(mf.w0hia[,49:64],1,sum)*r4*NHNW.gen.calibrationFac
nhnw12 <- apply(mf.w1hia[,17:32],1,sum)*r2*NHNW.gen.calibrationFac
nhnw13 <- apply(mf.w1hia[,33:48],1,sum)*r3*NHNW.gen.calibrationFac
nhnw14 <- apply(mf.w1hia[,49:64],1,sum)*r4*NHNW.gen.calibrationFac
nhnw23 <- apply(mf.w2hia[,33:48],1,sum)*r3*NHNW.gen.calibrationFac
nhnw24 <- apply(mf.w2hia[,49:64],1,sum)*r4*NHNW.gen.calibrationFac
nhnw34 <- apply(mf.w3hia[,49:64],1,sum)*r4*NHNW.gen.calibrationFac
nhnw11 <- apply(mf.w1hia[,1:16],1,sum)*r5*NHNW.gen.calibrationFac
nhnw22 <- apply(mf.w2hia[,17:32],1,sum)*r6*NHNW.gen.calibrationFac
nhnw33 <- apply(mf.w3hia[,33:48],1,sum)*r7*NHNW.gen.calibrationFac

ma.nhnwpr <- nhnw01 + nhnw02 + nhnw03 + nhnw04 + nhnw12 + nhnw13 + nhnw14 +
             nhnw23 + nhnw24 + nhnw34 + nhnw11 + nhnw22 + nhnw33

save(ma.nhnwpr,file="ma.nhnwpr.dat")

rm(nhnw01,nhnw02,nhnw03,nhnw04,nhnw12,nhnw13,nhnw14,
   nhnw23,nhnw24,nhnw34,nhnw11,nhnw22,nhnw33)
   
