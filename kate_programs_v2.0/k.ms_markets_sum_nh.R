# k.ms_markets_sum_nh.R
# Non-home trip tables are not produced with market segmentations
# This file will create market segmented P->A files for the Non-home trip purposes
# All markets are determined from HBW and HBO/R/S P->A tables
# Requires that market segmentation has been set to TRUE for all trip purposes and
#   that all home-based trip purposes have already been run with segmentation

if (length(commandArgs(TRUE)) > 0) { source(commandArgs()[length(commandArgs())]) }
sink("./logs/nh_mce_report.log", append = FALSE, type = c("output", "message"))
options(warn=-1)

print("Calculating non-home market segmentation files")

# Load all full matrices for HBW, HBO, HBR, HBS, and NH trip purposes
# Define HB trip purposes
trippurps <- c('hw', 'ho', 'hr', 'hs')
modes     <- c('da', 'dp', 'pa', 'tr', 'bike', 'walk')
cval      <- c('cv0', 'cv1', 'cv23')
income    <- c('l', 'm', 'h')
tod       <- c('pk', 'op')

for (trip in 1:length(trippurps))     { # trip purpose loop
  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_",trippurps[trip],".omx",sep='')
  for (mde in 1:length(modes))        { # mode loop
    for (td in 1:length(tod))         { # time of day loop
      for (cvl in 1:length(cval))     { # cval loop
        for (inc in 1:length(income)) { # income loop
          omxMatrixName <- paste("mf.",trippurps[trip],modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')
          assign(paste("mf.",trippurps[trip],modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
                 read_omx(omxFileName, omxMatrixName))
        }
      }
          omxMatrixName <- paste("mf.",trippurps[trip],modes[mde],".",tod[td],sep='')
          assign(paste("mf.",trippurps[trip],modes[mde],".",tod[td],sep=''),
                 read_omx(omxFileName, omxMatrixName))
    }
  }
}

# Define NH trip purposes
for (mde in 1:length(modes))  { # mode loop
  for (td in 1:length(tod))   { # time of day loop
    omxFileName   <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_nhw.omx",sep='')
    omxMatrixName <- paste("mf.nhw",modes[mde],".",tod[td],sep='')
    assign(paste("mf.nhw",modes[mde],".",tod[td],sep=''),
           read_omx(omxFileName, omxMatrixName))

    omxFileName   <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_nhnw.omx",sep='')
    omxMatrixName <- paste("mf.nhnw",modes[mde],".",tod[td],sep='')
    assign(paste("mf.nhnw",modes[mde],".",tod[td],sep=''),
           read_omx(omxFileName, omxMatrixName))
  }
}

# Aggregate all HBO/R/S trips into single tables by mode, cval, income, and time of day
for (mde in 1:length(modes))      { # mode loop
  for (cvl in 1:length(cval))     { # cval loop
    for (inc in 1:length(income)) { # income loop
      for (td in 1:length(tod))   { # time of day loop
        assign(paste("mf.other",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
           get(paste("mf.ho",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')) +
           get(paste("mf.hr",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')) +
           get(paste("mf.hs",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')))
      }
    }
  }
}


# Aggregate all HBO/R/S trips into single tables by mode and time of day
for (mde in 1:length(modes)) { # mode loop
  for (td in 1:length(tod))  { # time of day loop
    assign(paste("mf.other",modes[mde],".",tod[td],sep=''),
       get(paste("mf.ho",modes[mde],".",tod[td],sep='')) +
       get(paste("mf.hr",modes[mde],".",tod[td],sep='')) +
       get(paste("mf.hs",modes[mde],".",tod[td],sep='')))
  }
}


# Calculate percentage of attraction end of HBW and OTHER markets and
# use those values to determine NHW and NHNW market tables

for (mde in 1:length(modes))      { # mode loop
  for (cvl in 1:length(cval))     { # cval loop
    for (inc in 1:length(income)) { # income loop
      for (td in 1:length(tod))   { # time of day loop
        # Calculate percent of market of total at each attraction zone
        percent_hbw_attr <- apply(get(paste("mf.hw",   modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')),2,sum) /
                            apply(get(paste("mf.hw",   modes[mde],".",tod[td],sep='')),2,sum)
        percent_oth_attr <- apply(get(paste("mf.other",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')),2,sum) /
                            apply(get(paste("mf.other",modes[mde],".",tod[td],sep='')),2,sum)

        percent_hbw_attr[percent_hbw_attr[]=="NaN"] <- 0
        percent_oth_attr[percent_oth_attr[]=="NaN"] <- 0

        # Transpose vectors produced above
        t_percent_hbw_attr <- t(percent_hbw_attr)
        t_percent_oth_attr <- t(percent_oth_attr)

        # Multiply transposed percent tables against appropriate NH table to produce markets
        assign(paste("mf.nhw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
         sweep(get(paste("mf.nhw",modes[mde],".",tod[td],sep='')),1,t_percent_hbw_attr,FUN="*"))

        assign(paste("mf.nhnw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
         sweep(get(paste("mf.nhnw",modes[mde],".",tod[td],sep='')),1,t_percent_oth_attr,FUN="*"))

#        save(list=paste("mf.nhw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''), file=paste(project.dir,"/model/mf.nhw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],".dat",sep=''))
#        save(list=paste("mf.nhnw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''), file=paste(project.dir,"/model/mf.nhnw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],".dat",sep=''))

        omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_nhw.omx",sep='')
        write_omx(file=omxFileName,
                  matrix=get(paste("mf.nhw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')),
                  name=paste("mf.nhw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
                  replace=TRUE)

        omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_nhnw.omx",sep='')
        write_omx(file=omxFileName,
                  matrix=get(paste("mf.nhnw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep='')),
                  name=paste("mf.nhnw",modes[mde],".",cval[cvl],".",income[inc],".",tod[td],sep=''),
                  replace=TRUE)
      }
    }
  }
}

print("File cleanup")

listFiles <-c(dir(paste(project.dir,"/model_nh",sep=''),pattern="ls.dat"))

if (length(listFiles) > 0) {
  for (i in 1:length(listFiles)) {
    system(paste("rm ",listFiles[i],sep=''))
  }
}
