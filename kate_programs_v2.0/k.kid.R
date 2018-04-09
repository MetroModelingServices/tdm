#k.khia.R
#Kid Model

# Coefficients
kid0.HHsizeCoeff  <- -4.0690
kid1.HHsizeCoeff  <- -2.4253
kid2.HHsizeCoeff  <- -0.6128
kid0.ageHeadCoeff <- 6.9224
kid1.ageHeadCoeff <- 4.5986
kid2.ageHeadCoeff <- 1.6392

hia<-0

#Loop through household sizes (1-4)
for (h in 1:4){

  #Loop through incomes (1-4)
  for (i in 1:4){

    #Loop through ages (1-4)
    for (a in 1:4){
  	  
	    # 0-kid
	    Temp0KidUtility <- exp(kid0.HHsizeCoeff * h + kid0.ageHeadCoeff * a)
	    
  	  # 1-kid
	    Temp1KidUtility <- 0
	    if(h>1){
	      Temp1KidUtility <- exp(kid1.HHsizeCoeff * h + kid1.ageHeadCoeff * a)
	    }
    
  	  # 2-kid
      Temp2KidUtility <- 0
      if(h>2){
        Temp2KidUtility <- exp(kid2.HHsizeCoeff * h + kid2.ageHeadCoeff * a)
      }
      
  	  # 3-kid
      Temp3KidUtility <- 0
      if(h>3){
        Temp3KidUtility <- 1
      }
    
      KidUtilitySum <- Temp0KidUtility + Temp1KidUtility + Temp2KidUtility + Temp3KidUtility
      
      hia <- hia + 1
      
      temp.k0hia <- Temp0KidUtility / KidUtilitySum * mf.hia[,hia]
      temp.k1hia <- Temp1KidUtility / KidUtilitySum * mf.hia[,hia]
      temp.k2hia <- Temp2KidUtility / KidUtilitySum * mf.hia[,hia]
      temp.k3hia <- Temp3KidUtility / KidUtilitySum * mf.hia[,hia]
      
      if(hia==1){
        mf.k0hia <- temp.k0hia
        mf.k1hia <- temp.k1hia
        mf.k2hia <- temp.k2hia
        mf.k3hia <- temp.k3hia
      }
      
      else{
        mf.k0hia <- cbind(mf.k0hia,temp.k0hia)
        mf.k1hia <- cbind(mf.k1hia,temp.k1hia)
        mf.k2hia <- cbind(mf.k2hia,temp.k2hia)
        mf.k3hia <- cbind(mf.k3hia,temp.k3hia)
      }
    }
  }
}

mf.khia <- cbind(mf.k0hia,mf.k1hia,mf.k2hia,mf.k3hia)

Tot.Kid0.khia <- sum(mf.khia[,1:64])
Tot.Kid1.khia <- sum(mf.khia[,65:128])
Tot.Kid2.khia <- sum(mf.khia[,129:192])
Tot.Kid3.khia <- sum(mf.khia[,193:256])
Tot.AllKids.khia <- Tot.Kid0.khia + Tot.Kid1.khia + Tot.Kid2.khia + Tot.Kid3.khia

rm(kid0.HHsizeCoeff,kid1.HHsizeCoeff,kid2.HHsizeCoeff,
   kid0.ageHeadCoeff,kid1.ageHeadCoeff,kid2.ageHeadCoeff,
   hia,h,i,a,
   Temp0KidUtility,Temp1KidUtility,Temp2KidUtility,Temp3KidUtility,KidUtilitySum,
   temp.k0hia,temp.k1hia,temp.k2hia,temp.k3hia)

