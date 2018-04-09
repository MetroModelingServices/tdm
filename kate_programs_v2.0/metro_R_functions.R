emmePythonPath <- "\"C:/Python27/python\""

frequency_distribution<-function(distribution_matrix,weight_matrix,interval=0.1,start=0,end=150){
  if (end %% interval > 0 )
    end<-end+(inverval - (end %% interval))
  output <- array(0,dim=(((end-start)/interval)+1))
  bucket<-ceiling(distribution_matrix*(1/interval))+1
  for (b in 1:max(bucket)){
    output[b]<-sum(weight_matrix*(bucket==b))
  }
  return<-output
}

district_squeeze <- function(matrix,ensemble) {
  max<-max(ensemble)
  if(is.vector(matrix)){
    squeeze<-array(,dim=max)
    for (i in 1:max){
      squeeze[i]<-sum(matrix[ensemble==i])
    }
  }
  else if(length(matrix[1,])!=length(matrix[,1])){
    squeeze<-array(,dim=c(max,length(matrix[1,])))
    for (i in 1:max){
      for(j in 1:length(matrix[1,])){
        squeeze[i,j]<-sum(matrix[ensemble==i,j])
      }
    }
  }
  else{
    squeeze<-array(,dim=c(max,max))
    for (i in 1:max){
      for (j in 1:max){
        squeeze[i,j]<-sum(matrix[ensemble==i,ensemble==j])
      }
    }
  }
  return(squeeze)
}


district_squeeze_csv<-function(matrix_name,ens,desc,outfile){
  district<-district_squeeze(matrix_name,ens)
  if(is.vector(matrix_name)){
    for (i in 1:max(ens)){
      cat(i,desc,district[i],"\n",sep=",",file=outfile)
    }
  } else {
    for (i in 1:max(ens)){
      for (j in 1:max(ens)){
        cat(i,j,desc,district[i,j],"\n",sep=",",file=outfile)
      }
    }
  }
}


district_squeeze_households <- function(matrix,ensemble) {
  max<-max(ensemble)
    squeeze<-array(,dim=c(max,length(matrix[1,])))
    for (i in 1:max){
      for(j in 1:length(matrix[1,])){
        squeeze[i,j]<-sum(matrix[ensemble==i,j])
      }
    }
  return(squeeze)
}

hh_sum <- function(cval,cars=0:3,workers=0:3,cvals=0:3,hvals=1:4,ivals=1:4,avals=1:4){
  cval_sum(cval,cars,workers,cvals,hvals,ivals,avals)
}
cval_sum <- function(cval,cars=0:3,workers=0:3,cvals=0:3,hvals=1:4,ivals=1:4,avals=1:4){
cval_map<-array(0,c(16,3))
cval_map[1,]<-array(c(0,0,0))
cval_map[2,]<-array(c(0,1,0))
cval_map[3,]<-array(c(0,2,0))
cval_map[4,]<-array(c(0,3,0))
cval_map[5,]<-array(c(1,2,1))
cval_map[6,]<-array(c(1,3,1))
cval_map[7,]<-array(c(2,3,1))
cval_map[8,]<-array(c(1,1,2))
cval_map[9,]<-array(c(2,2,2))
cval_map[10,]<-array(c(3,3,2))
cval_map[11,]<-array(c(1,0,3))
cval_map[12,]<-array(c(2,0,3))
cval_map[13,]<-array(c(2,1,3))
cval_map[14,]<-array(c(3,0,3))
cval_map[15,]<-array(c(3,1,3))
cval_map[16,]<-array(c(3,2,3))
cval_map<-list(cars=cval_map[,1], workers=cval_map[,2], cval=cval_map[,3])
total<-0
  for (x in 1:16){
      for (h in hvals){
        for (i in ivals){
          for (a in avals){
      if((sum(cval_map$cval[x]==cvals)>0)&&(sum(cval_map$cars[x]==cars)>0)&&(sum(cval_map$workers[x]==workers)>0)){
              column<-(x-1)*64+(h-1)*16+(i-1)*4+(a)
              total<-total+cval[,column]
            }
          }
        }
      }
  }
  return(total)
}
whia_sum <- function(whia,hvals=1:4,ivals=1:4,avals=1:4){
  total<-0
      for (h in hvals){
        for (i in ivals){
          for (a in avals){
            column<-(h-1)*16+(i-1)*4+(a)
            total<-total+whia[,column]
          }
        }
      }
  return(total)
}

cval_sum_output <- function(){
outfile<-file("cval.csv","w")
cval_map<-read.table("cval_map.csv",sep=",")
names(cval_map)[1]<-"cars"
names(cval_map)[2]<-"workers"  
names(cval_map)[3]<-"cval"  
name<-desc
total<-0
  for (x in 1:16){
      for (h in 1:4){
        for (i in 1:4){
          for (a in 1:4){
            for (t in 1:1998){
              column<-(x-1)*64+(h-1)*16+(i-1)*4+(a)
              cat(t,cval_map$cars[x],cval_map$cval[x],cval_map$workers[x],h,i,a,cval[t,column],"\n",file=outfile,sep=",")
            }
          }
        }
      }
  }
}
matrix_to_csv<- function(matrix,outfile){
  library(reshape)
  out.temp<-melt(matrix)
  write.table(out.temp, file=outfile, sep=",", row.names=FALSE, col.names=FALSE)
}

load_distribution_matrices<-function(dir="",sum_income_groups=F,remove_income_groups=F){
  load(file=paste(dir,"model_hbw/mf.hbwdth.dat",sep=''),.GlobalEnv)
  load(file=paste(dir,"model_hbw/mf.hbwdtm.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbw/mf.hbwdtl.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbr/mf.hbrdth.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbr/mf.hbrdtm.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbr/mf.hbrdtl.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbs/mf.hbsdth.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbs/mf.hbsdtm.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbs/mf.hbsdtl.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbo/mf.hbodth.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbo/mf.hbodtm.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_hbo/mf.hbodtl.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_nh/mf.nhwdt.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_nh/mf.nhnwdt.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_sc/mf.schdt.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_sc/mf.colldth.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_sc/mf.colldtm.dat",sep=''),.GlobalEnv) 
  load(file=paste(dir,"model_sc/mf.colldtl.dat",sep=''),.GlobalEnv) 
  if(sum_income_groups||remove_income_groups){
    mf.hbwdt <<- mf.hbwdth + mf.hbwdtm + mf.hbwdtl
    mf.hbrdt <<- mf.hbrdth + mf.hbrdtm + mf.hbrdtl
    mf.hbodt <<- mf.hbodth + mf.hbodtm + mf.hbodtl
    mf.hbsdt <<- mf.hbsdth + mf.hbsdtm + mf.hbsdtl
    mf.coldt <<- mf.coldth + mf.coldtm + mf.coldtl
  }
  if(remove_income_groups){
    remove_income_groups()
    #rm(mf.hbwdth,mf.hbwdtm,mf.hbwdtl,mf.hbodth,mf.hbodtm,mf.hbodtl,mf.hbrdth,mf.hbrdtm,mf.hbrdtl,mf.hbsdth,mf.hbsdtm,mf.hbsdtl)
  }
}

remove_income_groups<-function(){
    rm(mf.hbwdth,mf.hbwdtm,mf.hbwdtl,mf.hbodth,mf.hbodtm,mf.hbodtl,mf.hbrdth,mf.hbrdtm,mf.hbrdtl,mf.hbsdth,mf.hbsdtm,mf.hbsdtl,mf.coldth,mf.coldtm,mf.coldtl,envir=.GlobalEnv)
}


