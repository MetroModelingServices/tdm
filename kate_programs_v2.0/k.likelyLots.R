
#Portland Metro Creation of Likely Lots for Lot Choice Model
#Generates the likely lots alternative set by OD for PNR and PNH nests
#Ben Stabler, stabler@pbworld.com, 01/15/10

######################################
# Likely Lot Set Functions
######################################

#function to calculate best formal lots
calcBestLots = function(lottaz, mf.tdist, mf.auto, mf.transit, canPNR, paramSet, saveUtil=F) {

    #attach paramSet for local references
    attach(paramSet)

    #calculate lot travel distance from production
    lotDistance = mf.tdist[,lottaz$TAZ]
    
    #distance from production to park core zones
    distToParkCore = apply(mf.tdist[,parkCoreZones],1,max)

    #only those lots with distance < distanceParkCore and distance < distanceCriteria
    numzones = nrow(mf.tdist)
    lotsAvail = list()
    for(i in 1:numzones) {
      lotsAvail[[i]] = lottaz$TAZ[which(lotDistance[i,] < distanceCriteria & lotDistance[i,] < distToParkCore[i])]
    }
    
    #Generalized cost
    startTime = Sys.time()
    print("Formal likely lot set calculation started")
    
    bestLotsArray = array(NA, c(numzones,numzones,sum(bestNByType)))
    if(saveUtil) { bestLotsArrayUtil = array(NA, c(numzones,numzones,sum(bestNByType))) }
    
    for(i in 1:numzones) {
      
      numLotsAvail = length(lotsAvail[[i]])
      lotNames = lotsAvail[[i]]
      
      if(numLotsAvail > 0) {
        if((i %% 100)==0) { print(paste("Formal lot choice set for production zone", i)) }
        
        #rank and take top bestNByType lot choices to choice model
        if(numLotsAvail > 1) {
        
          util = as.matrix(mf.auto[i,lotsAvail[[i]]] + mf.transit[lotsAvail[[i]],])
          rownames(util) = lotNames
          lottype = lottaz$TYPE[match(lotsAvail[[i]], lottaz$TAZ)]
          lottypes = unique(lottype)

          for(d in 1:numzones) {
            if(canPNR[d]) { #skip if no PNR to destination

              #trace OD
              if(!is.na(lotChoiceTraceOD[1]) & lotChoiceTraceOD[1]==i & lotChoiceTraceOD[2]==d) {
                cat(paste("\n likely lots utility [", i, ",", d, "]\n"), file=loglotChoiceFileName, append=T)
                write.table(util[,d], file=loglotChoiceFileName, append=T, col.names=F)
              }

              lots = list()
              for(lt in lottypes) {
              
                utilType = util[,d][lottype == lt]
                lotsToPick = sort(utilType, decreasing=T)[1:bestNByType[lt]]
                lots = c(unlist(lots), as.integer(names(lotsToPick)))
                
              }
              bestLotsArray[i,d,1:length(lots)] = lots
              if(saveUtil) { bestLotsArrayUtil[i,d,1:length(lots)] = util[match(lots,rownames(util)),d] }
            }
            
          }
          
        } else {
          #only 1 lot
          util = as.matrix(mf.auto[i,lotsAvail[[i]]] + mf.transit[lotsAvail[[i]],])
          bestLotsArray[i,(canPNR > 0),1] = lotsAvail[[i]]
          if(saveUtil) { bestLotsArrayUtil[i,canPNR,1] = util[canPNR] }
        }
      }
    }


    #return list of result
    print(paste("Formal lot choice calculation done in ", round(difftime(Sys.time(), startTime),2), "min"))
    detach(paramSet)
    if(saveUtil) { 
      return(list(bestLotsArray, bestLotsArrayUtil))
    } else {
      return(list(bestLotsArray))
    }
}

