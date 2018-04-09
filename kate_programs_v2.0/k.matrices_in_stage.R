#k.matrices_in_stage.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

# Load vectors

if (stage=="Generation"){  
  mf.hia        <- readXLSXmatrix(proj.inputs,"hia")
  ma.hh         <- apply(mf.hia,1,sum)
  
  ma.aer        <- readXLSXvector(proj.inputs,"aer")
  ma.amf        <- readXLSXvector(proj.inputs,"amf")
  ma.con        <- readXLSXvector(proj.inputs,"con")
  ma.edu        <- readXLSXvector(proj.inputs,"edu")
  ma.fsd        <- readXLSXvector(proj.inputs,"fsd")
  ma.gov        <- readXLSXvector(proj.inputs,"gov")
  ma.hss        <- readXLSXvector(proj.inputs,"hss")
  ma.mfg        <- readXLSXvector(proj.inputs,"mfg")
  ma.mht        <- readXLSXvector(proj.inputs,"mht")
  ma.osv        <- readXLSXvector(proj.inputs,"osv")
  ma.pbs        <- readXLSXvector(proj.inputs,"pbs")
  ma.rcs        <- readXLSXvector(proj.inputs,"rcs")
  ma.twu        <- readXLSXvector(proj.inputs,"twu")
  ma.wt         <- readXLSXvector(proj.inputs,"wt")

  ma.totemp     <- ma.aer + ma.amf + ma.con + ma.edu + ma.fsd + ma.gov + ma.hss + ma.mfg + ma.mht + ma.osv + ma.pbs + ma.rcs + ma.twu + ma.wt

  ma.sfp        <- readXLSXvector(proj.inputs,"sfp")
  ma.enroll     <- readXLSXvector(proj.inputs,"enroll")

  # Needed for k.costCalibration.R
  ma.ltpkg      <- readXLSXvector(proj.inputs,"ltpkg")
  ma.stpkg      <- readXLSXvector(proj.inputs,"stpkg")
}

if (stage=="DestChoice"){
  mf.hia        <- readXLSXmatrix(proj.inputs,"hia")
  ma.hh         <- apply(mf.hia,1,sum)

  ma.aer        <- readXLSXvector(proj.inputs,"aer")
  ma.amf        <- readXLSXvector(proj.inputs,"amf")
  ma.con        <- readXLSXvector(proj.inputs,"con")
  ma.edu        <- readXLSXvector(proj.inputs,"edu")
  ma.fsd        <- readXLSXvector(proj.inputs,"fsd")
  ma.gov        <- readXLSXvector(proj.inputs,"gov")
  ma.hss        <- readXLSXvector(proj.inputs,"hss")
  ma.mfg        <- readXLSXvector(proj.inputs,"mfg")
  ma.mht        <- readXLSXvector(proj.inputs,"mht")
  ma.osv        <- readXLSXvector(proj.inputs,"osv")
  ma.pbs        <- readXLSXvector(proj.inputs,"pbs")
  ma.rcs        <- readXLSXvector(proj.inputs,"rcs")
  ma.twu        <- readXLSXvector(proj.inputs,"twu")
  ma.wt         <- readXLSXvector(proj.inputs,"wt")

  ma.totemp     <- ma.aer + ma.amf + ma.con + ma.edu + ma.fsd + ma.gov + ma.hss + ma.mfg + ma.mht + ma.osv + ma.pbs + ma.rcs + ma.twu + ma.wt

  ma.enroll     <- readXLSXvector(proj.inputs,"enroll")
  ma.actva      <- readXLSXvector(proj.inputs,"actva")
  ma.parka      <- readXLSXvector(proj.inputs,"parka")
  ma.ltpkg      <- readXLSXvector(proj.inputs,"ltpkg")
  ma.stpkg      <- readXLSXvector(proj.inputs,"stpkg")
  ma.auov       <- readXLSXvector(proj.inputs,"auov")
  ma.caninf     <- readXLSXvector(proj.inputs,"caninf")
  ma.canpnr     <- ma.ltpkg            # calculate attraction zones where PnR mode can be used
  ma.canpnr[ma.canpnr[] > 0] <- 1  # any zone with long term parking cost
}

