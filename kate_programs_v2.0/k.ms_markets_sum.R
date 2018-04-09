# k.ms_markets_sum.R
# This file will create time of day market segmented P->A files for the HBW, HBC, HBO, HBR, and HBS trip purposes
# Requires purpose_mc variable be defined prior to calling

print(paste("Reading ",purpose_mc," market segmentation files",sep=''))

## Sum matrix data by AM and MD for DA, DP, PA, TR, PRTR, BIKE, and WALK

modes <- c('da', 'dp', 'pa', 'tr', 'prtr', 'bike', 'walk')

if (mce) { 
  omxFileName <- paste(project.dir,"/_mceInputs/",project,"_",year,"_",alternative,"_mode_choice_pa_",purpose_mc,".omx",sep='')
  create_omx(omxFileName, numzones, numzones, 7)
}



for (mde in 1:length(modes)) {
  assign(paste("mf.",purpose_mc,modes[mde],".pk",sep=''),
     get(paste("mf.",purpose_mc,modes[mde],".l.am",sep='')) +
     get(paste("mf.",purpose_mc,modes[mde],".m.am",sep='')) +
     get(paste("mf.",purpose_mc,modes[mde],".h.am",sep='')))

  assign(paste("mf.",purpose_mc,modes[mde],".op",sep=''),
     get(paste("mf.",purpose_mc,modes[mde],".l.md",sep='')) +
     get(paste("mf.",purpose_mc,modes[mde],".m.md",sep='')) +
     get(paste("mf.",purpose_mc,modes[mde],".h.md",sep='')))

  save(list=paste("mf.",purpose_mc,modes[mde],".pk",sep=''),
       file=paste(project.dir,"/model/mf.",purpose_mc,modes[mde],".pk.dat",sep=''))

  save(list=paste("mf.",purpose_mc,modes[mde],".op",sep=''), 
       file=paste(project.dir,"/model/mf.",purpose_mc,modes[mde],".op.dat",sep=''))

  if (mce) {
    write_omx(file=omxFileName,
              matrix=get(paste("mf.",purpose_mc,modes[mde],".pk",sep='')),
              name=paste("mf.",purpose_mc,modes[mde],".pk",sep=''),
              replace=TRUE)

    write_omx(file=omxFileName,
              matrix=get(paste("mf.",purpose_mc,modes[mde],".op",sep='')),
              name=paste("mf.",purpose_mc,modes[mde],".op",sep=''),
              replace=TRUE)

  }
}


## Calculate trips to/from PnR lots by market segment
if (purpose_mc=='ho') { purp <- 'hbo' }
if (purpose_mc=='hr') { purp <- 'hbr' }
if (purpose_mc=='hs') { purp <- 'hbs' }
if (purpose_mc=='hw') { purp <- 'hbw' }
if (purpose_mc=='hc') { purp <- 'hbc' }

cval   <- c('cv1', 'cv23')
income <- c('l', 'm', 'h')
tod    <- c('am', 'md')
tod2   <- c('pk', 'op')

load(paste("mf.",purp,"prtrtl.Rdata",sep=''))
load(paste("mf.",purp,"prtrtd.Rdata",sep=''))

## Calculate to lot and to destination percentages based on full P->A prtr matrices

## Run for time of day segmentations
for (d in 1:length(tod2)) {     # time of day loop
  tot_prod_allDay <- apply(get(paste("mf.",purpose_mc,"prtr.pk",sep='')) + get(paste("mf.",purpose_mc,"prtr.op",sep='')),1,sum)
  tot_attr_allDay <- apply(get(paste("mf.",purpose_mc,"prtr.pk",sep='')) + get(paste("mf.",purpose_mc,"prtr.op",sep='')),2,sum)

  tot_prod_tod <- apply(get(paste("mf.",purpose_mc,"prtr.",tod2[d],sep='')),1,sum)
  tot_attr_tod <- apply(get(paste("mf.",purpose_mc,"prtr.",tod2[d],sep='')),2,sum)

  percent_tolot_tod  <- tot_prod_tod / tot_prod_allDay
  percent_todest_tod <- tot_attr_tod / tot_attr_allDay

  temp.prtrtl <- sweep(get(paste("mf.",purp,"prtrtl",sep='')),1,percent_tolot_tod,FUN="*")
  temp.prtrtd <- sweep(get(paste("mf.",purp,"prtrtd",sep='')),2,percent_todest_tod,FUN="*")

  temp.prtrtl[temp.prtrtl[,]=="NaN"] <- 0
  temp.prtrtd[temp.prtrtd[,]=="NaN"] <- 0

  assign(paste("mf.",purpose_mc,"prtrtl.",tod2[d],sep=''), temp.prtrtl)
  assign(paste("mf.",purpose_mc,"prtrtd.",tod2[d],sep=''), temp.prtrtd)

  save(list=paste("mf.",purpose_mc,"prtrtl.",tod2[d],sep=''),
       file=paste(project.dir,"/model/mf.",purpose_mc,"prtrtl.",tod2[d],".dat",sep=''))

  save(list=paste("mf.",purpose_mc,"prtrtd.",tod2[d],sep=''),
       file=paste(project.dir,"/model/mf.",purpose_mc,"prtrtd.",tod2[d],".dat",sep=''))

  if (mce) {
      write_omx(file=omxFileName,
                matrix=get(paste("mf.",purpose_mc,"prtrtl.",tod2[d],sep='')),
                name=paste("mf.",purpose_mc,"prtrtl.",tod2[d],sep=''),
                replace=TRUE)

      write_omx(file=omxFileName,
                matrix=get(paste("mf.",purpose_mc,"prtrtd.",tod2[d],sep='')),
                name=paste("mf.",purpose_mc,"prtrtd.",tod2[d],sep=''),
                replace=TRUE)
  }
}