load_mc_matrices<-function(directory=""){

  # load all home based trip purpose tables
  trippurp <- c("hw", "ho", "hr", "hs", "hc")
  mode <- c("da", "dp", "pa", "prtr", "tr", "bike", "walk")
  tod <- c("pk", "op")

  for (p in 1:length(trippurp)) {
    for (m in 1:length(mode))   {
      for (i in 1:length(tod))  {
        load(file=paste(directory,"mf.",trippurp[p],mode[m],".",tod[i],".dat",sep=''))
      }
      assign(paste("mf.",trippurp[p],mode[m],sep=''),
         get(paste("mf.",trippurp[p],mode[m],".pk",sep='')) +
         get(paste("mf.",trippurp[p],mode[m],".op",sep='')), pos = globalenv())
    }
  }

  # load all non-home based trip purpose tables
  trippurp <- c("nhw", "nhnw")
  mode <- c("da", "dp", "pa", "tr", "bike", "walk")
  tod <- c("pk", "op")

  for (p in 1:length(trippurp)) {
    for (m in 1:length(mode))   {
      for (i in 1:length(tod))  {
        load(file=paste(directory,"mf.",trippurp[p],mode[m],".",tod[i],".dat",sep=''))
      }
      assign(paste("mf.",trippurp[p],mode[m],sep=''),
         get(paste("mf.",trippurp[p],mode[m],".pk",sep='')) +
         get(paste("mf.",trippurp[p],mode[m],".op",sep='')), pos = globalenv())
    }
  }

  load(file=paste(directory,"mf.schveh.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.schpas.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.schbus.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.schwalk.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.schbike.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.schtr.dat",sep=''),.GlobalEnv)

  rm(list=ls()[grep((".pk"),ls())])
  rm(list=ls()[grep((".op"),ls())])
}

save_mc_summary_matrices<-function(directory=""){
  mf.autopersontrips <- mf.hwda + mf.hwdp + mf.hwpa + 
  mf.hcda + mf.hcdp + mf.hcpa + 
  mf.hoda + mf.hodp + mf.hopa + 
  mf.hrda + mf.hrdp + mf.hrpa + 
  mf.hsda + mf.hsdp + mf.hspa + 
  mf.nhnwda + mf.nhnwdp + mf.nhnwpa + 
  mf.nhwda + mf.nhwdp + mf.nhwpa + 
  mf.schveh + mf.schpas
  
  mf.sovtrips <- mf.hwda + mf.hcda + mf.hoda + mf.hrda + mf.hsda + mf.nhnwda + mf.nhwda + mf.schveh
  mf.transittrips <- mf.hwtr + mf.hwprtr + 
  mf.hctr + mf.hcprtr + 
  mf.hotr + mf.hoprtr + 
  mf.hrtr + mf.hrprtr + 
  mf.hstr + mf.hsprtr + 
  mf.nhnwtr + 
  mf.nhwtr + 
  mf.schtr
  
  mf.biketrips <- mf.hwbike + mf.hcbike + mf.hobike + mf.hrbike + mf.hsbike + mf.nhnwbike + mf.nhwbike + mf.schbike
  mf.walktrips <- mf.hwwalk + mf.hcwalk + mf.howalk + mf.hrwalk + mf.hswalk + mf.nhnwwalk + mf.nhwwalk + mf.schwalk
  mf.vehicletrips <- mf.hwda + mf.hwdp + 
  mf.hcda + mf.hcdp + 
  mf.hoda + mf.hodp + 
  mf.hrda + mf.hrdp + 
  mf.hsda + mf.hsdp + 
  mf.nhnwda + mf.nhnwdp + 
  mf.nhwda + mf.nhwdp + 
  mf.schveh
  
  mf.persontrips <- mf.hwda + mf.hwdp + mf.hwpa + mf.hwbike + mf.hwprtr + mf.hwtr + mf.hwwalk + 
  mf.hsda + mf.hsdp + mf.hspa + mf.hsbike + mf.hsprtr + mf.hstr + mf.hswalk + 
  mf.hrda + mf.hrdp + mf.hrpa + mf.hrbike + mf.hrprtr + mf.hrtr + mf.hrwalk + 
  mf.hoda + mf.hodp + mf.hopa + mf.hobike + mf.hoprtr + mf.hotr + mf.howalk + 
  mf.hcda + mf.hcdp + mf.hcpa + mf.hcbike + mf.hcprtr + mf.hctr + mf.hcwalk + 
  mf.nhnwda + mf.nhnwdp + mf.nhnwpa + mf.nhnwbike + mf.nhnwtr + mf.nhnwwalk + 
  mf.nhwda + mf.nhwdp + mf.nhwpa + mf.nhwbike + mf.nhwtr + mf.nhwwalk + 
  mf.schveh + mf.schpas + mf.schtr + mf.schbus + mf.schwalk + mf.schbike

  save(mf.autopersontrips,file=paste(directory,"mf.autopersontrips.dat",sep=''))
  save(mf.transittrips,file=paste(directory,"mf.transittrips.dat",sep=''))
  save(mf.sovtrips,file=paste(directory,"mf.sovtrips.dat",sep=''))
  save(mf.biketrips,file=paste(directory,"mf.biketrips.dat",sep=''))
  save(mf.walktrips,file=paste(directory,"mf.walktrips.dat",sep=''))
  save(mf.vehicletrips,file=paste(directory,"mf.vehicletrips.dat",sep=''))
  save(mf.persontrips,file=paste(directory,"mf.persontrips.dat",sep=''))
}

save_mc_summary_matrices_noSchool<-function(directory=""){
  mf.autopersontrips <- mf.hwda + mf.hwdp + mf.hwpa + 
  mf.hcda + mf.hcdp + mf.hcpa + 
  mf.hoda + mf.hodp + mf.hopa + 
  mf.hrda + mf.hrdp + mf.hrpa + 
  mf.hsda + mf.hsdp + mf.hspa + 
  mf.nhnwda + mf.nhnwdp + mf.nhnwpa + 
  mf.nhwda + mf.nhwdp + mf.nhwpa 
  
  mf.sovtrips <- mf.hwda + mf.hcda + mf.hoda + mf.hrda + mf.hsda + mf.nhnwda + mf.nhwda
  mf.transittrips <- mf.hwtr + mf.hwprtr + 
  mf.hctr + mf.hcprtr + 
  mf.hotr + mf.hoprtr + 
  mf.hrtr + mf.hrprtr + 
  mf.hstr + mf.hsprtr + 
  mf.nhnwtr + 
  mf.nhwtr
  
  mf.biketrips <- mf.hwbike + mf.hcbike + mf.hobike + mf.hrbike + mf.hsbike + mf.nhnwbike + mf.nhwbike
  mf.walktrips <- mf.hwwalk + mf.hcwalk + mf.howalk + mf.hrwalk + mf.hswalk + mf.nhnwwalk + mf.nhwwalk
  mf.vehicletrips <- mf.hwda + mf.hwdp + 
  mf.hcda + mf.hcdp + 
  mf.hoda + mf.hodp + 
  mf.hrda + mf.hrdp + 
  mf.hsda + mf.hsdp + 
  mf.nhnwda + mf.nhnwdp + 
  mf.nhwda + mf.nhwdp
  
  mf.persontrips <- mf.hwda + mf.hwdp + mf.hwpa + mf.hwbike + mf.hwprtr + mf.hwtr + mf.hwwalk + 
  mf.hsda + mf.hsdp + mf.hspa + mf.hsbike + mf.hsprtr + mf.hstr + mf.hswalk + 
  mf.hrda + mf.hrdp + mf.hrpa + mf.hrbike + mf.hrprtr + mf.hrtr + mf.hrwalk + 
  mf.hoda + mf.hodp + mf.hopa + mf.hobike + mf.hoprtr + mf.hotr + mf.howalk + 
  mf.hcda + mf.hcdp + mf.hcpa + mf.hcbike + mf.hcprtr + mf.hctr + mf.hcwalk + 
  mf.nhnwda + mf.nhnwdp + mf.nhnwpa + mf.nhnwbike + mf.nhnwtr + mf.nhnwwalk + 
  mf.nhwda + mf.nhwdp + mf.nhwpa + mf.nhwbike + mf.nhwtr + mf.nhwwalk

  save(mf.autopersontrips,file=paste(directory,"mf.autopersontrips_ns.dat",sep=''))
  save(mf.transittrips,file=paste(directory,"mf.transittrips_ns.dat",sep=''))
  save(mf.sovtrips,file=paste(directory,"mf.sovtrips_ns.dat",sep=''))
  save(mf.biketrips,file=paste(directory,"mf.biketrips_ns.dat",sep=''))
  save(mf.walktrips,file=paste(directory,"mf.walktrips_ns.dat",sep=''))
  save(mf.vehicletrips,file=paste(directory,"mf.vehicletrips_ns.dat",sep=''))
  save(mf.persontrips,file=paste(directory,"mf.persontrips_ns.dat",sep=''))
}

