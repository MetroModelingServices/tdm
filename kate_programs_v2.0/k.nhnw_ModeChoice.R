#k.nhnw_ModeChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

purpose_mc <- "nhnw"
stage      <- "ModeChoice"
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.nhnwms.R", sep='/'))

if (file.access("nhnwms.rpt", mode=0) == 0) {system("rm nhnwms.rpt")}
modes <- c('da', 'dp', 'pa', 'tr', 'bike', 'walk')
for (mde in 1:length(modes)) {
  assign(paste("mf.nhnw",modes[mde],sep=''), get(paste("mf.nhnw",modes[mde],".pk",sep='')) + get(paste("mf.nhnw",modes[mde],".op",sep='')))
  distsum1(paste("mf.nhnw",modes[mde],sep=''), paste("nhnw",modes[mde],"trips",sep=' '), "ga", 3, "nhnwms", project, initials)
}


# If fileCleanup and not market, clean up the files
# Otherwise, cleanup will be done at the end of the
# model run
if ((finalCleanup==TRUE) && (mce==FALSE)) {
  source(paste(R.path, "k.finalCleanup.R", sep='/'))
}
