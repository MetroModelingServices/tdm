# k.DestChoiceCleanup.R

rm(list=ls()[grep("ma*",ls())])
rm(list=ls()[grep("mo*",ls())])
rm(list=ls()[grep("ms*",ls())])
rm(list=ls()[grep("md*",ls())])
rm(list=ls()[grep("mf*",ls())])
rm ( am_trconst,
     bikeconst,
     trconst,
     dpconst,
     ivCoeff,
     paconst,
     paramSet,
     prconst,
     tranconst,
     walkconst,
     westhill2east,
     zeroConstant)

gc(verbose=FALSE)