load_mc_summary_matrices<-function(directory=""){
  load(file=paste(directory,"mf.autopersontrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.transittrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.sovtrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.biketrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.walktrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.vehicletrips.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.persontrips.dat",sep=''),.GlobalEnv)
}

load_mc_summary_matrices_noSchool<-function(directory=""){
  load(file=paste(directory,"mf.autopersontrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.transittrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.sovtrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.biketrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.walktrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.vehicletrips_ns.dat",sep=''),.GlobalEnv)
  load(file=paste(directory,"mf.persontrips_ns.dat",sep=''),.GlobalEnv)
}

load_mc_matrices_pnr<-function(directory=""){
  # Load Park&Ride Trips From Lot to destination
  load(file=paste(directory,"mf.hwprtrtd.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hsprtrtd.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hrprtrtd.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hoprtrtd.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hcprtrtd.pk.dat", sep="/"))

  load(file=paste(directory,"mf.hwprtrtd.op.dat", sep="/"))
  load(file=paste(directory,"mf.hsprtrtd.op.dat", sep="/"))
  load(file=paste(directory,"mf.hrprtrtd.op.dat", sep="/"))
  load(file=paste(directory,"mf.hoprtrtd.op.dat", sep="/"))
  load(file=paste(directory,"mf.hcprtrtd.op.dat", sep="/"))

  mf.hwprtrtd <<- mf.hwprtrtd.pk + mf.hwprtrtd.op
  mf.hsprtrtd <<- mf.hsprtrtd.pk + mf.hsprtrtd.op
  mf.hrprtrtd <<- mf.hrprtrtd.pk + mf.hrprtrtd.op
  mf.hoprtrtd <<- mf.hoprtrtd.pk + mf.hoprtrtd.op
  mf.hcprtrtd <<- mf.hcprtrtd.pk + mf.hcprtrtd.op

  # Load Park&Ride Trips From Origin to Lot
  load(file=paste(directory,"mf.hwprtrtl.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hsprtrtl.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hrprtrtl.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hoprtrtl.pk.dat", sep="/"))
  load(file=paste(directory,"mf.hcprtrtl.pk.dat", sep="/"))

  load(file=paste(directory,"mf.hwprtrtl.op.dat", sep="/"))
  load(file=paste(directory,"mf.hsprtrtl.op.dat", sep="/"))
  load(file=paste(directory,"mf.hrprtrtl.op.dat", sep="/"))
  load(file=paste(directory,"mf.hoprtrtl.op.dat", sep="/"))
  load(file=paste(directory,"mf.hcprtrtl.op.dat", sep="/"))

  mf.hwprtrtl <<- mf.hwprtrtl.pk + mf.hwprtrtl.op
  mf.hsprtrtl <<- mf.hsprtrtl.pk + mf.hsprtrtl.op
  mf.hrprtrtl <<- mf.hrprtrtl.pk + mf.hrprtrtl.op
  mf.hoprtrtl <<- mf.hoprtrtl.pk + mf.hoprtrtl.op
  mf.hcprtrtl <<- mf.hcprtrtl.pk + mf.hcprtrtl.op
}

trip_in_out<-function(mat){
  zones<-as.matrix(array(1:dim(mat)[1],dim=dim(mat)[1]))
  intra<-diag(mat)
  prod<-rowSums(mat)-intra
  attr<-colSums(mat)-intra
  return<-cbind(zones,prod,attr,intra)
  return
}

load_ensemble <- function(ensfile,ensname) {
  ensemble <- readXLSXvector(ensfile,ensname,spreadsheetName="ensembles")
  assign(paste("ensemble", ensname, sep="."), ensemble, envir=.GlobalEnv)
}

#function to get a vector index for a matrix
#Ben Stabler, stabler@pbworld.com, 01/15/10
toVecIndex = function(mat, firstleg=T) {
  if(firstleg) {
    row = rep(1:nrow(mat),ncol(mat))
    col = as.vector(mat)
  } else {
    row = as.vector(mat)
    col = rep(1:ncol(mat),each=nrow(mat))
  }
  x = matrix((col-1)*nrow(mat)+row, nrow(mat), ncol(mat))
  return(x)
}

