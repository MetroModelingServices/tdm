#k.nhwgen.R

# NHW Trip Production Rates
r1 <- 0.1078636  #  0-Worker
r2 <- 0.8356589  #  1-Worker
r3 <- 1.723404   #  2-Worker
r4 <- 2.33209    #  3+-Worker

ms.TotalEmp <- sum(ma.totemp)

# workers
nhw0 <- apply(mf.w0hia,1,sum)*r1
nhw1 <- apply(mf.w1hia,1,sum)*r2
nhw2 <- apply(mf.w2hia,1,sum)*r3
nhw3 <- apply(mf.w3hia,1,sum)*r4
ma.nhwpr <- nhw0 + nhw1 + nhw2 + nhw3

# Scale Productions to Employment
ms.nhwpr <- sum(ma.nhwpr)
ms.nhwEmpGoal <- ms.TotalEmp * NHW.gen.calibrationFac
ms.nhwFactor <- ms.nhwEmpGoal / ms.nhwpr
nhw0 <- nhw0 * ms.nhwFactor
nhw1 <- nhw1 * ms.nhwFactor
nhw2 <- nhw2 * ms.nhwFactor
nhw3 <- nhw3 * ms.nhwFactor
ma.nhwpr <- nhw0 + nhw1 + nhw2 + nhw3

save(ma.nhwpr,file="ma.nhwpr.dat")

rm(nhw0,nhw1,nhw2,nhw3)

