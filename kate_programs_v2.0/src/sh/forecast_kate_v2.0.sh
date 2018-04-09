#! /bin/sh
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
# forecast_kate_2.0
# 
# Metro's travel demand forcasting model, scripted using Bash.
#
# Edited to current format by Peter Bosa <peter.bosa@oregonmetro.gov> (2/18)
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

USAGE="$0 [-fagdmpxerch? --input] 

where:

    f Full model run, including model_setup_kate2.0_py
    a Assign skims
    g Generation
    d Destination choice
    m Mode choice
    p Peak factoring
    x Peak spreading - Option will set peakSpread <- TRUE in k.model_setup.R program and
                       run peak spreading
    e Metroscope outputs  - Option will set metroscope <- TRUE in k.model_setup.R program and
                            run programs to produce Metroscope travel times and utilities inputs
    k MCE - Option will set mce <- TRUE in k.model_setup.R program and write various CSV and OMX files to
            ./_mceInputs directory. Includes keeping final P->A mode share tables segmented by 
            car ownership (cval = 0, 1, 23) and income classification (low, medium, high)
    r Produces report files after mode choice
    c Produces calibration summaries by model
    h Help message
    ? Help message

    --input=<Input_spreadsheet.xlsx> Use this variable to manually define model run
                                     input spreadsheet for use by model_setup_kate1.0.py

Metros travel demand forcasting model with Summit. Without option flags, the
program builds runs generation, distribution, and mode choice. Model components 
can be turned on and off by setting options in the configuration file. Options 
given as command line arguments take precedent.
"

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
# Begin user-controlled fields.                 
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#


#-----------------------------------------------------------------------------#
#
# Directory paths
#
#-----------------------------------------------------------------------------#

ROOT=$PWD

# model run directory
BASEDIR="$PWD"

# set R-programs directory
R_SRC=/cygdrive/v/tbm/kate/programs_v2.0
R_SRC2="V:/tbm/kate/programs_v2.0"

# set Python path
PY_PATH="C:/python27"

# set other directory paths
PROGRAMS_SRC=$R_SRC/src
SH_SRC=$PROGRAMS_SRC/sh
C_SRC=$PROGRAMS_SRC/c
PY_SRC=$PROGRAMS_SRC/py/modelSetup

LOG_DIR=$BASEDIR/logs
mkdir -p $LOG_DIR
mkdir -p $BASEDIR/model
mkdir -p $BASEDIR/model_hbo
mkdir -p $BASEDIR/model_hbr
mkdir -p $BASEDIR/model_hbs
mkdir -p $BASEDIR/model_hbw
mkdir -p $BASEDIR/model_nh
mkdir -p $BASEDIR/model_sc

AWK_SRC=$PROGRAMS_SRC/awk


#-----------------------------------------------------------------------------#
#
# Abbreviations
#
#-----------------------------------------------------------------------------#

R_CMD="R -q --slave --vanilla --args ../k.model_setup.R"
R_CMD_PEAK="R -q --slave --vanilla --args ../../k.model_setup.R"

if [[ $OS = "Windows_NT" ]]
then
   AWK="gawk "
else
   AWK="awk "
fi


#-----------------------------------------------------------------------------#
#
# Number of parallel processes to run.
#
#-----------------------------------------------------------------------------#

MAX_PROCESSES=4

# Time in seconds between attempts to launch a new process
RETRY_TIME=10


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
# End user-controlled fields
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#


#-----------------------------------------------------------------------------#
#
# Exit codes
#
#-----------------------------------------------------------------------------#

ERR_OPTIONS=100
ERR_MISSING_FILE=101


#-----------------------------------------------------------------------------#
#
# Parse options
#
#-----------------------------------------------------------------------------#

if [ "$#" -gt 0 ]
then
    while getopts ":fagdmpxekrch?" option
    do
    case $option in
      f ) FULLRUN=1;;
      a ) ASSIGN=1;;
      g ) GENERATION=1;;
      d ) DISTRIBUTION=1;;
      m ) MODE_CHOICE=1;;
      p ) PEAK_FACTORING=1;;
      x ) PEAK_SPREADING=1;;
      e ) METROSCOPE=1;;
      k ) MCE=1;;
      r ) REPORTS=1;;
      c ) CALIREPORTS=1;;
      h | ? ) echo "$USAGE"; exit;;
      * ) echo "$USAGE"; exit $ERR_OPTIONS;;
    esac
    done

    # point the option index to the first argument
    shift $(($OPTIND - 1))