## Run for all market segmentations
if (mce) {
  for (cvl in 1:length(cval))     {  # cval loop
    for (inc in 1:length(income)) {  # income loop
      for (d in 1:length(tod))    {  # time of day loop
        tot_prod_allDay <- apply(get(paste("mf.",purpose_mc,"prtr.pk",sep='')) + get(paste("mf.",purpose_mc,"prtr.op",sep='')),1,sum)
        tot_attr_allDay <- apply(get(paste("mf.",purpose_mc,"prtr.pk",sep='')) + get(paste("mf.",purpose_mc,"prtr.op",sep='')),2,sum)

        tot_prod_tod <- apply(get(paste("mf.",purpose_mc,"prtr.",cval[cvl],".",income[inc],".",tod[d],sep='')),1,sum)
        tot_attr_tod <- apply(get(paste("mf.",purpose_mc,"prtr.",cval[cvl],".",income[inc],".",tod[d],sep='')),2,sum)

        percent_tolot_tod  <- tot_prod_tod / tot_prod_allDay
        percent_todest_tod <- tot_attr_tod / tot_attr_allDay

        temp.prtrtl <- sweep(get(paste("mf.",purp,"prtrtl",sep='')),1,percent_tolot_tod,FUN="*")
        temp.prtrtd <- sweep(get(paste("mf.",purp,"prtrtd",sep='')),2,percent_todest_tod,FUN="*")

        temp.prtrtl[temp.prtrtl[,]=="NaN"] <- 0
        temp.prtrtd[temp.prtrtd[,]=="NaN"] <- 0

        assign(paste("mf.",purpose_mc,"prtrtl.",cval[cvl],".",income[inc],".",tod2[d],sep=''), temp.prtrtl)
        assign(paste("mf.",purpose_mc,"prtrtd.",cval[cvl],".",income[inc],".",tod2[d],sep=''), temp.prtrtd)

#        save(list=paste("mf.",purpose_mc,"prtrtl.",cval[cvl],".",income[inc],".",tod2[d],sep=''),
#             file=paste(project.dir,"/_mceInputs/nonskims/mf.",purpose_mc,"prtrtl.",cval[cvl],".",income[inc],".",tod2[d],".dat",sep=''))

#        save(list=paste("mf.",purpose_mc,"prtrtd.",cval[cvl],".",income[inc],".",tod2[d],sep=''),
#             file=paste(project.dir,"/_mceInputs/nonskims/mf.",purpose_mc,"prtrtd.",cval[cvl],".",income[inc],".",tod2[d],".dat",sep=''))

        write_omx(file=omxFileName,
                  matrix=get(paste("mf.",purpose_mc,"prtrtl.",cval[cvl],".",income[inc],".",tod2[d],sep='')),
                  name=paste("mf.",purpose_mc,"prtrtl.",cval[cvl],".",income[inc],".",tod2[d],sep=''),
                  replace=TRUE)

        write_omx(file=omxFileName,
                  matrix=get(paste("mf.",purpose_mc,"prtrtd.",cval[cvl],".",income[inc],".",tod2[d],sep='')),
                  name=paste("mf.",purpose_mc,"prtrtd.",cval[cvl],".",income[inc],".",tod2[d],sep=''),
                  replace=TRUE)

        for (mde in 1:length(modes)) {
          assign(paste("mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod2[d],sep=''), 
             get(paste("mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod[d],sep='')))

#          save(list=paste("mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod2[d],sep=''),
#               file=paste(project.dir,"/_mceInputs/nonskims/mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod2[d],".dat",sep=''))

          write_omx(file=omxFileName,
                    matrix=get(paste("mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod2[d],sep='')),
                    name=paste("mf.",purpose_mc,modes[mde],".",cval[cvl],".",income[inc],".",tod2[d],sep=''),
                    replace=TRUE)
        }
      }
    }
  }
}

# Save CV0 trips
if (mce) {
  modes <- c('da', 'dp', 'pa', 'tr', 'bike', 'walk')
  for (inc in 1:length(income))    {  # income loop
    for (d in 1:length(tod))       {  # time of day loop
      for (mde in 1:length(modes)) {
        assign(paste("mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod2[d],sep=''),
           get(paste("mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod[d],sep='')))

#        save(list=paste("mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod2[d],sep=''),
#             file=paste(project.dir,"/model/mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod2[d],".dat",sep=''))

        write_omx(file=omxFileName,
                  matrix=get(paste("mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod2[d],sep='')),
                  name=paste("mf.",purpose_mc,modes[mde],".cv0.",income[inc],".",tod2[d],sep=''),
                  replace=TRUE)
      }
    }
  }
}

## Report mode choice summaries
modes <- c('da', 'dp', 'pa', 'tr', 'prtr', 'bike', 'walk')

if (file.access(paste(purp,"ms.rpt",sep=''), mode=0) == 0) { system(paste("rm ",purp,"ms.rpt",sep='')) }

for (mde in 1:length(modes)) {
  assign(paste("mf.",purpose_mc,modes[mde],sep=''), 
     get(paste("mf.",purpose_mc,modes[mde],".pk",sep='')) +
     get(paste("mf.",purpose_mc,modes[mde],".op",sep='')))

  distsum(paste("mf.",purpose_mc,modes[mde],sep=''), paste(purp,modes[mde],"trips",sep=' '), "ga", 3, paste(purp,"ms",sep=''), project, initials)
}