if (stage=="ModeChoice"){
  ma.ltpkg      <- readXLSXvector(proj.inputs,"ltpkg")
  ma.stpkg      <- readXLSXvector(proj.inputs,"stpkg")
  ma.auov       <- readXLSXvector(proj.inputs,"auov")
  ma.pkhhcov    <- (ma.auov * 0) + 1 # temp set to a vector with values of 1
  ma.ophhcov    <- (ma.auov * 0) + 1 # temp set to a vector with values of 1
  ma.pkempcov   <- (ma.auov * 0) + 1 # temp set to a vector with values of 1
  ma.opempcov   <- (ma.auov * 0) + 1 # temp set to a vector with values of 1
  ma.caninf     <- readXLSXvector(proj.inputs,"caninf")
  ma.canpnr     <- ma.ltpkg          # calculate attraction zones where PnR mode can be used
  ma.canpnr[ma.canpnr[] > 0] <- 1  # any zone with long term parking cost
}

ma.inthm <- readXLSXvector(proj.inputs,"inthm")


###################################################################

# Load matrices

if (stage=="Generation"){
  mf.wdist       <- readEmme(bank,"mfwdist")
  mf.wtime       <- mf.wdist/3 * 60  # convert walk distance to minutes assuming 3mph walk speed
  mf.mdtbiv      <- readEmme(bank,"mfmdbiv")
  mf.mdtliv      <- readEmme(bank,"mfmdliv")
  mf.mdtriv      <- readEmme(bank,"mfmdriv")
  mf.mdtsciv     <- readEmme(bank,"mfmdsciv")
  mf.mdtbriv     <- readEmme(bank,"mfmdbriv")
  mf.mdtwalk     <- readEmme(bank,"mfmdwalk")
  mf.mdtwt1      <- readEmme(bank,"mfmdwt1")
  mf.mdtwt2      <- readEmme(bank,"mfmdwt2")

  # Needed for k.costCalibration.R
  mf.trfare.mhi  <- get(load(transit_fares))    # transit fares for mid- and high-income
  mf.trfare.li   <- get(load(transit_fares_li)) # transit fares for low-income
  mf.trfare      <- mf.trfare.mhi               # default transit fare
}

