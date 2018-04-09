#! /bin/sh
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# demand.sh
# 
# Functions to run Metro's demand models and produce UB files.
#
# Edited by Peter Bosa <bosap@oregonmetro.gov> (4/17)
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# Function for determining whether or not to run PnR lot choice programs
pnrChoice () {

    # If not non-home or school trip purposes, calculate PnR skims for lot choice
    if [ ! "$purp" = "nhw" ] && [ ! "$purp" = "nhnw" ] && [ ! "$purp" = "sch" ]
    then
        echo "source('$R_SRC2/k.matrices_in_pnr.R',echo=TRUE)" >> run_$purp.R
        echo "source('$R_SRC2/k.${purp}pnrSkims.R',echo=TRUE)" >> run_$purp.R
    fi

    # If home based work trip purpose, calculate likely lots
    if [ "$purp" = "hbw" ]
    then
        echo "source('$R_SRC2/k.likelyLots.R',echo=TRUE)" >> run_$purp.R
    fi
}

# PreLoad instructions for R
preLoad () {

    echo "options(warn=-1)" >> run_$purp.R
    echo "sink(\"../logs/${purpose}_report.log\", append = FALSE, type = c(\"output\", \"message\"))" >> run_$purp.R
}

# Run Generation programs
generation () {

    echo "system(\"echo '1. Generation for ${purp}'\")" >> run_$purp.R
    echo "source('$R_SRC2/k.${purp}_Generation.R',echo=TRUE)" >> run_$purp.R
}

# Run Destination Choice programs
distribution () {

    echo "system(\"echo '    2. Destination Choice for ${purp}'\")" >> run_$purp.R
    pnrChoice
    if [ ! "$purp" = "sch" ]
    then
      echo "source('$R_SRC2/k.${purp}_DestChoice.R',echo=TRUE)" >> run_$purp.R
    else
      echo "source('$R_SRC2/k.${purp}_Distribution.R',echo=TRUE)" >> run_$purp.R
    fi
}

# Run Mode Choice programs
mode_choice () {

    echo "system(\"echo '        3. Mode Choice for ${purp}'\")" >> run_$purp.R
    if [ ! "$DISTRIBUTION" ]
    then
        pnrChoice
    fi
    echo "source('$R_SRC2/k.${purp}_ModeChoice.R',echo=TRUE)" >> run_$purp.R
}

# Reports
mc_reports() {
    local log=$LOG_DIR/mc_reports.log
    echo "Demand Model Reports"
    echo "Running k.save_mc_summary.R"  
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.save_mc_summary.R > $log
    echo "Running k.dist_distsum.R"  
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.dist_distsum.R > $log
    	  echo "Running k.ms_distsum.R"  
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.ms_distsum.R > $log
     	  echo "Running k.ms_mode_totals_distsum.R"  
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.ms_mode_totals_distsum.R > $log
     	  echo "Running k.ms_summary.R"  
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.ms_summary.R > $log
}

peak_reports() {
    local log=$LOG_DIR/assign_reports.log
    echo "Peaking Reports"
    $R_CMD_PEAK < $R_SRC/reports/notebook/k.peak_summary.R > $log
}

assign_reports() {
    local log=$LOG_DIR/assign_reports.log
    echo "Assign Reports"
    $R_CMD_PEAK < $R_SRC/reports/k.run_perf_measures.R > $log
}

# Peaking programs
peaking () {
  echo "-> Executing Peaking R control file"
    if [ ! -e "k.runPeaking.R" ]; then
      echo "    Creating k.runPeaking.R"
      cp $R_SRC2/peak/k.runPeaking.R ./k.runPeaking.R
    fi

    $R_CMD_PEAK < ./k.runPeaking.R
}

peakSpreading () {
  echo "-> Executing Peak Spreading R control file"
    if [ ! -e "k.runPeakSpread.R" ]; then
      echo "    Creating k.runPeakSpread.R"
      cp $R_SRC2/peak/k.runPeakSpreadAllDay.R ./k.runPeakSpreadAllDay.R
    fi

    $R_CMD_PEAK < ./k.runPeakSpreadAllDay.R
}


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
