#k.matrices_in_pnr.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

ma.ltpkg       <- readXLSXvector(proj.inputs,"ltpkg")
ma.stpkg       <- readXLSXvector(proj.inputs,"stpkg")
ma.caninf      <- readXLSXvector(proj.inputs,"caninf")
ma.canpnr      <- ma.ltpkg            # calculate attraction zones where PnR mode can be used
ma.canpnr[ma.canpnr[] > 0] <- 1   # any zone with long term parking cost

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

load("ma.mixrhm.dat")
load("ma.mixthm.dat")
source(paste(R.path, "k.costCalibration.R", sep='/'))
source(paste(R.path, "k._constants_coefficients.R", sep='/'))
source(paste(R.path, "k.ens_in.R", sep='/'))
source(paste(R.path, "distsum.R", sep='/'))
source(paste(R.path, "distsum1.R", sep='/'))
