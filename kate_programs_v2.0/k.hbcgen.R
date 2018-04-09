#k.hbcgen.R

# HBC Trip Production Rates
r1  <- 0.5384615  #  Agehead <25, 1 PerHH
r2  <- 0.0473684  #  Agehead 25-55, 1 PerHH
r3  <- 0.0059761  #  Agehead 56-65, 1 PerHH
r4  <- 0.007837   #  Agehead >65, 1 PerHH
r5  <- 0.375      #  Agehead <25, 2 PerHH
r6  <- 0.1138107  #  Agehead 25-55, 2 PerHH
r7  <- 0.0289079  #  Agehead 56-65, 2 PerHH
r8  <- 0.0183357  #  Agehead >65, 2 PerHH
r9  <- 0.6666667  #  Agehead <25, 3 PerHH
r10 <- 0.1226576  #  Agehead 25-55, 3 PerHH
r11 <- 0.1610487  #  Agehead 56-65, 3 PerHH
r12 <- 0.1413043  #  Agehead >65, 3 PerHH
r13 <- 0.8333333  #  Agehead <25, 4+ PerHH
r14 <- 0.1359852  #  Agehead 25-55, 4+ PerHH
r15 <- 0.468254   #  Agehead 56-65, 4+ PerHH
r16 <- 0.2758621  #  Agehead >65, 4+ PerHH

## CVAL 0  (cars=0)