#function to calculate best informal lots
calcBestInfLots = function(lottaz, mf.tdist, mf.auto, mf.transit, mf.trwait1, mf.trwait2, mf.trivt, ma.inthm, canPNR, canInf, paramSet, saveUtil=F) {

    #attach paramSet for local references
    attach(paramSet)
    
    #start calculation
    startTime = Sys.time()
    print("Informal likely lot set calculation started")

    #distance from production to park core zones
    distToParkCore = apply(mf.tdist[,parkCoreZones],1,max)

    #wait to park core zones
    wait = apply((mf.trwait1 + mf.trwait2)[,parkCoreZones],1,min) #best to any of the park cores

    #ivt to park core zones
    ivt = apply(mf.trivt[,parkCoreZones],1,min) #best to any of the park cores

    #available lots - no formal option, not designated as canpnr zone, can be informal, has transit to dest
    numzones = nrow(mf.tdist)
    available = rep(T,numzones)
    available[canPNR] = F
    available[canInf==F] = F
    available[lottaz$TAZ] = F
    available = (mf.trwait1 < 9999) & available #lot to dest
    
    #only those lots with: distance < distanceParkCore and distance < distanceCriteria 
    #and no PNR at dest and wait to park core <= 5 min and ivt to park core <= 45 min
    lotsAvail = c()
    for(i in 1:numzones) {
      tempLots = c()
      for(j in 1:numzones) {
        if(canPNR[j]) { #skip if no PNR at destination
          lotDistance = mf.tdist[i,]
          lotsForDest = which(available[,j] & lotDistance < distanceCriteria & 
            lotDistance < distToParkCore[i] & wait <= waitCriteria & ivt <= ivtCriteria & ma.inthm > inthmCriteria)
          tempLots = unique(c(tempLots, lotsForDest))
        }
      }
      if((i %% 100)==0) { print(paste("Initial informal lot choice set for production zone", i)) }
      lotsAvail[[i]] = tempLots
    }
    
    bestLotsArray = array(NA, c(numzones,numzones,sum(bestNInf)))
    if(saveUtil) { bestLotsArrayUtil = array(NA, c(numzones,numzones,sum(bestNInf))) }
    
    for(i in 1:numzones) {
      
      numLotsAvail = length(lotsAvail[[i]])
      lotNames = lotsAvail[[i]]
      
      if(numLotsAvail > 0) {
        if((i %% 100)==0) { print(paste("Informal lot choice set for production zone", i)) }
        
        #rank and take top bestNInf lot choices to choice model
        if(numLotsAvail > 1) {
        
          util = as.matrix(mf.auto[i,lotsAvail[[i]]] + mf.transit[lotsAvail[[i]],])
          rownames(util) = lotNames

          for(d in 1:numzones) {
            if(canPNR[d]) { #skip if no PNR at destination
            
              #trace OD
              if(!is.na(lotChoiceTraceOD[1]) & lotChoiceTraceOD[1]==i & lotChoiceTraceOD[2]==d) {
                cat(paste("\n likely informal lots utility [", i, ",", d, "]\n"), file=loglotChoiceFileName, append=T)
                write.table(util[,d], file=loglotChoiceFileName, append=T, col.names=F)
              }
            
              lotsToPick = sort(util[,d], decreasing=T)[1:bestNInf]
              bestLotsArray[i,d,1:length(lotsToPick)] = as.integer(names(lotsToPick))
              if(saveUtil) { bestLotsArrayUtil[i,d,1:length(lotsToPick)] = util[match(names(lotsToPick),rownames(util)),d] }
            }
            
          }
          
        } else {
          #only 1 lot
          util = as.matrix(mf.auto[i,lotsAvail[[i]]] + mf.transit[lotsAvail[[i]],])
          bestLotsArray[i,canPNR,1] = as.integer(lotsAvail[[i]])
          if(saveUtil) { bestLotsArrayUtil[i,canPNR,1] = util[canPNR] }
        }
      }
    }

    #return list of result
    print(paste("Informal lot choice calculation done in ", round(difftime(Sys.time(), startTime),2), "min"))
    detach(paramSet)
    if(saveUtil) { 
      return(list(bestLotsArray, bestLotsArrayUtil))
    } else {
      return(list(bestLotsArray))
    }
}

#check if warm start files are in proper location
if(warmStartShadowPricing) {
  if(!file.exists(input_lottaz_filename) | !file.exists(input_lottazinf_filename)) {
    print("warm start shadow pricing set but FORMAL or INFORMAL lot input file not found")
    print("running pnr model using cold start settings")
    warmStartShadowPricing <- FALSE
  }
}

######################################
# Inputs
######################################

#parameters set
paramSet = list()
paramSet$distanceCriteria = 20     #miles
paramSet$bestNByType = c(1,1)      #1 type=1 and 1 type=2 lots
paramSet$bestNInf = 2              #informal lots
paramSet$parkCoreZones = c(1,1492) #park core zones (1=Portland CBD, 1492=Vancouver CBD)
paramSet$waitCriteria = 5          #max wait to park core for informal
paramSet$ivtCriteria = 45          #max ivt to park core for informal 
paramSet$inthmCriteria = 75        #intersection half mile min criteria

#canPNR - currently set to any zones with long term parking cost
canPNR = ma.canpnr > 0

#canInf - zones which can be informal park and ride lots
canInf = ma.caninf > 0

#read formal lots input file and create aggregation by taz
#TAZ,NAME,TYPE,CAPACITY,VOLUME,PARKCOST,DIFFTARGET
#capacities confirmed with TriMet and C-Tran
lots = readXLSXmatrix(proj.inputs,"lots",lotsmtx=T)

