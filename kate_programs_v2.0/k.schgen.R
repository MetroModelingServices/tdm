#k.schgen.R
##HBSchool Productions (including escort trips)
#Calculates productions from mf.khia and bins results

#Modify Production Rates Here:
r1 <- 1.9784483  #  1-kid, 2 PerHH
r2 <- 1.8479299  #  1-kid, 3 PerHH
r3 <- 2.2488794  #  1-kid, 4+PerHH
r4 <- 3.3263887  #  2 kids, 3 PerHH
r5 <- 3.441193	 #  2 kids, 4+PerHH
r6 <- 5.103783   #  3+kids, 4+PerHH

#########################################
#  School Productions                   #
#########################################
ma.k1h2 <- apply(mf.k1hia[,17:32],1,sum)*r1
ma.k1h3 <- apply(mf.k1hia[,33:48],1,sum)*r2
ma.k1h4 <- apply(mf.k1hia[,49:64],1,sum)*r3

ma.k2h3 <- apply(mf.k2hia[,33:48],1,sum)*r4
ma.k2h4 <- apply(mf.k2hia[,49:64],1,sum)*r5

ma.k3h4 <- apply(mf.k3hia[,49:64],1,sum)*r6

ma.schpr <- ma.k1h2 + ma.k1h3 + ma.k1h4 + ma.k2h3 + ma.k2h4 + ma.k3h4
ma.schat <- t(ma.schpr)

rm(r1,r2,r3,r4,r5,r6,ma.k1h2,ma.k1h3,ma.k1h4,ma.k2h3,ma.k2h4,ma.k3h4)
