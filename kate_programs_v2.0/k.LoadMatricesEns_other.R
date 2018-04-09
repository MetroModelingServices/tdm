#k.LoadMatricesEns_other.R

mf.hia    <- readXLSXmatrix(proj.inputs,"hia")
mf.mdhtt  <- readEmme(bank,"mfmd1htt")
mf.wdist  <- readEmme(bank,"mfwdist")
mf.ubdist <- load_util_dist(bike_dir,numzones)[1:numzones,1:numzones]
mf.amtwt1 <- readEmme(bank,"mfamwt1")

source(paste(R.path, "k.ens_in.R", sep='/'))
source(paste(R.path, "distsum.R", sep='/'))
gc(verbose=FALSE)
