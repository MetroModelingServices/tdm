#k.nhw_ModeChoice.R

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }

purpose_mc <- "nhw"
stage      <- "ModeChoice"
source(paste(R.path, "k.matrices_in_stage.R", sep='/'))

source(paste(R.path, "k.nhwms.R", sep='/'))

if (file.access("nhwms.rpt", mode=0) == 0) {system("rm nhwms.rpt")}
modes <- c('da', 'dp', 'pa', 'tr', 'bike', 'walk')
for (mde in 1:length(modes)) {
  assign(paste("mf.nhw",modes[mde],sep=''), get(paste("mf.nhw",modes[mde],".pk",sep='')) + get(paste("mf.nhw",modes[mde],".op",sep='')))
  distsum(paste("mf.nhw",modes[mde],sep=''), paste("nhw",modes[mde],"trips",sep=' '), "ga", 3, "nhwms", project, initials)
}


# If fileCleanup and not MCE, clean up the files
# Otherwise, cleanup will be done at the end of the
# model run
if ((finalCleanup==TRUE) && (mce==FALSE)) {
  source(paste(R.path, "k.finalCleanup.R", sep='/'))
}
