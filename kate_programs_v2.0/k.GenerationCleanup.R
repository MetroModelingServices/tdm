# k.GenerationCleanup.R

rm(list=ls()[grep("ma*",ls())])
rm(list=ls()[grep("mo*",ls())])
rm(list=ls()[grep("ms*",ls())])
rm(list=ls()[grep("md*",ls())])
rm(list=ls()[grep("mf*",ls())])
rm ( autoWeight,
     aw1,
     cc,
     incomeCoeffs,
     ivCoeff,
     ivt,
     livParameter,
     scivParameter,
     rivParameter,
     brivParameter,
     Sum.0CarHH,
     Sum.1CarHH,
     Sum.2CarHH,
     Sum.3CarHH,
     Sum.AllCarHH,
     Sum.CVAL0,
     Sum.CVAL1,
     Sum.CVAL2,
     Sum.CVAL3,
     timeper,
     timepers)

gc(verbose=FALSE)