#Calculate nested utilities for PNR and PNH nests
#Ben Stabler, stabler@pbworld.com, 01/15/10
#Updated 01/11/11 BTS to move formal and informal lot constants to lowest level to make them easier to manage
calcPNRUtils = function(timeper, inc, project.dir, prconst, beginrow, endrow, paramSet) {
 
  #attach paramSet for local referencing
  attach(paramSet)
  
  print(paste("starting lot utilities calculation - ", purpose, cv, timeper, inc))
  
  #get auto and transit leg matrices
  load(paste("mf.PNRauto.", purpose, ".", timeper, ".", inc, ".RData", sep="")) #returns mf.auto
  load(paste("mf.transit.", purpose, ".", timeper, ".", inc, ".RData", sep="")) #returns mf.transit

  #add stop and vehicle type constants (AAB, 3/1/11)
  mf.vtypconst <- readEmme(bank,paste("mf",timeper,"vehc", sep=""))[1:numzones,1:numzones]
  mf.stypconst <- readEmme(bank,paste("mf",timeper,"stpc", sep=""))[1:numzones,1:numzones]
  mf.transit   <- mf.transit + mf.stypconst + mf.vtypconst
  
  #get formal and informal likely lot sets by OD    
  load(paste(project.dir, "model/bestLotsArray.RData", sep="/"))
  load(paste(project.dir, "model/bestInfLotsArray.RData", sep="/"))
  
  #get lottaz and lottazinf - need to get since may have changed due to multithreading by trip purpose
  load(paste(project.dir, "model/lottaz.RData", sep="/"))
  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  
  #get dimensions of outputs
  nFZ = length(beginrow:endrow)
  nTZ = ncol(bestLotsArray)
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    cat(paste("\n", "mode split",  paramSet$purpose, "timeper=", timeper, "inc=", inc, "beginrow=", beginrow, "endrow=", endrow, "\n"), file=loglotChoiceFileName, append=T)
    capture.output(paramSet, file=loglotChoiceFileName, append=T)
    writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.PNRauto","mf.transit"),loglotChoiceFileName)
    cat(paste("bestLotsArray[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], "]:", paste(bestLotsArray[lotChoiceTraceOD[1],lotChoiceTraceOD[2],], collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("bestInfLotsArray[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], "]:", paste(bestInfLotsArray[lotChoiceTraceOD[1],lotChoiceTraceOD[2],], collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
  }
  
  #loop through formal lots and calculate lot utilities
  formalUtil.lots = array(NA,c(nFZ,nTZ,dim(bestLotsArray)[3]))
  
  for(i in 1:dim(bestLotsArray)[3]) {
    
    #get auto and transit utilities
    mf.autoLeg = matrix(mf.PNRauto[toVecIndex(bestLotsArray[,,i])],nrow(mf.PNRauto),ncol(mf.PNRauto))
    mf.transitLeg = matrix(mf.transit[toVecIndex(bestLotsArray[,,i], FALSE)],nrow(mf.transit),ncol(mf.transit))
    
    #split matrices since mode choice model split into two pieces
    mf.autoLeg = mf.autoLeg[beginrow:endrow,]
    mf.transitLeg = mf.transitLeg[beginrow:endrow,]
    
    #get lot data
    rIndex = match(bestLotsArray[beginrow:endrow,,i],lottaz$TAZ)
    lotCost = matrix(lottaz$PARKCOST[rIndex], nFZ, nTZ)
    lotShadowPrice = matrix(lottaz$SHADOWPRICE[rIndex], nFZ, nTZ)
    
    mf.base = formalConstant + mf.autoLeg + mf.transitLeg + lotParkCostCoeff * lotCost + lotShadowPrice
    formalUtil.lots[,,i] = (mf.base + cvConstant) / (formalNestCoeff * pnrNestCoeff)
  
    #trace OD
    if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
      cat(paste("\n", "mode split",  paramSet$purpose, "timeper=", timeper, "inc=", inc, "beginrow=", beginrow, "endrow=", endrow), file=loglotChoiceFileName, append=T)
      cat(paste("\n formal lot", i, "\n"), file=loglotChoiceFileName, append=T)
      cat(paste("lotCost=", lotCost[1,1], "lotShadowPrice=", lotShadowPrice[1,1], "\n"), file=loglotChoiceFileName, append=T)
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.autoLeg","mf.transitLeg","mf.base"),loglotChoiceFileName,(beginrow:endrow))
    }
  
  }
  
  #loop through informal lots and calculate lot utilities
  informalUtil.lots = array(NA,c(nFZ,nTZ,dim(bestInfLotsArray)[3]))
  
  for(i in 1:dim(bestInfLotsArray)[3]) {
  
    #get auto and transit utilities
    mf.autoLeg = matrix(mf.PNRauto[toVecIndex(bestInfLotsArray[,,i])],nrow(mf.PNRauto),ncol(mf.PNRauto))
    mf.transitLeg = matrix(mf.transit[toVecIndex(bestInfLotsArray[,,i], FALSE)],nrow(mf.transit),ncol(mf.transit))
    
    #split matrices since mode choice model split into two pieces
    mf.autoLeg = mf.autoLeg[beginrow:endrow,]
    mf.transitLeg = mf.transitLeg[beginrow:endrow,]
    
    #get lot data
    rIndexInf = match(bestInfLotsArray[beginrow:endrow,,i],lottazinf$TAZ)
    lotShadowPriceInf = matrix(lottazinf$SHADOWPRICE[rIndexInf], nFZ, nTZ)

    mf.base = informalConstant + mf.autoLeg + mf.transitLeg + lotShadowPriceInf
    informalUtil.lots[,,i] = (mf.base + cvConstant) / (informalNestCoeff * pnrNestCoeff)
    
    #trace OD
    if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
      cat(paste("\n", "mode split",  paramSet$purpose, "timeper=", timeper, "inc=", inc, "beginrow=", beginrow, "endrow=", endrow), file=loglotChoiceFileName, append=T)
      cat(paste("\n informal lot", i, "\n"), file=loglotChoiceFileName, append=T)
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.autoLeg","mf.transitLeg","mf.base"),loglotChoiceFileName,(beginrow:endrow))
    }
  
  }  
  
  #lot logSums
  formalUtil.lots.logSum = log(apply(formalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T)))
  informalUtil.lots.logSum = log(apply(informalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T)))
  
  #formal and informal lots
  formalUtil = formalNestCoeff * formalUtil.lots.logSum
  informalUtil = informalNestCoeff * informalUtil.lots.logSum
  
  #exp(root utility)
  mf.prtutil = exp(prconst + pnrNestCoeff * log(exp(formalUtil) + exp(informalUtil)))
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    cat("\n", file=loglotChoiceFileName, append=T)
    cat(paste("\n", "mode split",  paramSet$purpose, "timeper=", timeper, "inc=", inc, "beginrow=", beginrow, "endrow=", endrow, "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("prconst", prconst, "\n"), file=loglotChoiceFileName, append=T)
    writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("formalUtil","informalUtil","mf.prtutil"),loglotChoiceFileName,(beginrow:endrow))
  }
  
  #save utilities data structure in order to allocate calculated trips to lots
  objectsToSave = c("formalUtil", "informalUtil","formalUtil.lots","informalUtil.lots")
  if(cv!="") {
    save(list=objectsToSave, file=paste(purpose, '_lot_util_data_', cv, '.', beginrow, '.', endrow, '.RData', sep=""))
  } else {
    save(list=objectsToSave, file=paste(purpose, '_lot_util_data.', beginrow, '.', endrow, '.RData', sep=""))
  }
  print("lot utilities calculated")
  detach(paramSet)
  
  return(mf.prtutil)
  
}