else
    # default settings
    ASSIGN=1
    GENERATION=1
    DISTRIBUTION=1
    MODE_CHOICE=1
    PEAK_FACTORING=1
fi

# ensure that this has been called with the proper arguments
if [ "$#" -ne 0 ]
then
    echo $#
    echo "$USAGE"
    exit $ERR_OPTIONS
fi

# if FULLRUN flag is set to true
if [[ "$FULLRUN" ]]
then
  INPUTS_FILE="$(find -name '*.xlsx')"
  if test -e $INPUT_FILE
  then
    ASSIGN=1
    GENERATION=1
    DISTRIBUTION=1
    MODE_CHOICE=1
    PEAK_FACTORING=1

    if [ ! -e $BASEDIR/skims/emmebank ]
    then
      SEED="seed"
    else
      SEED="noseed"
    fi

    cp $PY_SRC/model_setup_kate2.0.py .
    $PY_PATH/python model_setup_kate2.0.py $INPUTS_FILE $SEED
    rm model_setup_kate1.0.py
  else
    echo "*******************************************************"
    echo "*******************************************************"
    echo ""
    echo "No valid input spreadsheet exists. Make sure there is a"
    echo "single (1) inputs spreadsheet (*.xlsx) in directory."
    echo ""
    echo "*******************************************************"
    echo "*******************************************************"
  fi
fi

# write R_SRC2 directory path to k.model_setup.R
R_PATH="R.path         <- \'$R_SRC2\'"
sed -i -e s%'^R.path.*'%"$R_PATH"% k.model_setup.R

# check for peak spreading argument
if [ "$PEAK_SPREADING" ]
then
    (
    sed -i -e 's/^peakSpread.*/peakSpread <- TRUE/' k.model_setup.R
    )
else
    (
    sed -i -e 's/^peakSpread.*/peakSpread <- FALSE/' k.model_setup.R
    )
fi

# check for market desegmentation argument
if [ "$MCE" ]
then
   sed -i -e 's/^mce.*/mce <- TRUE/' k.model_setup.R
   GENERATION=1
   DISTRIBUTION=1
   MODE_CHOICE=1
   mkdir -p $BASEDIR/_mceInputs
else
   sed -i  -e 's/^mce.*/mce <- FALSE/' k.model_setup.R
fi


#-----------------------------------------------------------------------------#
#
# Import function and variable definitions
#
#-----------------------------------------------------------------------------#

source "$SH_SRC/demand_kate.sh"


#-----------------------------------------------------------------------------#
#
# Demand model outline for standard purposes
#
#-----------------------------------------------------------------------------#

demand () {
    local purpose="$1"
    echo ""
    echo "-> Creating $purpose R control file"
    echo "# R program to run model components for ${purpose}" > run_$purpose.R
    echo "# Created on $(date)" >> run_$purpose.R
    echo "# " >> run_$purpose.R
    echo "# To run this program manually, enter the following line at the" >> run_$purpose.R 
    echo "# Cygwin command prompt from within the ./model_${purpose} folder:" >> run_$purpose.R
    echo "#     ${R_CMD} < ./run_${purpose}.R" >> run_$purpose.R
    echo "" >> run_$purpose.R

    preLoad

    if [ "$GENERATION" ]
    then
      generation $purpose
    fi

    if [ "$DISTRIBUTION" ]
    then
      distribution $purpose
    fi

    if [ "$MODE_CHOICE" ]
    then
      REPORTS=1
      mode_choice $purpose
    fi

    echo "sink()" >> run_$purp.R
    
    echo "-> Executing $purpose"
    echo ""

    ## Run the trip purpose model
    $R_CMD < ./run_$purpose.R
}


#-----------------------------------------------------------------------------#
#
# Standard demand models
#
#-----------------------------------------------------------------------------#

echo "Begin model run"
echo "$(date)"

