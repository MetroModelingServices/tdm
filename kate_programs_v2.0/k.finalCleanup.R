# k.finalCleanup.R
# PGB 9/2014
# This program looks for a list of files containing specified 'patterns' and
# then deletes the files from disk. To add/remove target files, edit the
# listFiles list of file names/patterns.

listFiles <-c(dir("./",pattern="mf.auto"),
              dir("./",pattern="mf.PNR"),
              dir("./",pattern="mf.transit"),
              dir("./",pattern="lot_util_data"),
              dir("./",pattern="am.dat"),
              dir("./",pattern="md.dat"),
              dir("./",pattern="ls.dat"),
              dir("./",pattern="lsl.dat"),
              dir("./",pattern="lsm.dat"),
              dir("./",pattern="lsh.dat"))

if (length(listFiles) > 0) {
  for (i in 1:length(listFiles)) {
    system(paste("rm ",listFiles[i],sep=''))
  }
}

listFiles <-c(dir("./",pattern="output"))

if (length(listFiles) > 0) {
  for (i in 1:length(listFiles)) {
    system(paste("rm ",listFiles[i],sep=''))
  }
}