#  age  HHsize  cval  income
i <- 1
hbc1101 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r1*HBC.gen.calibrationFac
hbc1102 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1103 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1104 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r1*HBC.gen.calibrationFac
i <- 2    
hbc2101 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r2*HBC.gen.calibrationFac
hbc2102 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2103 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2104 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r2*HBC.gen.calibrationFac
i <- 3    
hbc3101 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r3*HBC.gen.calibrationFac
hbc3102 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3103 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3104 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r3*HBC.gen.calibrationFac
i <- 4    
hbc4101 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r4*HBC.gen.calibrationFac
hbc4102 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4103 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4104 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r4*HBC.gen.calibrationFac
i <- 17    
hbc1201 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r5*HBC.gen.calibrationFac
hbc1202 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1203 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1204 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r5*HBC.gen.calibrationFac
i <- 18                                                                              
hbc2201 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r6*HBC.gen.calibrationFac
hbc2202 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2203 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2204 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r6*HBC.gen.calibrationFac
i <- 19                                                                              
hbc3201 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r7*HBC.gen.calibrationFac
hbc3202 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3203 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3204 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r7*HBC.gen.calibrationFac
i <- 20                                                                              
hbc4201 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r8*HBC.gen.calibrationFac
hbc4202 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4203 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4204 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r8*HBC.gen.calibrationFac
i <- 33    
hbc1301 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r9*HBC.gen.calibrationFac
hbc1302 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1303 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1304 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r9*HBC.gen.calibrationFac
i <- 34                                                                              
hbc2301 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r10*HBC.gen.calibrationFac
hbc2302 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2303 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2304 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r10*HBC.gen.calibrationFac
i <- 35                                                                              
hbc3301 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r11*HBC.gen.calibrationFac
hbc3302 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3303 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3304 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r11*HBC.gen.calibrationFac
i <- 36                                                                              
hbc4301 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r12*HBC.gen.calibrationFac
hbc4302 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4303 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4304 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r12*HBC.gen.calibrationFac
i <- 49    
hbc1401 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r13*HBC.gen.calibrationFac
hbc1402 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1403 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1404 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r13*HBC.gen.calibrationFac
i <- 50                                                                              
hbc2401 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r14*HBC.gen.calibrationFac
hbc2402 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2403 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2404 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r14*HBC.gen.calibrationFac
i <- 51                                                                              
hbc3401 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r15*HBC.gen.calibrationFac
hbc3402 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3403 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3404 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r15*HBC.gen.calibrationFac
i <- 52                                                                              
hbc4401 <- apply(mf.cval[,seq(i,256,64)],1,sum)   *r16*HBC.gen.calibrationFac
hbc4402 <- apply(mf.cval[,seq(i+4,256,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4403 <- apply(mf.cval[,seq(i+8,256,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4404 <- apply(mf.cval[,seq(i+12,256,64)],1,sum)*r16*HBC.gen.calibrationFac

## CVAL 1 (cars<workers)
   
#  age  HHsize  cval  income
i <- 1 + 256    
hbc1111 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r1*HBC.gen.calibrationFac
hbc1112 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1113 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1114 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r1*HBC.gen.calibrationFac
i <- 2 + 256                                                                         
hbc2111 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r2*HBC.gen.calibrationFac
hbc2112 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2113 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2114 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r2*HBC.gen.calibrationFac
i <- 3 + 256                                                                         
hbc3111 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r3*HBC.gen.calibrationFac
hbc3112 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3113 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3114 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r3*HBC.gen.calibrationFac
i <- 4 + 256                                                                         
hbc4111 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r4*HBC.gen.calibrationFac
hbc4112 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4113 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4114 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r4*HBC.gen.calibrationFac
i <- 17 + 256                                                                        
hbc1211 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r5*HBC.gen.calibrationFac
hbc1212 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1213 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1214 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r5*HBC.gen.calibrationFac
i <- 18 + 256                                                                        
hbc2211 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r6*HBC.gen.calibrationFac
hbc2212 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2213 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2214 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r6*HBC.gen.calibrationFac
i <- 19 + 256                                                                        
hbc3211 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r7*HBC.gen.calibrationFac
hbc3212 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3213 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3214 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r7*HBC.gen.calibrationFac
i <- 20 + 256                                                                        
hbc4211 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r8*HBC.gen.calibrationFac
hbc4212 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4213 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4214 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r8*HBC.gen.calibrationFac
i <- 33 + 256                                                                        
hbc1311 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r9*HBC.gen.calibrationFac
hbc1312 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1313 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1314 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r9*HBC.gen.calibrationFac
i <- 34 + 256                                                                        
hbc2311 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r10*HBC.gen.calibrationFac
hbc2312 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2313 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2314 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r10*HBC.gen.calibrationFac
i <- 35 + 256                                                                        
hbc3311 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r11*HBC.gen.calibrationFac
hbc3312 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3313 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3314 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r11*HBC.gen.calibrationFac
i <- 36 + 256                                                                        
hbc4311 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r12*HBC.gen.calibrationFac
hbc4312 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4313 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4314 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r12*HBC.gen.calibrationFac
i <- 49 + 256                                                                        
hbc1411 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r13*HBC.gen.calibrationFac
hbc1412 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1413 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1414 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r13*HBC.gen.calibrationFac
i <- 50 + 256                                                                        
hbc2411 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r14*HBC.gen.calibrationFac
hbc2412 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2413 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2414 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r14*HBC.gen.calibrationFac
i <- 51 + 256                                                                        
hbc3411 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r15*HBC.gen.calibrationFac
hbc3412 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3413 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3414 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r15*HBC.gen.calibrationFac
i <- 52 + 256                                                                        
hbc4411 <- apply(mf.cval[,seq(i,448,64)],1,sum)   *r16*HBC.gen.calibrationFac
hbc4412 <- apply(mf.cval[,seq(i+4,448,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4413 <- apply(mf.cval[,seq(i+8,448,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4414 <- apply(mf.cval[,seq(i+12,448,64)],1,sum)*r16*HBC.gen.calibrationFac

## CVAL 2 (cars=workers)

#  age  HHsize  cval  income    
i <- 1 + 448    
hbc1121 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r1*HBC.gen.calibrationFac
hbc1122 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1123 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1124 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r1*HBC.gen.calibrationFac
i <- 2 + 448                                                                         
hbc2121 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r2*HBC.gen.calibrationFac
hbc2122 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2123 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2124 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r2*HBC.gen.calibrationFac
i <- 3 + 448                                                                         
hbc3121 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r3*HBC.gen.calibrationFac
hbc3122 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3123 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3124 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r3*HBC.gen.calibrationFac
i <- 4 + 448                                                                         
hbc4121 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r4*HBC.gen.calibrationFac
hbc4122 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4123 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4124 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r4*HBC.gen.calibrationFac
i <- 17 + 448                                                                        
hbc1221 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r5*HBC.gen.calibrationFac
hbc1222 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1223 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1224 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r5*HBC.gen.calibrationFac
i <- 18 + 448                                                                        
hbc2221 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r6*HBC.gen.calibrationFac
hbc2222 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2223 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2224 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r6*HBC.gen.calibrationFac
i <- 19 + 448                                                                        
hbc3221 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r7*HBC.gen.calibrationFac
hbc3222 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3223 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3224 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r7*HBC.gen.calibrationFac
i <- 20 + 448                                                                        
hbc4221 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r8*HBC.gen.calibrationFac
hbc4222 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4223 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4224 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r8*HBC.gen.calibrationFac
i <- 33 + 448                                                                        
hbc1321 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r9*HBC.gen.calibrationFac
hbc1322 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1323 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1324 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r9*HBC.gen.calibrationFac
i <- 34 + 448                                                                        
hbc2321 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r10*HBC.gen.calibrationFac
hbc2322 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2323 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2324 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r10*HBC.gen.calibrationFac
i <- 35 + 448                                                                        
hbc3321 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r11*HBC.gen.calibrationFac
hbc3322 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3323 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3324 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r11*HBC.gen.calibrationFac
i <- 36 + 448                                                                        
hbc4321 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r12*HBC.gen.calibrationFac
hbc4322 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4323 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4324 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r12*HBC.gen.calibrationFac
i <- 49 + 448                                                                        
hbc1421 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r13*HBC.gen.calibrationFac
hbc1422 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1423 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1424 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r13*HBC.gen.calibrationFac
i <- 50 + 448                                                                        
hbc2421 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r14*HBC.gen.calibrationFac
hbc2422 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2423 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2424 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r14*HBC.gen.calibrationFac
i <- 51 + 448                                                                        
hbc3421 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r15*HBC.gen.calibrationFac
hbc3422 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3423 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3424 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r15*HBC.gen.calibrationFac
i <- 52 + 448                                                                        
hbc4421 <- apply(mf.cval[,seq(i,640,64)],1,sum)   *r16*HBC.gen.calibrationFac
hbc4422 <- apply(mf.cval[,seq(i+4,640,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4423 <- apply(mf.cval[,seq(i+8,640,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4424 <- apply(mf.cval[,seq(i+12,640,64)],1,sum)*r16*HBC.gen.calibrationFac

## CVAL 3 (cars>workers)

#  age  HHsize  cval  income    
i <- 1 + 640    
hbc1131 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r1*HBC.gen.calibrationFac
hbc1132 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1133 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r1*HBC.gen.calibrationFac
hbc1134 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r1*HBC.gen.calibrationFac
i <- 2 + 640                                                                          
hbc2131 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r2*HBC.gen.calibrationFac
hbc2132 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2133 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r2*HBC.gen.calibrationFac
hbc2134 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r2*HBC.gen.calibrationFac
i <- 3 + 640                                                                          
hbc3131 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r3*HBC.gen.calibrationFac
hbc3132 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3133 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r3*HBC.gen.calibrationFac
hbc3134 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r3*HBC.gen.calibrationFac
i <- 4 + 640                                                                          
hbc4131 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r4*HBC.gen.calibrationFac
hbc4132 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4133 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r4*HBC.gen.calibrationFac
hbc4134 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r4*HBC.gen.calibrationFac
i <- 17 + 640                                                                         
hbc1231 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r5*HBC.gen.calibrationFac
hbc1232 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1233 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r5*HBC.gen.calibrationFac
hbc1234 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r5*HBC.gen.calibrationFac
i <- 18 + 640                                                                         
hbc2231 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r6*HBC.gen.calibrationFac
hbc2232 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2233 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r6*HBC.gen.calibrationFac
hbc2234 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r6*HBC.gen.calibrationFac
i <- 19 + 640                                                                         
hbc3231 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r7*HBC.gen.calibrationFac
hbc3232 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3233 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r7*HBC.gen.calibrationFac
hbc3234 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r7*HBC.gen.calibrationFac
i <- 20 + 640                                                                         
hbc4231 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r8*HBC.gen.calibrationFac
hbc4232 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4233 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r8*HBC.gen.calibrationFac
hbc4234 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r8*HBC.gen.calibrationFac
i <- 33 + 640                                                                         
hbc1331 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r9*HBC.gen.calibrationFac
hbc1332 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1333 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r9*HBC.gen.calibrationFac
hbc1334 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r9*HBC.gen.calibrationFac
i <- 34 + 640                                                                         
hbc2331 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r10*HBC.gen.calibrationFac
hbc2332 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2333 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r10*HBC.gen.calibrationFac
hbc2334 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r10*HBC.gen.calibrationFac
i <- 35 + 640                                                                         
hbc3331 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r11*HBC.gen.calibrationFac
hbc3332 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3333 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r11*HBC.gen.calibrationFac
hbc3334 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r11*HBC.gen.calibrationFac
i <- 36 + 640                                                                         
hbc4331 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r12*HBC.gen.calibrationFac
hbc4332 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4333 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r12*HBC.gen.calibrationFac
hbc4334 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r12*HBC.gen.calibrationFac
i <- 49 + 640                                                                         
hbc1431 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r13*HBC.gen.calibrationFac
hbc1432 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1433 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r13*HBC.gen.calibrationFac
hbc1434 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r13*HBC.gen.calibrationFac
i <- 50 + 640                                                                         
hbc2431 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r14*HBC.gen.calibrationFac
hbc2432 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2433 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r14*HBC.gen.calibrationFac
hbc2434 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r14*HBC.gen.calibrationFac
i <- 51 + 640                                                                         
hbc3431 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r15*HBC.gen.calibrationFac
hbc3432 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3433 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r15*HBC.gen.calibrationFac
hbc3434 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r15*HBC.gen.calibrationFac
i <- 52 + 640                                                                         
hbc4431 <- apply(mf.cval[,seq(i,1024,64)],1,sum)   *r16*HBC.gen.calibrationFac
hbc4432 <- apply(mf.cval[,seq(i+4,1024,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4433 <- apply(mf.cval[,seq(i+8,1024,64)],1,sum) *r16*HBC.gen.calibrationFac
hbc4434 <- apply(mf.cval[,seq(i+12,1024,64)],1,sum)*r16*HBC.gen.calibrationFac

##############################################################################

# TOTAL PRODUCTIONS
 
# Low Income Productions (income bin 1)
ma.collprl <- hbc1101+hbc1201+hbc1301+hbc1401+hbc2101+hbc2201+hbc2301+hbc2401+
              hbc3101+hbc3201+hbc3301+hbc3401+hbc4101+hbc4201+hbc4301+hbc4401+
              hbc1111+hbc1211+hbc1311+hbc1411+hbc2111+hbc2211+hbc2311+hbc2411+
              hbc3111+hbc3211+hbc3311+hbc3411+hbc4111+hbc4211+hbc4311+hbc4411+
              hbc1121+hbc1221+hbc1321+hbc1421+hbc2121+hbc2221+hbc2321+hbc2421+
              hbc3121+hbc3221+hbc3321+hbc3421+hbc4121+hbc4221+hbc4321+hbc4421+
              hbc1131+hbc1231+hbc1331+hbc1431+hbc2131+hbc2231+hbc2331+hbc2431+
              hbc3131+hbc3231+hbc3331+hbc3431+hbc4131+hbc4231+hbc4331+hbc4431

# Middle Income Productions (income bins 2 & 3)
ma.collprm <- hbc1102+hbc1202+hbc1302+hbc1402+hbc2102+hbc2202+hbc2302+hbc2402+
              hbc3102+hbc3202+hbc3302+hbc3402+hbc4102+hbc4202+hbc4302+hbc4402+
              hbc1112+hbc1212+hbc1312+hbc1412+hbc2112+hbc2212+hbc2312+hbc2412+
              hbc3112+hbc3212+hbc3312+hbc3412+hbc4112+hbc4212+hbc4312+hbc4412+
              hbc1122+hbc1222+hbc1322+hbc1422+hbc2122+hbc2222+hbc2322+hbc2422+
              hbc3122+hbc3222+hbc3322+hbc3422+hbc4122+hbc4222+hbc4322+hbc4422+
              hbc1132+hbc1232+hbc1332+hbc1432+hbc2132+hbc2232+hbc2332+hbc2432+
              hbc3132+hbc3232+hbc3332+hbc3432+hbc4132+hbc4232+hbc4332+hbc4432+
              hbc1103+hbc1203+hbc1303+hbc1403+hbc2103+hbc2203+hbc2303+hbc2403+
              hbc3103+hbc3203+hbc3303+hbc3403+hbc4103+hbc4203+hbc4303+hbc4403+
              hbc1113+hbc1213+hbc1313+hbc1413+hbc2113+hbc2213+hbc2313+hbc2413+
              hbc3113+hbc3213+hbc3313+hbc3413+hbc4113+hbc4213+hbc4313+hbc4413+
              hbc1123+hbc1223+hbc1323+hbc1423+hbc2123+hbc2223+hbc2323+hbc2423+
              hbc3123+hbc3223+hbc3323+hbc3423+hbc4123+hbc4223+hbc4323+hbc4423+
              hbc1133+hbc1233+hbc1333+hbc1433+hbc2133+hbc2233+hbc2333+hbc2433+
              hbc3133+hbc3233+hbc3333+hbc3433+hbc4133+hbc4233+hbc4333+hbc4433

# High Income Productions (income bin 4)
ma.collprh <- hbc1104+hbc1204+hbc1304+hbc1404+hbc2104+hbc2204+hbc2304+hbc2404+
              hbc3104+hbc3204+hbc3304+hbc3404+hbc4104+hbc4204+hbc4304+hbc4404+
              hbc1114+hbc1214+hbc1314+hbc1414+hbc2114+hbc2214+hbc2314+hbc2414+
              hbc3114+hbc3214+hbc3314+hbc3414+hbc4114+hbc4214+hbc4314+hbc4414+
              hbc1124+hbc1224+hbc1324+hbc1424+hbc2124+hbc2224+hbc2324+hbc2424+
              hbc3124+hbc3224+hbc3324+hbc3424+hbc4124+hbc4224+hbc4324+hbc4424+
              hbc1134+hbc1234+hbc1334+hbc1434+hbc2134+hbc2234+hbc2334+hbc2434+
              hbc3134+hbc3234+hbc3334+hbc3434+hbc4134+hbc4234+hbc4334+hbc4434

# Total Productions (All Incomes)
ma.collpr <- ma.collprl + ma.collprm + ma.collprh

#################################################

## Calculate Attractions

# Scale Attractions (factored off-campus enrollment) to Productions
ma.ctrips  <- ma.enroll * HBC.enrollTripFac
ms.ctrips  <- sum(ma.ctrips)
ms.collpr  <- sum(ma.collpr)
ms.collprl <- sum(ma.collprl)
ms.collprm <- sum(ma.collprm)
ms.collprh <- sum(ma.collprh)
ma.collat  <- ma.ctrips / ms.ctrips * ms.collpr
ma.collatl <- ma.ctrips / ms.ctrips * ms.collprl
ma.collatm <- ma.ctrips / ms.ctrips * ms.collprm
ma.collath <- ma.ctrips / ms.ctrips * ms.collprh

##############################################

# Calculate Percentage Productions by worker, hh size, cval, and income

hbcLowInc.m<-ma.collprl
hbcLowInc.m[hbcLowInc.m==0]<-1
hbcMedInc.m<-ma.collprm
hbcMedInc.m[hbcMedInc.m==0]<-1
hbcHiInc.m<-ma.collprh
hbcHiInc.m[hbcHiInc.m==0]<-1

# #=CVAL    l=low income
#           m=mid income
#           h=high income

malist.col<-list(
md.hbc0l=(hbc1101+hbc1201+hbc1301+hbc1401+hbc2101+hbc2201+hbc2301+hbc2401+hbc3101+hbc3201+hbc3301+hbc3401+hbc4101+hbc4201+hbc4301+hbc4401)/hbcLowInc.m,
md.hbc0m=(hbc1102+hbc1202+hbc1302+hbc1402+hbc2102+hbc2202+hbc2302+hbc2402+hbc3102+hbc3202+hbc3302+hbc3402+hbc4102+hbc4202+hbc4302+hbc4402+
          hbc1103+hbc1203+hbc1303+hbc1403+hbc2103+hbc2203+hbc2303+hbc2403+hbc3103+hbc3203+hbc3303+hbc3403+hbc4103+hbc4203+hbc4303+hbc4403)/hbcMedInc.m,
md.hbc0h=(hbc1104+hbc1204+hbc1304+hbc1404+hbc2104+hbc2204+hbc2304+hbc2404+hbc3104+hbc3204+hbc3304+hbc3404+hbc4104+hbc4204+hbc4304+hbc4404)/hbcHiInc.m,
md.hbc1l=(hbc1111+hbc1211+hbc1311+hbc1411+hbc2111+hbc2211+hbc2311+hbc2411+hbc3111+hbc3211+hbc3311+hbc3411+hbc4111+hbc4211+hbc4311+hbc4411)/hbcLowInc.m,
md.hbc1m=(hbc1112+hbc1212+hbc1312+hbc1412+hbc2112+hbc2212+hbc2312+hbc2412+hbc3112+hbc3212+hbc3312+hbc3412+hbc4112+hbc4212+hbc4312+hbc4412+
          hbc1113+hbc1213+hbc1313+hbc1413+hbc2113+hbc2213+hbc2313+hbc2413+hbc3113+hbc3213+hbc3313+hbc3413+hbc4113+hbc4213+hbc4313+hbc4413)/hbcMedInc.m,
md.hbc1h=(hbc1114+hbc1214+hbc1314+hbc1414+hbc2114+hbc2214+hbc2314+hbc2414+hbc3114+hbc3214+hbc3314+hbc3414+hbc4114+hbc4214+hbc4314+hbc4414)/hbcHiInc.m,
md.hbc2l=(hbc1121+hbc1221+hbc1321+hbc1421+hbc2121+hbc2221+hbc2321+hbc2421+hbc3121+hbc3221+hbc3321+hbc3421+hbc4121+hbc4221+hbc4321+hbc4421)/hbcLowInc.m,
md.hbc2m=(hbc1122+hbc1222+hbc1322+hbc1422+hbc2122+hbc2222+hbc2322+hbc2422+hbc3122+hbc3222+hbc3322+hbc3422+hbc4122+hbc4222+hbc4322+hbc4422+
          hbc1123+hbc1223+hbc1323+hbc1423+hbc2123+hbc2223+hbc2323+hbc2423+hbc3123+hbc3223+hbc3323+hbc3423+hbc4123+hbc4223+hbc4323+hbc4423)/hbcMedInc.m,
md.hbc2h=(hbc1124+hbc1224+hbc1324+hbc1424+hbc2124+hbc2224+hbc2324+hbc2424+hbc3124+hbc3224+hbc3324+hbc3424+hbc4124+hbc4224+hbc4324+hbc4424)/hbcHiInc.m,
md.hbc3l=(hbc1131+hbc1231+hbc1331+hbc1431+hbc2131+hbc2231+hbc2331+hbc2431+hbc3131+hbc3231+hbc3331+hbc3431+hbc4131+hbc4231+hbc4331+hbc4431)/hbcLowInc.m,
md.hbc3m=(hbc1132+hbc1232+hbc1332+hbc1432+hbc2132+hbc2232+hbc2332+hbc2432+hbc3132+hbc3232+hbc3332+hbc3432+hbc4132+hbc4232+hbc4332+hbc4432+
          hbc1133+hbc1233+hbc1333+hbc1433+hbc2133+hbc2233+hbc2333+hbc2433+hbc3133+hbc3233+hbc3333+hbc3433+hbc4133+hbc4233+hbc4333+hbc4433)/hbcMedInc.m,
md.hbc3h=(hbc1134+hbc1234+hbc1334+hbc1434+hbc2134+hbc2234+hbc2334+hbc2434+hbc3134+hbc3234+hbc3334+hbc3434+hbc4134+hbc4234+hbc4334+hbc4434)/hbcHiInc.m,
ma.collpr=ma.collpr, ma.collprl=ma.collprl, ma.collprm=ma.collprm, ma.collprh=ma.collprh,
ma.collat=ma.collat, ma.collatl=ma.collatl, ma.collatm=ma.collatm, ma.collath=ma.collath)

save(malist.col,file="malist.col.dat")

rm(hbcLowInc.m,hbcMedInc.m,hbcHiInc.m,
   hbc1101,hbc1201,hbc1301,hbc1401,hbc2101,hbc2201,hbc2301,hbc2401,hbc3101,hbc3201,hbc3301,hbc3401,hbc4101,hbc4201,hbc4301,hbc4401,
   hbc1111,hbc1211,hbc1311,hbc1411,hbc2111,hbc2211,hbc2311,hbc2411,hbc3111,hbc3211,hbc3311,hbc3411,hbc4111,hbc4211,hbc4311,hbc4411,
   hbc1121,hbc1221,hbc1321,hbc1421,hbc2121,hbc2221,hbc2321,hbc2421,hbc3121,hbc3221,hbc3321,hbc3421,hbc4121,hbc4221,hbc4321,hbc4421,
   hbc1131,hbc1231,hbc1331,hbc1431,hbc2131,hbc2231,hbc2331,hbc2431,hbc3131,hbc3231,hbc3331,hbc3431,hbc4131,hbc4231,hbc4331,hbc4431,
   hbc1102,hbc1202,hbc1302,hbc1402,hbc2102,hbc2202,hbc2302,hbc2402,hbc3102,hbc3202,hbc3302,hbc3402,hbc4102,hbc4202,hbc4302,hbc4402,
   hbc1112,hbc1212,hbc1312,hbc1412,hbc2112,hbc2212,hbc2312,hbc2412,hbc3112,hbc3212,hbc3312,hbc3412,hbc4112,hbc4212,hbc4312,hbc4412,
   hbc1122,hbc1222,hbc1322,hbc1422,hbc2122,hbc2222,hbc2322,hbc2422,hbc3122,hbc3222,hbc3322,hbc3422,hbc4122,hbc4222,hbc4322,hbc4422,
   hbc1132,hbc1232,hbc1332,hbc1432,hbc2132,hbc2232,hbc2332,hbc2432,hbc3132,hbc3232,hbc3332,hbc3432,hbc4132,hbc4232,hbc4332,hbc4432,
   hbc1103,hbc1203,hbc1303,hbc1403,hbc2103,hbc2203,hbc2303,hbc2403,hbc3103,hbc3203,hbc3303,hbc3403,hbc4103,hbc4203,hbc4303,hbc4403,
   hbc1113,hbc1213,hbc1313,hbc1413,hbc2113,hbc2213,hbc2313,hbc2413,hbc3113,hbc3213,hbc3313,hbc3413,hbc4113,hbc4213,hbc4313,hbc4413,
   hbc1123,hbc1223,hbc1323,hbc1423,hbc2123,hbc2223,hbc2323,hbc2423,hbc3123,hbc3223,hbc3323,hbc3423,hbc4123,hbc4223,hbc4323,hbc4423,
   hbc1133,hbc1233,hbc1333,hbc1433,hbc2133,hbc2233,hbc2333,hbc2433,hbc3133,hbc3233,hbc3333,hbc3433,hbc4133,hbc4233,hbc4333,hbc4433,
   hbc1104,hbc1204,hbc1304,hbc1404,hbc2104,hbc2204,hbc2304,hbc2404,hbc3104,hbc3204,hbc3304,hbc3404,hbc4104,hbc4204,hbc4304,hbc4404,
   hbc1114,hbc1214,hbc1314,hbc1414,hbc2114,hbc2214,hbc2314,hbc2414,hbc3114,hbc3214,hbc3314,hbc3414,hbc4114,hbc4214,hbc4314,hbc4414,
   hbc1124,hbc1224,hbc1324,hbc1424,hbc2124,hbc2224,hbc2324,hbc2424,hbc3124,hbc3224,hbc3324,hbc3424,hbc4124,hbc4224,hbc4324,hbc4424,
   hbc1134,hbc1234,hbc1334,hbc1434,hbc2134,hbc2234,hbc2334,hbc2434,hbc3134,hbc3234,hbc3334,hbc3434,hbc4134,hbc4234,hbc4334,hbc4434)
