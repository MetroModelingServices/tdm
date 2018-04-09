source("./k.model_setup.R")

source(paste(R.path, "k.ens_in.R", sep='/'))
source(paste(R.path, "distsum.R", sep='/'))

mf.pm2skims  <- readEmme(bank,"mfpm2sov")
mf.pm2assign <- readEmme(assignbank,"mfpm2sov")
mf.pm2diff   <- mf.pm2assign - mf.pm2skims

distsum("mf.pm2diff", "mf.pm2assign - mf.pm2skims", "ga", 3, "tripTablesInOut.txt", project, initials)
distsum("mf.pm2assign", "mf.pm2assign", "ga", 3, "tripTablesInOut.txt", project, initials)
distsum("mf.pm2skims", "mf.pm2skims", "ga", 3, "tripTablesInOut.txt", project, initials)