#Allocate trips to PNR and PNH nests and lots
#Ben Stabler, stabler@pbworld.com, 01/15/10
#Updated 01/11/11 BTS to leave tl, td, and select lot matrices as daily PA
allocateTripsToLots = function(trips, project.dir, beginrow, endrow, vehOccFactor, purpose, cv="") {

  print(paste("starting allocating trips to lots -", purpose, cv))

  #load utilities
  if(cv != "") {
    load(paste(purpose, "_lot_util_data_", cv, ".", beginrow, ".", endrow, ".RData", sep=""))
  } else {  
    load(paste(purpose, "_lot_util_data.", beginrow, ".", endrow, ".RData", sep=""))
  }

  #get formal and informal likely lot sets by OD    
  load(paste(project.dir, "model/bestLotsArray.RData", sep="/"))
  load(paste(project.dir, "model/bestInfLotsArray.RData", sep="/"))
  
  #split matrices since mode choice model split into two pieces
  bestLotsArray = bestLotsArray[beginrow:endrow,,]
  bestInfLotsArray = bestInfLotsArray[beginrow:endrow,,]
  
  print("loaded bestLotsArray, bestInfLotsArray")
  
  
  #get pnr trips for income
  #convert person trips to veh trips
  #divide by od factor (default to 2) since 2 PA trips per 1 car
  odFactor = 2
  trips = trips / vehOccFactor #1999 pnr windshield survey veh occ factor
  trips = trips / odFactor
  print("pnr PA trips scaled to vehicle trips")

  #calculate formal and informal probabilities
  formalProb = exp(formalUtil) / (exp(formalUtil) + exp(informalUtil))
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    cat("\n", file=loglotChoiceFileName, append=T)
    cat(paste("\n", "mode split", purpose, "\n"), file=loglotChoiceFileName, append=T)
    writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("formalProb","trips"),loglotChoiceFileName,(beginrow:endrow))
  }
  
  #lot utility sums
  formalUtil.lots.sum = apply(formalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T))
  informalUtil.lots.sum = apply(informalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T))

  #calculate lot probabilities
  formalProb.lots = sweep(exp(formalUtil.lots), c(1,2), formalUtil.lots.sum, "/")
  informalProb.lots = sweep(exp(informalUtil.lots), c(1,2), informalUtil.lots.sum, "/")
  rm(formalUtil.lots.sum,informalUtil.lots.sum, formalUtil, informalUtil, formalUtil.lots, informalUtil.lots)
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    fzIndex = match(lotChoiceTraceOD[1], (beginrow:endrow))
    cat(paste("\n", "mode split", purpose, "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("formalProb.lots[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], ",]:", paste(formalProb.lots[fzIndex,lotChoiceTraceOD[2],], collapse=" "),"\n"), file=loglotChoiceFileName, append=T)
    cat(paste("informalProb.lots[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], ",]:", paste(informalProb.lots[fzIndex,lotChoiceTraceOD[2],], collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
  }
  
  print("calculated lot probabilities")

  #calculate trips by lot - formal and informal
  formalTrips.lots = sweep(formalProb.lots, c(1,2), trips * formalProb, "*")
  informalTrips.lots = sweep(informalProb.lots, c(1,2), trips * (1 - formalProb), "*")
  rm(trips, formalProb,formalProb.lots,informalProb.lots)
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    fzIndex = match(lotChoiceTraceOD[1], (beginrow:endrow))
    cat(paste("\n", "mode split", purpose, "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("formalTrips.lots[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], ",]:", paste(formalTrips.lots[fzIndex,lotChoiceTraceOD[2],], collapse=" "),"\n"), file=loglotChoiceFileName, append=T)
    cat(paste("informalTrips.lots[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], ",]:", paste(informalTrips.lots[fzIndex,lotChoiceTraceOD[2],], collapse=" "),"\n"), file=loglotChoiceFileName, append=T)
  }
  
  #allocate trips to lots and save lot files
  formalTripsByLot = tapply(formalTrips.lots, bestLotsArray, function(x) sum(x,na.rm=T))
  informalTripsByLot = tapply(informalTrips.lots, bestInfLotsArray, function(x) sum(x,na.rm=T))
  
  #mf.h{purpose}prtr{tl,td} matrix
  load(paste("mf.", purpose, "prtrtl.RData", sep=""))
  load(paste("mf.", purpose, "prtrtd.RData", sep=""))
  tl = get(paste("mf.", purpose, "prtrtl", sep=""))
  td = get(paste("mf.", purpose, "prtrtd", sep=""))
  rm(list=c(paste("mf.", purpose, "prtrtl", sep=""), paste("mf.", purpose, "prtrtd", sep="")))
  
  #formal lots
  dims = dim(formalTrips.lots)
  lotTrips = data.frame(FZ=rep((beginrow:endrow),dims[2]*dims[3]),TZ=rep(rep(1:dims[2],each=dims[1]),dims[3]),
    LOT=as.vector(bestLotsArray),TRIPS=as.vector(formalTrips.lots))
  rm(formalTrips.lots)
  tl2 = tapply(lotTrips$TRIPS, list(lotTrips$FZ, lotTrips$LOT), function(x) sum(x, na.rm=T))
  td2 = tapply(lotTrips$TRIPS, list(lotTrips$LOT,lotTrips$TZ), function(x) sum(x, na.rm=T))
  tl2[is.na(tl2)] = 0
  td2[is.na(td2)] = 0
  
  #convert back to daily PA since these are used by peaking
  tl2 = tl2 * odFactor * vehOccFactor 
  td2 = td2 * odFactor * vehOccFactor
  
  for(aLot in colnames(tl2)) {
    tl[beginrow:endrow,as.numeric(aLot)] = tl[beginrow:endrow,as.numeric(aLot)] + tl2[,aLot]
  }
  for(aLot in rownames(td2)) {
    td[as.numeric(aLot),] = td[as.numeric(aLot),] + td2[aLot,]
  }
  rm(tl2, td2)
    
  #select lot matrix
  if(!is.na(selectLotZone)) {
    if(selectLotZone %in% unique(lotTrips$LOT)) {
      load(paste("mf.", purpose, "slmat.RData", sep=""))
      sl = get(paste("mf.", purpose, "slmat", sep=""))
      rm(list=c(paste("mf.", purpose, "slmat", sep="")))
      
      lotTrips = lotTrips[!is.na(lotTrips$LOT),]
      lotTrips = lotTrips[lotTrips$LOT == selectLotZone,]
      lotTrips = tapply(lotTrips$TRIPS, list(lotTrips$FZ, lotTrips$TZ), function(x) sum(x, na.rm=T))
      lotTrips[is.na(lotTrips)] = 0
      
      #convert back to daily PA to be consistent with tl and td
      lotTrips = lotTrips * odFactor * vehOccFactor
      
      tzs = as.numeric(colnames(lotTrips))
      for(aFZ in rownames(lotTrips)) {
        sl[as.numeric(aFZ),tzs] = sl[as.numeric(aFZ),tzs] + lotTrips[aFZ,]
      }

      assign(paste("mf.", purpose, "slmat", sep=""), sl)
      save(list=paste("mf.", purpose, "slmat", sep=""), file=paste("mf.", purpose, "slmat.RData", sep=""))
      rm(list=c("sl", paste("mf.", purpose, "slmat", sep="")))
      print("saved select lot matrix")
    }
  }
  rm(lotTrips)
  
  print("allocated formal trips to tl and td matrices")
  gc(verbose = FALSE)
  
  #informal lots
  dims = dim(informalTrips.lots)
  lotTrips = data.frame(FZ=rep((beginrow:endrow),dims[2]*dims[3]),TZ=rep(rep(1:dims[2],each=dims[1]),dims[3]),
    LOT=as.vector(bestInfLotsArray),TRIPS=as.vector(informalTrips.lots))
  rm(informalTrips.lots)
  tl2 = tapply(lotTrips$TRIPS, list(lotTrips$FZ, lotTrips$LOT), function(x) sum(x, na.rm=T))
  td2 = tapply(lotTrips$TRIPS, list(lotTrips$LOT,lotTrips$TZ), function(x) sum(x, na.rm=T))
  tl2[is.na(tl2)] = 0
  td2[is.na(td2)] = 0
      
  #convert back to daily PA since these are used by peaking
  tl2 = tl2 * odFactor * vehOccFactor 
  td2 = td2 * odFactor * vehOccFactor
  
  for(aLot in colnames(tl2)) {
    tl[beginrow:endrow,as.numeric(aLot)] = tl[beginrow:endrow,as.numeric(aLot)] + tl2[,aLot]
  }
  for(aLot in rownames(td2)) {
    td[as.numeric(aLot),] = td[as.numeric(aLot),] + td2[aLot,]
  }
  rm(tl2, td2)
  
  #select lot matrix
  if(!is.na(selectLotZone)) {
    if(selectLotZone %in% unique(lotTrips$LOT)) {
      load(paste("mf.", purpose, "slmat.RData", sep=""))
      sl = get(paste("mf.", purpose, "slmat", sep=""))
      rm(list=c(paste("mf.", purpose, "slmat", sep="")))
      
      lotTrips = lotTrips[!is.na(lotTrips$LOT),]
      lotTrips = lotTrips[lotTrips$LOT == selectLotZone,]
      lotTrips = tapply(lotTrips$TRIPS, list(lotTrips$FZ, lotTrips$TZ), function(x) sum(x, na.rm=T))
      lotTrips[is.na(lotTrips)] = 0
      
      #convert back to daily PA to be consistent with tl and td
      lotTrips = lotTrips * odFactor * vehOccFactor
      
      tzs = as.numeric(colnames(lotTrips))
      for(aFZ in rownames(lotTrips)) {
        #add lot trips and convert back to daily PA to be consistent with tl and td
        sl[as.numeric(aFZ),tzs] = sl[as.numeric(aFZ),tzs] + lotTrips[aFZ,]
      }
    
      assign(paste("mf.", purpose, "slmat", sep=""), sl)
      save(list=paste("mf.", purpose, "slmat", sep=""), file=paste("mf.", purpose, "slmat.RData", sep=""))
      rm(list=c("sl", paste("mf.", purpose, "slmat", sep="")))
      print("saved select lot matrix")
    }
  }
  rm(lotTrips)
  
  print("allocated informal trips to tl and td matrices")
  
  #save mf.{purpose}prtr{tl,td}
  assign(paste("mf.", purpose, "prtrtl", sep=""), tl)
  assign(paste("mf.", purpose, "prtrtd", sep=""), td)
  save(list=paste("mf.", purpose, "prtrtl", sep=""), file=paste("mf.", purpose, "prtrtl.RData", sep=""))
  save(list=paste("mf.", purpose, "prtrtd", sep=""), file=paste("mf.", purpose, "prtrtd.RData", sep=""))
  rm(list=c("tl", "td", paste("mf.", purpose, "prtrtl", sep=""), paste("mf.", purpose, "prtrtd", sep="")))
  print(paste("saved mf.", purpose, "prtr{tl,td} 'to lot' and 'to destination' matrix", sep=""))
  
  print("allocated trips to lots")
  
  #get lottaz and lottazinf - need to get since may have changed due to multithreading by trip purpose
  load(paste(project.dir, "model/lottaz.RData", sep="/"))
  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  
  print("loaded lottaz, lottazinf")
  
  #add trips by lottaz and lottazinf
  formalTripsByLot = round(formalTripsByLot[match(lottaz$TAZ,names(formalTripsByLot))], 3)
  formalTripsByLot[is.na(formalTripsByLot)] = 0
  names(formalTripsByLot) = lottaz$TAZ
  lottaz$VOLUME = lottaz$VOLUME + formalTripsByLot
  
  informalTripsByLot = round(informalTripsByLot[match(lottazinf$TAZ,names(informalTripsByLot))], 3)
  informalTripsByLot[is.na(informalTripsByLot)] = 0
  names(informalTripsByLot) = lottazinf$TAZ
  lottazinf$VOLUME = lottazinf$VOLUME + informalTripsByLot
  
  #trace lot results
  if(!is.na(lotChoiceTraceOD[1]) & (lotChoiceTraceOD[1] %in% (beginrow:endrow))) {
    cat(paste("\n", "mode split", purpose, "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("\n formalTripsByLot \n"), file=loglotChoiceFileName, append=T)
    write.table(formalTripsByLot, file=loglotChoiceFileName, append=T, col.names=F)
    cat(paste("\n informalTripsByLot \n"), file=loglotChoiceFileName, append=T)
    write.table(informalTripsByLot, file=loglotChoiceFileName, append=T, col.names=F)
    cat(paste("\n lottaz \n"), file=loglotChoiceFileName, append=T)
    cat(paste("\n", paste(colnames(lottaz), collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
    write.table(lottaz, row.names=F, file=loglotChoiceFileName, append=T, col.names=F)
    cat(paste("\n lottazinf \n"), file=loglotChoiceFileName, append=T)
    cat(paste("\n", paste(colnames(lottazinf), collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
    write.table(lottazinf, row.names=F, file=loglotChoiceFileName, append=T, col.names=F)
  }
  
  print("allocation of trips to lots complete")
  
  save(lottaz, file=paste(project.dir, "model/lottaz.RData", sep="/"))
  save(lottazinf, file=paste(project.dir, "model/lottazinf.RData", sep="/"))
  rm(bestLotsArray,bestInfLotsArray,formalTripsByLot,informalTripsByLot,lottaz,lottazinf)
 
  print("lot files saved")

}

#Calculate logsum for PNR and PNH nests for destination choice
#Updated 01/11/11 BTS to move formal and informal lot constants to lowest level to make them easier to manage
calcPNRUtilsDestChoice = function(mf.dautil_pnr, mf.trutil, project.dir, prconst, paramSet) {
 
  #attach paramSet for local referencing
  attach(paramSet)
  
  print(paste("starting lot utilities calculation for dest choice - ", purpose))
    
  #get formal and informal likely lot sets by OD    
  load(paste(project.dir, "model/bestLotsArray.RData", sep="/"))
  load(paste(project.dir, "model/bestInfLotsArray.RData", sep="/"))
  
  #get lottaz and lottazinf - need to get since may have changed due to multithreading by trip purpose
  load(paste(project.dir, "model/lottaz.RData", sep="/"))
  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  
  
  #get dimensions of outputs
  nFZ = nrow(mf.dautil_pnr)
  nTZ = ncol(bestLotsArray)
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1])) {
    cat(paste("\n", "logsum calculation",  paramSet$purpose, "\n"), file=loglotChoiceFileName, append=T)
    capture.output(paramSet, file=loglotChoiceFileName, append=T)
    writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.dautil_pnr","mf.trutil"),loglotChoiceFileName)
    cat(paste("bestLotsArray[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], "]:", paste(bestLotsArray[lotChoiceTraceOD[1],lotChoiceTraceOD[2],], collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("bestInfLotsArray[",lotChoiceTraceOD[1], ",", lotChoiceTraceOD[2], "]:", paste(bestInfLotsArray[lotChoiceTraceOD[1],lotChoiceTraceOD[2],], collapse=" "), "\n"), file=loglotChoiceFileName, append=T)
  }
  
  #loop through formal lots and calculate lot utilities
  formalUtil.lots = array(NA,c(nFZ,nTZ,dim(bestLotsArray)[3]))
  
  for(i in 1:dim(bestLotsArray)[3]) {
    
    #get auto and transit utilities
    mf.autoLeg = matrix(mf.dautil_pnr[toVecIndex(bestLotsArray[,,i])],nrow(mf.dautil_pnr),ncol(mf.dautil_pnr))
    mf.transitLeg = matrix(mf.trutil[toVecIndex(bestLotsArray[,,i], FALSE)],nrow(mf.trutil),ncol(mf.trutil))
    
    mf.base = formalConstant + mf.autoLeg + mf.transitLeg
    formalUtil.lots[,,i] = mf.base / (formalNestCoeff * pnrNestCoeff)
  
    #trace OD
    if(!is.na(lotChoiceTraceOD[1])) {
      cat(paste("\n", "logsum calculation",  paramSet$purpose), file=loglotChoiceFileName, append=T)
      cat(paste("\n formal lot", i, "\n"), file=loglotChoiceFileName, append=T)
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.autoLeg","mf.transitLeg","mf.base"),loglotChoiceFileName)
    }
  
  }
  
  #loop through informal lots and calculate lot utilities
  informalUtil.lots = array(NA,c(nFZ,nTZ,dim(bestInfLotsArray)[3]))
  
  for(i in 1:dim(bestInfLotsArray)[3]) {
  
    #get auto and transit utilities
    mf.autoLeg = matrix(mf.dautil_pnr[toVecIndex(bestInfLotsArray[,,i])],nrow(mf.dautil_pnr),ncol(mf.dautil_pnr))
    mf.transitLeg = matrix(mf.trutil[toVecIndex(bestInfLotsArray[,,i], FALSE)],nrow(mf.trutil),ncol(mf.trutil))
    
    mf.base = informalConstant + mf.autoLeg + mf.transitLeg
    informalUtil.lots[,,i] = mf.base / (informalNestCoeff * pnrNestCoeff)
    
    #trace OD
    if(!is.na(lotChoiceTraceOD[1])) {    
      cat(paste("\n", "logsum calculation",  paramSet$purpose), file=loglotChoiceFileName, append=T)
      cat(paste("\n informal lot", i, "\n"), file=loglotChoiceFileName, append=T)
      writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("mf.autoLeg","mf.transitLeg","mf.base"),loglotChoiceFileName)
    }
  
  }  
  
  #lot logSums
  formalUtil.lots.logSum = log(apply(formalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T)))
  informalUtil.lots.logSum = log(apply(informalUtil.lots, c(1,2), function(x) sum(exp(x), na.rm=T)))
  
  #formal and informal lots
  formalUtil = formalNestCoeff * formalUtil.lots.logSum
  informalUtil = informalNestCoeff * informalUtil.lots.logSum
  
  #exp(root utility)
  mf.prtutil = exp(prconst + pnrNestCoeff * log(exp(formalUtil) + exp(informalUtil)))
  
  #trace OD
  if(!is.na(lotChoiceTraceOD[1])) {
    cat("\n", file=loglotChoiceFileName, append=T)
    cat(paste("\n", "logsum calculation",  paramSet$purpose, "\n"), file=loglotChoiceFileName, append=T)
    cat(paste("prconst", prconst, "\n"), file=loglotChoiceFileName, append=T)
    writeMatrixValue(lotChoiceTraceOD[1],lotChoiceTraceOD[2],c("formalUtil","informalUtil","mf.prtutil"),loglotChoiceFileName)
  }
  
  print("lot utilities calculated for destination choice")
  detach(paramSet)
  return(mf.prtutil)
  
}

#Calculate lot shadow prices
#Ben Stabler, stabler@pbworld.com, 01/15/10
#Updated 01/11/11 BTS to reset lottazinf as well
updateLotShadowPrice = function(iteration) {

  load("../model/lottaz.RData")
  load("../model/lottazinf.RData")
  
  #calculate current shadow price  
  logVC = -1 * log(lottaz$VOLUME/pmax(lottaz$CAPACITY,1))
  logVC[is.infinite(logVC)] = 0
  
  logVCInf = -1 * log(lottazinf$VOLUME/lottazinf$CAPACITY)
  logVCInf[is.infinite(logVCInf)] = 0
  
  #calculate positive shadow price for lots under capacity but with shadow price
  underLots = (lottaz$SHADOWPRICE < 0) & (lottaz$VOLUME < lottaz$CAPACITY) 
  logVC_Under = rep(0, length(lottaz$SHADOWPRICE))
  logVC_Under[underLots] = logVC[underLots]
  
  underLotsInf = (lottazinf$SHADOWPRICE < 0) & (lottazinf$VOLUME < lottazinf$CAPACITY) 
  logVC_UnderInf = rep(0, length(lottazinf$SHADOWPRICE))
  logVC_UnderInf[underLotsInf] = logVCInf[underLotsInf]
  
  #set shadow price
  if(iteration == 0 & !warmStartShadowPricing) {
    lottaz$SHADOWPRICE = pmin(0, logVC) * spDampenInit 
    lottazinf$SHADOWPRICE = pmin(0, logVCInf) * spDampenInit
  } else {
    lottaz$SHADOWPRICE = pmin(0, (lottaz$SHADOWPRICE + (pmin(0, logVC) + logVC_Under) * spDampen))
    lottazinf$SHADOWPRICE = pmin(0, (lottazinf$SHADOWPRICE + (pmin(0, logVCInf) + logVC_UnderInf) * spDampen))
  }
  save(lottaz, file="../model/lottaz.RData")
  save(lottazinf, file="../model/lottazinf.RData")
  
  print("updated lot shadow prices") 
}

#Reset lot volumes
resetLotVolumes = function() {

  load("../model/lottaz.RData")
  load("../model/lottazinf.RData")
  
  print("reset lot volumes") 
  lottaz$VOLUME = 0
  lottazinf$VOLUME = 0
  
  save(lottaz, file="../model/lottaz.RData")
  save(lottazinf, file="../model/lottazinf.RData")
}

#Reset select lot matrix
#Ben Stabler, stabler@pbworld.com, 01/15/10
resetSelectLotMatrix = function(purpose) {
  
  #load select lot matrix
  if(!is.na(selectLotZone)) {
  
    load(paste("mf.", purpose, "slmat.RData", sep=""))
    sl = get(paste("mf.", purpose, "slmat", sep=""))
    
    sl = sl - sl
    
    assign(paste("mf.", purpose, "slmat", sep=""), sl)
    save(list=paste("mf.", purpose, "slmat", sep=""), file=paste("mf.", purpose, "slmat.RData", sep=""))
  }
}

#Reset hbw pnr tl and td matrices
#Ben Stabler, stabler@pbworld.com, 01/15/10
resetTLTDMatrices = function() {
  
  load("mf.hbwprtrtl.RData")
  load("mf.hbwprtrtd.RData")
  mf.hbwprtrtl = mf.hbwprtrtl - mf.hbwprtrtl
  mf.hbwprtrtd = mf.hbwprtrtd - mf.hbwprtrtd
  save(mf.hbwprtrtl, file="mf.hbwprtrtl.RData")
  save(mf.hbwprtrtd, file="mf.hbwprtrtd.RData")
}

#Calculate lot prmse
#Ben Stabler, stabler@pbworld.com, 03/07/10
calcLotPRMSE = function(iteration) {

  #get lot volumes
  load("../model/lottaz.RData")
  
  #get previous volumes
  if(iteration>0) {
    lottazPrevFileName = paste("../model/lottaz_", iteration - 1, ".csv", sep="")
    lottaz_prev = read.csv(lottazPrevFileName)
  
    #calculate prmse based on lottaz
    current = lottaz$VOLUME
    previous = lottaz_prev$VOLUME
    rmse = sqrt( sum((current - previous)^2) / (length(previous)-1) )
    prmse = rmse / (sum(previous) / length(previous))
  } else {
    prmse = "NA"
  }
  return(prmse)
}

#Calculate informal lot prmse
#AAB, 08/04/10
calcInfLotPRMSE = function(iteration) {

  #get lot volumes
  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  
  #get previous volumes
  if(iteration>0) {
    lottazinfPrevFileName = paste(project.dir,"/model/lottazinf_", iteration - 1, ".csv", sep="")
    lottazinf_prev = read.csv(lottazinfPrevFileName)

    lottazinf_current = data.frame(TAZ=sort(as.numeric(lottazinf_prev$TAZ)),CAPACITY=0,VOLUME=0,SHADOWPRICE=0)
    for (i in 1:nrow(lottazinf)) {
      lottazinf_current$TAZ[lottazinf$TAZ[i]] <- lottazinf$TAZ[i]
      lottazinf_current[lottazinf$TAZ[i],] <- lottazinf[i,]
    }

    #calculate prmse based on lottazinf
    current = lottazinf_current$VOLUME
    previous = lottazinf_prev$VOLUME
    rmse = sqrt( sum((current - previous)^2) / (nrow(lottazinf)-1) )
    prmse = rmse / (sum(previous) / nrow(lottazinf))
  } else {
    prmse = "NA"
  }
  return(prmse)
}

#Calculate lot difference and compare to difference target
#Ben Stabler, stabler@pbworld.com, 03/07/10
calcLotDiffTarget = function() {

  #get lot volumes
  load("../model/lottaz.RData")
  
  #calculate if any lots are greater than the acceptable difference
  lottaz = lottaz[lottaz$CAPACITY>0,]
  acceptable_difference = lottaz$DIFFTARGET
  volume = lottaz$VOLUME
  capacity = lottaz$CAPACITY
  sp = lottaz$SHADOWPRICE
  anyOver = any(volume > (capacity + acceptable_difference))
  
  #calculate if any lots are less than the acceptable difference and have shadow price
  anyUnder = any((volume < (capacity - acceptable_difference)) & (sp < 0))
  
  return(anyOver | anyUnder)
}

#Write matrix values to a log file
#Ben Stabler, stabler@pbworld.com, 01/15/10
writeMatrixValue = function(fz,tz,matrixNames,fileName,fromZoneNames=NULL) {
  
  #calc fzIndex to matrix row index based on fromZoneNames
  fzIndex = fz
  if(!is.null(fromZoneNames)) {
    fzIndex = match(fz, fromZoneNames)
  }
  
  f = file(fileName,"at")
  for(m in matrixNames) {
    writeLines(paste(m, "[", fz, ",", tz, "]: ", get(m, pos=parent.frame())[fzIndex,tz], sep=""), f)
  }
  close(f)
}

#Calculate formal lot shadow prices for non-HBW purposes
#AAB, 04/05/11
finalLotShadowPrice = function() {

  #get lot volumes
  load(paste(project.dir,"model/lottaz.RData",sep="/"))
  write.csv(lottaz, paste(project.dir,"model/lottaz_in_forNextIter.csv",sep="/"), row.names=F)

  load(paste(project.dir, "model/lottazinf.RData", sep="/"))
  lots_inf = readXLSXmatrix(proj.inputs,"lots_inf",lotsmtx=T)
  lottazinf_all_lots <- lots_inf
  for (i in 1:nrow(lottazinf)) {
    lottazinf_all_lots$TAZ[lottazinf$TAZ[i]] <- lottazinf$TAZ[i]
    lottazinf_all_lots[lottazinf$TAZ[i],] <- lottazinf[i,]
  }
  write.csv(lottazinf_all_lots, paste(project.dir,"model/lottazinf_in_forNextIter.csv",sep="/"), row.names=F)

  #determine which lots are effectively at or above capacity after HBW
  capThreshold = 0.8
  fullLots = ((lottaz$VOLUME / lottaz$CAPACITY) > capThreshold)
  
  #increase non-HBW shadow price for full lots
  lottaz$SHADOWPRICE[fullLots] = lottaz$SHADOWPRICE[fullLots] - 2
  save(lottaz, file="../model/lottaz.RData")
}

#Load bike distance
#AAB, 11/16/11
load_bike_dist<-function(bike_dir,bikepurp,numzones){

  dataList <- read.csv(paste(bike_dir, "/BikeSkim", bikepurp, ".txt", sep=""),sep=",",header=F)
  bdist <- t(array(dataList[,4], dim=c(numzones,numzones)))
  return(bdist)
}

#Load bike cost
#AAB, 11/16/11
load_bike_cost<-function(bike_dir,bikepurp,numzones){

  #load text file with bike network utilities
  dataList <- read.csv(paste(bike_dir, "/BikeSkim", bikepurp, ".txt", sep=""),sep=",",header=F)
  butil <- t(array(dataList[,3], dim=c(numzones,numzones)))
  
  #retain worst of utilities for both directions to represent daily journey
  bcost <- pmin(butil, t(butil))

  #prohibit relative worsening of utility due to change in path choice (optional)
  if(prohib_worse_bike_util) {
    #load text file with reference scenario bike network utilities
    dataList <- read.csv(paste(bike_dir_ref, "/BikeSkim", bikepurp, ".txt", sep=""),sep=",",header=F)
    butil <- t(array(dataList[,3], dim=c(numzones,numzones)))
  
    #retain worst of utilities for both directions to represent daily journey
    bcost_ref <- pmin(butil, t(butil))

    bcost[bcost<bcost_ref] <- bcost_ref[bcost<bcost_ref]  
  }
  return(bcost)
}

#Load shortest path bike distance
#AAB, 11/16/11
load_util_dist<-function(bike_dir,numzones){

  dataList <- read.csv(paste(bike_dir, "shortestPathDist.CSV", sep="/"),sep=",",header=F)
  ubdist <- t(array(dataList[,3], dim=c(numzones,numzones)))
  return(ubdist)
}



emmeBASH <- function(emmebankLocation,syntax) {
#  Function to write and execute a temporary BASH script for running Emme macros from a Cygwin command line
#  Definition of variables called in function:
#      emmebankLocation : directory location containing Emme bank for which to run macro (includes name of Emme bank)
#      syntax           : command to execute in Emme, including macros
#   Example:
#      > emmeBASH(bank, "Emme -ng -m run_all_skims")
  emmeDir <- sub("\\/emmebank","",emmebankLocation)
  changeDir <- paste("(cd ",emmeDir,"; ",sep='')
  write("#! /bin/sh", file = "emmeBASH.sh")
  write(paste(changeDir,syntax,")",sep=''), file = "emmeBASH.sh", append = T)
  system("dos2unix ./emmeBASH.sh")
  shell("bash emmeBASH.sh")
  shell("del emmeBASH.sh")
}

emmeBASHpeak <- function(emmebankLocation,syntax) {
#  Function to write and execute a temporary BASH script for running Emme macros from a Cygwin command line
#  Contains additional statement to change directory after running...meant for peaking programs
#  Definition of variables called in function:
#      emmebankLocation : directory location containing Emme bank for which to run macro (includes name of Emme bank)
#      syntax           : command to execute in Emme, including macros
#   Example:
#      > emmeBASH(assignbank, "Emme -ng -m travelTimeDiff_plots")
  emmeDir <- sub("\\/emmebank","",emmebankLocation)
  changeDir <- paste("(cd ",emmeDir,"; ",sep='')
  write("#! /bin/sh", file = "emmeBASH.sh")
  write(paste(changeDir,syntax,")",sep=''), file = "emmeBASH.sh", append = T)
  write("(cd ..)", file = "emmeBASH.sh", append = T)
  system("dos2unix ./emmeBASH.sh")
  shell("bash emmeBASH.sh")
  shell("del emmeBASH.sh")
}
