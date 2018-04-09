#k.schms.R
##SCHOOL Mode Choice
#Calculates mode split proportions

#############################################################
#  Bring in ga ensemble: 8 district Lookup                  #
#############################################################

zones <- vector()
for (i in 1:numzones) {
  zones [i] <- i
}

dist157zones <- zones [ensemble.ga==1 | ensemble.ga==5 | ensemble.ga==7]
dist23zones <- zones [ensemble.ga==2 | ensemble.ga==3]
dist46zones <- zones [ensemble.ga==4 | ensemble.ga==6]
dist8zones <- zones [ensemble.ga==8]

#############################################################
#  Initialize Matrices                                     ##
#############################################################
mf.schveh<-matrix(0,numzones,numzones)
mf.schpas<-matrix(0,numzones,numzones)
mf.schtr<-matrix(0,numzones,numzones)
mf.schwalk<-matrix(0,numzones,numzones)
mf.schbike<-matrix(0,numzones,numzones)
mf.schbus<-matrix(0,numzones,numzones)

#############################################################
#  Calculate Home-Based School modesplit                    #
#############################################################

##  City School Trips
mf.schveh[dist157zones,dist157zones]  <- mf.schdt[dist157zones,dist157zones] * 0.2372
mf.schpas[dist157zones,dist157zones]  <- mf.schdt[dist157zones,dist157zones] * 0.3601
mf.schtr[dist157zones,dist157zones]   <- mf.schdt[dist157zones,dist157zones] * 0.0558
mf.schwalk[dist157zones,dist157zones] <- mf.schdt[dist157zones,dist157zones] * 0.1953
mf.schbike[dist157zones,dist157zones] <- mf.schdt[dist157zones,dist157zones] * 0.0735
mf.schbus[dist157zones,dist157zones]  <- mf.schdt[dist157zones,dist157zones] * 0.0781

##  East Suburb School Trips
mf.schveh[dist46zones,dist46zones]  <- mf.schdt[dist46zones,dist46zones] * 0.1875
mf.schpas[dist46zones,dist46zones]  <- mf.schdt[dist46zones,dist46zones] * 0.3254
mf.schtr[dist46zones,dist46zones]   <- mf.schdt[dist46zones,dist46zones] * 0.0123
mf.schwalk[dist46zones,dist46zones] <- mf.schdt[dist46zones,dist46zones] * 0.1310
mf.schbike[dist46zones,dist46zones] <- mf.schdt[dist46zones,dist46zones] * 0.0187
mf.schbus[dist46zones,dist46zones]  <- mf.schdt[dist46zones,dist46zones] * 0.3251

##  West Suburb School Trips
mf.schveh[dist23zones,dist23zones]  <- mf.schdt[dist23zones,dist23zones] * 0.2256
mf.schpas[dist23zones,dist23zones]  <- mf.schdt[dist23zones,dist23zones] * 0.3048
mf.schtr[dist23zones,dist23zones]   <- mf.schdt[dist23zones,dist23zones] * 0.0027
mf.schwalk[dist23zones,dist23zones] <- mf.schdt[dist23zones,dist23zones] * 0.1261
mf.schbike[dist23zones,dist23zones] <- mf.schdt[dist23zones,dist23zones] * 0.0086
mf.schbus[dist23zones,dist23zones]  <- mf.schdt[dist23zones,dist23zones] * 0.3322

##  Clark County School Trips
mf.schveh[dist8zones,dist8zones]  <- mf.schdt[dist8zones,dist8zones] * 0.2214
mf.schpas[dist8zones,dist8zones]  <- mf.schdt[dist8zones,dist8zones] * 0.3139
mf.schtr[dist8zones,dist8zones]   <- mf.schdt[dist8zones,dist8zones] * 0.0033
mf.schwalk[dist8zones,dist8zones] <- mf.schdt[dist8zones,dist8zones] * 0.0682
mf.schbike[dist8zones,dist8zones] <- mf.schdt[dist8zones,dist8zones] * 0.0122
mf.schbus[dist8zones,dist8zones]  <- mf.schdt[dist8zones,dist8zones] * 0.3810

if (mce) {
  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_sch.omx",sep='')
  create_omx(omxFileName, numzones, numzones, 7)

  purp <- c("veh", "pas", "tr", "walk", "bike", "bus")
  for (p in 1:length(purp)) {
    write_omx(file=omxFileName,
              matrix=get(paste("mf.sch",purp[p],sep='')),
              name=paste("mf.sch",purp[p],sep=''),
              replace=TRUE)
  }
}

if (file.access("schms.rpt", mode=0) == 0) {system ("rm schms.rpt")}

distsum ("mf.schveh", "School Vehicle Trips", "ga", 3, "schms", project, initials)
distsum ("mf.schpas", "School Passenger Trips", "ga", 3, "schms", project, initials)
distsum ("mf.schtr", "School Transit Trips", "ga", 3, "schms", project, initials)
distsum ("mf.schwalk", "School Walk Trips", "ga", 3, "schms", project, initials)
distsum ("mf.schbike", "School Bike Trips", "ga", 3, "schms", project, initials)
distsum ("mf.schbus", "School Bus Trips", "ga", 3, "schms", project, initials)