#read informal lots input file and create aggregation by taz
#TAZ,CAPACITY,VOLUME,SHADOWPRICE
#capacity currently assumed to be 100 veh/zone
lots_inf = readXLSXmatrix(proj.inputs,"lots_inf",lotsmtx=T)

#get auto and transit leg matrices
load("mf.auto.hbw.am.m.RData")    #returns mf.auto
load("mf.transit.hbw.am.m.RData") #returns mf.transit

#also used by the calculation: mf.tdist, mf.trwait1, mf.trwait2, mf.trivt, ma.inthm
mf.trwait1 = mf.amtwt1
mf.trwait2 = mf.amtwt2
mf.trivt = mf.amtbiv + mf.amtliv + mf.amtriv + mf.amtsciv + mf.amtbriv
ma.inthm <- readXLSXvector(proj.inputs,"inthm")

######################################
# Run the Calculations
######################################

print("Starting likely lots calculation")

#aggregate lots to lottaz (to taz level)
lottaz = data.frame(TAZ=tapply(lots$TAZ,lots$TAZ,function(x)x[1]))
lottaz$CAPACITY = tapply(lots$CAPACITY,lots$TAZ,sum)
lottaz$VOLUME = tapply(lots$VOLUME,lots$TAZ,sum)
lottaz$TYPE = tapply(lots$TYPE,lots$TAZ,mean)
lottaz$PARKCOST = tapply(lots$PARKCOST,lots$TAZ,mean)
lottaz$DIFFTARGET = tapply(lots$DIFFTARGET,lots$TAZ,sum)
lottaz$SHADOWPRICE = 0 #will be calculated later
save(lottaz, file=paste(project.dir, "model/lottaz.RData", sep="/"))

#update lot shadow price based on previous/input lottaz_in.csv
if(warmStartShadowPricing) {
	lottaz_prev = read.csv(input_lottaz_filename)
	lottaz$SHADOWPRICE = lottaz_prev$SHADOWPRICE[match(lottaz$TAZ, lottaz_prev$TAZ)]
	lottaz$SHADOWPRICE[!is.finite(lottaz$SHADOWPRICE)] = 0
	save(lottaz, file=paste(project.dir, "model/lottaz.RData", sep="/"))
}

#create formal PNR likely lot sets
bestLotsArray = calcBestLots(lottaz, mf.tdist, mf.auto, mf.transit, canPNR, paramSet, TRUE)
bestLotsUtilArray = bestLotsArray[[2]]
bestLotsArray = bestLotsArray[[1]]
save(bestLotsArray, file=paste(project.dir, "model/bestLotsArray.RData", sep="/"))
save(bestLotsUtilArray, file=paste(project.dir, "model/bestLotsUtilArray.RData", sep="/"))
rm(bestLotsArray,bestLotsUtilArray)

#create informal PNH likely lot sets
bestInfLotsArray = calcBestInfLots(lottaz, mf.tdist, mf.auto, mf.transit, mf.trwait1, mf.trwait2, mf.trivt, ma.inthm, canPNR, canInf, paramSet, TRUE)
bestInfLotsUtilArray = bestInfLotsArray[[2]]
bestInfLotsArray = bestInfLotsArray[[1]]
save(bestInfLotsArray, file=paste(project.dir, "model/bestInfLotsArray.RData", sep="/"))
save(bestInfLotsUtilArray, file=paste(project.dir, "model/bestInfLotsUtilArray.RData", sep="/"))

#aggregate lots to lottazinf (to taz level)
lottazinf = unique(as.vector(bestInfLotsArray))
lottazinf = data.frame(TAZ=sort(as.numeric(lottazinf)))
lottazinf$CAPACITY = tapply(lots_inf$CAPACITY,lots_inf$TAZ,sum)[match(lottazinf$TAZ, lots_inf$TAZ)]
lottazinf$VOLUME = tapply(lots_inf$VOLUME,lots_inf$TAZ,sum)[match(lottazinf$TAZ, lots_inf$TAZ)]
lottazinf$SHADOWPRICE = 0
save(lottazinf, file=paste(project.dir, "model/lottazinf.RData", sep="/"))

#update lot shadow price based on previous/input lottazinf_in.csv
if(warmStartShadowPricing) {
	lottazinf_prev = read.csv(input_lottazinf_filename)
	lottazinf$SHADOWPRICE = lottazinf_prev$SHADOWPRICE[match(lottazinf$TAZ, lottazinf_prev$TAZ)]
	lottazinf$SHADOWPRICE[!is.finite(lottazinf$SHADOWPRICE)] = 0
	save(lottazinf, file=paste(project.dir, "model/lottazinf.RData", sep="/"))
}

print("Likely lots calculation complete")