run_demand () {

    # track number of ongoing processes
    local processes="$(mktemp $(basename $0).processes.XXXXXX)"

    # remove lock file on interrupt (Control-C)
    trap "rm -f $process; exit" SIGINT

    while [ "$#" -gt 0 ]
    do

    process_cnt="$(wc -l $processes | $AWK '{print $1}')"
    # process_cnt can be an empty string if the above command did not work
    if [[ $process_cnt && $process_cnt -lt $MAX_PROCESSES ]]
    then
      (
    purp="$1"
    purp_dir="$purp"

    if [[ "$purp" = "nhw" || "$purp" = "nhnw" ]]
    then
        purp_dir="nh"
    fi
    
    if [[ "$purp" = "hbc" || "$purp" = "sch" ]]
    then
        purp_dir="sc"
    fi

    # add an entry to the process file
    echo "$purp" >> $processes
    
    (cd model_$purp_dir; demand "$purp")

    # remove the entry
    sed -i -e "/$purp/ d" $processes
      ) &

      shift
    fi

  sleep $RETRY_TIME
    done

    wait
    rm -f $processes

    # reset Control-C
    trap 'exit' SIGINT
}

if [ "$ASSIGN" ]
then
   ( cd ./skims; Emme -ng 000 -m run_all_skims )
fi

if [[ "$GENERATION" || "$DISTRIBUTION" || "$MODE_CHOICE" || "$METROSCOPE" ]]
then
    if [[ "$METROSCOPE" ]]
    then
       sed -i -e 's/^metroscope.*/metroscope <- TRUE/' k.model_setup.R
       GENERATION=1
       DISTRIBUTION=1
       
       # This statement is strictly for METROSCOPE runs
       # Do not edit
       run_demand hbw
    else
       sed -i -e 's/^metroscope.*/metroscope <- FALSE/' k.model_setup.R

       # Run hbw trip purpose before other home based trip purposes to setup PnR lot usage
       # nh and sch trip purposes do not use PnR, so they can be run in parallel with hbw
       # Run other home based trip purposes next since they need hbw lot loadings (shadow prices)

       run_demand hbw nhw nhnw sch
       run_demand hbo hbr hbs hbc

       wait
       rm -f $processes
    fi
fi

# reset Control-C
trap 'exit' SIGINT
rm -f $processes

if [ "$REPORTS" ]
then
   (cd model/reports; mc_reports)
fi

if [ "$MODE_CHOICE" ]
then
    # Write final PnR lot data log
    R -q --slave --vanilla --args ./k.model_setup.R < $R_SRC/k.writeLotsFinal.R
fi


#-----------------------------------------------------------------------------#
#
# Peaking
#
#-----------------------------------------------------------------------------#

if [ "$PEAK_FACTORING" ]
then
    (
    if [ ! -e $BASEDIR/model/peak/assign/emmebank ]
    then
      mkdir -p $BASEDIR/model/peak/assign
      cp $BASEDIR/skims/emmebank $BASEDIR/model/peak/assign/emmebank
      cp $BASEDIR/skims/*.db $BASEDIR/model/peak/assign/
      cp -r $BASEDIR/skims/emmemat/ $BASEDIR/model/peak/assign/
      cp -r $BASEDIR/skims/inputs/ $BASEDIR/model/peak/assign/
      cp -r $BASEDIR/skims/macros/ $BASEDIR/model/peak/assign/
      (cd model/peak/assign; Emme -ng 000 -m run_matrix_init)
      (cd model/peak/assign; Emme -ng 000 -m run_assign_init)
      rm $BASEDIR/model/peak/assign/usemacro*
      rm $BASEDIR/model/peak/assign/errors*
    fi
    (cd model/peak; peaking)
    )
fi

if [ "$PEAK_SPREADING" ]
then
    (
    (cd model/peak; peakSpreading)
    )
fi


#-----------------------------------------------------------------------------#
#
# All done
#
#-----------------------------------------------------------------------------#

if [ "$MCE" ]
then
    # Market segment non-home trip tables
    R -q --slave --vanilla --args ./k.model_setup.R < $R_SRC/k.ms_markets_sum_nh.R
fi


if [ "$CALIREPORTS" ]
then

    echo "Running calibration reports"
    if [[ "$MODE_CHOICE" ]]
    then
        R -q --slave --vanilla --args < $R_SRC/src/misc_r/validation_MC_reports_prep.R
    fi

    if [[ "$DISTRIBUTION" ]]
    then
        R -q --slave --vanilla --args < $R_SRC/src/misc_r/validation_DC_reports_prep.R
    fi

    if [[ "$GENERATION" ]]
    then
        R -q --slave --vanilla --args < $R_SRC/src/misc_r/validation_GEN_reports_prep.R
    fi

fi

wait

echo "Finished model run"
echo "$(date)"

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