if (stage=="DestChoice" || stage=="ModeChoice" ){
  mf.amstt       <- readEmme(bank,"mfam2stt")
  mf.amhtt       <- readEmme(bank,"mfam2htt")
  mf.mdstt       <- readEmme(bank,"mfmd1stt")
  mf.mdhtt       <- readEmme(bank,"mfmd1htt")

  if (toll==TRUE) {
    mf.amstl     <- readEmme(bank,"mfam2stl")
    mf.amhtl     <- readEmme(bank,"mfam2htl")
    mf.mdstl     <- readEmme(bank,"mfmd1stl")
    mf.mdhtl     <- readEmme(bank,"mfmd1htl")
  }

  mf.amtbiv      <- readEmme(bank,"mfambiv")
  mf.amtliv      <- readEmme(bank,"mfamliv")
  mf.amtriv      <- readEmme(bank,"mfamriv")
  mf.amtsciv     <- readEmme(bank,"mfamsciv")
  mf.amtbriv     <- readEmme(bank,"mfambriv")
  mf.amtwalk     <- readEmme(bank,"mfamwalk")
  mf.amtwt1      <- readEmme(bank,"mfamwt1")
  mf.amtwt2      <- readEmme(bank,"mfamwt2")
  mf.amtxfr      <- readEmme(bank,"mfamxfr")
  mf.amtvehc     <- readEmme(bank,"mfamvehc")
  mf.amtstpc     <- readEmme(bank,"mfamstpc")

  mf.mdtbiv      <- readEmme(bank,"mfmdbiv")
  mf.mdtliv      <- readEmme(bank,"mfmdliv")
  mf.mdtriv      <- readEmme(bank,"mfmdriv")
  mf.mdtsciv     <- readEmme(bank,"mfmdsciv")
  mf.mdtbriv     <- readEmme(bank,"mfmdbriv")
  mf.mdtwalk     <- readEmme(bank,"mfmdwalk")
  mf.mdtwt1      <- readEmme(bank,"mfmdwt1")
  mf.mdtwt2      <- readEmme(bank,"mfmdwt2")
  mf.mdtxfr      <- readEmme(bank,"mfmdxfr")
  mf.mdtvehc     <- readEmme(bank,"mfmdvehc")
  mf.mdtstpc     <- readEmme(bank,"mfmdstpc")

  mf.tdist       <- readEmme(bank,"mftdist")
  mf.wdist       <- readEmme(bank,"mfwdist")
  mf.wtime       <- mf.wdist/3 * 60  # convert walk distance to minutes assuming 3mph walk speed

  mf.trfare.mhi  <- get(load(transit_fares))    # transit fares for mid- and high-income
  mf.trfare.li   <- get(load(transit_fares_li)) # transit fares for low-income
  mf.trfare      <- mf.trfare.mhi               # default transit fare

  mf.orwa        <- get(load(paste(misc_dir, "mf.orwa.dat", sep='/')))
  mf.waor        <- get(load(paste(misc_dir, "mf.waor.dat", sep='/')))
  mf.we          <- get(load(paste(misc_dir, "mf.we.dat",   sep='/')))
  mf.ew          <- get(load(paste(misc_dir, "mf.ew.dat",   sep='/')))
  mf.wh2e        <- get(load(paste(misc_dir, "mf.wh2e.dat", sep='/')))
  mf.e2wh        <- get(load(paste(misc_dir, "mf.e2wh.dat", sep='/')))
  mf.inbike      <- get(load(paste(misc_dir, "mf.inbike.dat", sep='/')))

  mf.cbdist      <- load_bike_dist(bike_dir,"C",numzones)[1:numzones,1:numzones]
  mf.cbcost      <- load_bike_cost(bike_dir,"C",numzones)[1:numzones,1:numzones]
  mf.nbdist      <- load_bike_dist(bike_dir,"NC",numzones)[1:numzones,1:numzones]
  mf.nbcost      <- load_bike_cost(bike_dir,"NC",numzones)[1:numzones,1:numzones]
  mf.ubdist      <- load_util_dist(bike_dir,numzones)[1:numzones,1:numzones]
}

if (mce) {
  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_transit_fares.omx",sep='')

  if(!file.exists(omxFileName)){
    create_omx(omxFileName, numzones, numzones, 7)

    write_omx(file=omxFileName,
              matrix=mf.trfare.mhi,
              name="mf.trfare.mhi",,
              replace=TRUE)

    write_omx(file=omxFileName,
              matrix=mf.trfare.li,
              name="mf.trfare.li",
              replace=TRUE)

    write_omx(file=omxFileName,
              matrix=mf.trfare,
              name="mf.trfare",
              replace=TRUE)
  }

  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_parking_costs.omx",sep='')

  if(!file.exists(omxFileName)){
    create_omx(omxFileName, numzones, numzones, 7)

    write_omx(file=omxFileName,
              matrix=ma.ltpkg,
              name="ma.ltpkg",
              replace=TRUE)

    write_omx(file=omxFileName,
              matrix=ma.stpkg,
              name="ma.stpkg",
              replace=TRUE)
  }
}

source(paste(R.path, "k.costCalibration.R", sep='/'))
source(paste(R.path, "k._constants_coefficients.R", sep='/'))
source(paste(R.path, "k.ens_in.R", sep='/'))
source(paste(R.path, "distsum.R", sep='/'))
source(paste(R.path, "distsum1.R", sep='/'))
