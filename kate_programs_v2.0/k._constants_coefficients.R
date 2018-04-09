# k._constants_coefficients.R
#
# Contains most constants, coefficients, and parameters
# used throughout the Kate model structure


########################################################
# -------------------- GENERATION -------------------- #
########################################################

# calibration factors
HBW.gen.calibrationFac  <- 1.36  # HBW gen factor is an employment trip rate, and, therefore, different than the other gen calibration factors
HBC.gen.calibrationFac  <- 1.50
HBO.gen.calibrationFac  <- 1.025
HBR.gen.calibrationFac  <- 1.025
HBS.gen.calibrationFac  <- 1.025
NHW.gen.calibrationFac  <- 1.025
NHNW.gen.calibrationFac <- 1.025

# HBC off-campus enrollment to daily 1-way trips factor
HBC.enrollTripFac <- 1.0

# NHW workplace production location model (calculated in dest choice)
# estimation model: 37, 8/16/2016
NHW.aerProdCoeff <- 1.8386 
NHW.amfProdCoeff <- 1.0
NHW.conProdCoeff <- 4.1787
NHW.eduProdCoeff <- 4.1787
NHW.fsdProdCoeff <- 1.0
NHW.govProdCoeff <- 1.8386
NHW.hssProdCoeff <- 1.8386
NHW.mfgProdCoeff <- 2.4719
NHW.mhtProdCoeff <- 2.4719
NHW.osvProdCoeff <- 4.1787
NHW.pbsProdCoeff <- 3.0344
NHW.rcsProdCoeff <- 1.0
NHW.twuProdCoeff <- 3.0344
NHW.wtProdCoeff  <- 2.4719
NHW.hhProdCoeff  <- 0.3198


########################################################
# ---------------- DESTINATION CHOICE ---------------- #
########################################################

# -------------------------------
# HOME-BASED WORK LOW INCOME (DC)
# estimation model: 165, 12/05/2016

HBW.low.lsCoeff <- 0.2

HBW.low.logdistXorwaCoeff        <- -1.90
HBW.low.logdistXwaorCoeff        <- -1.80
HBW.low.logdistXnoXingCoeff      <- -1.80
HBW.low.logdistXewWestHillsCoeff <-  0.05
HBW.low.logdistXweWestHillsCoeff <-  0.10
HBW.low.logdistXewWillRiverCoeff <-  0.10
HBW.low.logdistXweWillRiverCoeff <-  0.05

HBW.low.aerCoeff <- 0.1237
HBW.low.amfCoeff <- 1.0
HBW.low.conCoeff <- 0.5153
HBW.low.eduCoeff <- 0.5153
HBW.low.fsdCoeff <- 1.0
HBW.low.govCoeff <- 0.1237
HBW.low.hssCoeff <- 0.1237
HBW.low.mfgCoeff <- 0.1237
HBW.low.mhtCoeff <- 0.1237
HBW.low.osvCoeff <- 0.5153
HBW.low.pbsCoeff <- 0.1237
HBW.low.rcsCoeff <- 0.1237
HBW.low.twuCoeff <- 1.0
HBW.low.wtCoeff  <- 0.1237

# -------------------------------
# HOME-BASED WORK MID INCOME (DC)
# estimation model: 136, 12/05/2016

HBW.mid.lsCoeff <- 0.2

HBW.mid.logdistXorwaCoeff        <- -1.95
HBW.mid.logdistXwaorCoeff        <- -1.78
HBW.mid.logdistXnoXingCoeff      <- -1.40
HBW.mid.logdistXewWestHillsCoeff <-  0.05
HBW.mid.logdistXweWestHillsCoeff <-  0.10
HBW.mid.logdistXewWillRiverCoeff <-  0.20
HBW.mid.logdistXweWillRiverCoeff <-  0

HBW.mid.aerCoeff <- 0.2567
HBW.mid.amfCoeff <- 0.4404
HBW.mid.conCoeff <- 0.3570
HBW.mid.eduCoeff <- 0.3362
HBW.mid.fsdCoeff <- 0.0944
HBW.mid.govCoeff <- 0.2080
HBW.mid.hssCoeff <- 0.1423
HBW.mid.mfgCoeff <- 0.1703
HBW.mid.mhtCoeff <- 0.1212
HBW.mid.osvCoeff <- 1.0
HBW.mid.pbsCoeff <- 0.2982
HBW.mid.rcsCoeff <- 0.1313
HBW.mid.twuCoeff <- 0.4115
HBW.mid.wtCoeff  <- 0.0846


# --------------------------------
# HOME-BASED WORK HIGH INCOME (DC)
# estimation model: 212, 12/05/2016

HBW.high.lsCoeff <- 0.2

HBW.high.logdistXorwaCoeff        <- -1.50
HBW.high.logdistXwaorCoeff        <- -1.78
HBW.high.logdistXnoXingCoeff      <- -1.40
HBW.high.logdistXewWestHillsCoeff <-  0.00
HBW.high.logdistXweWestHillsCoeff <-  0.10
HBW.high.logdistXewWillRiverCoeff <-  0.20
HBW.high.logdistXweWillRiverCoeff <-  0

HBW.high.aerCoeff <- 0.3465
HBW.high.amfCoeff <- 0.0750
HBW.high.conCoeff <- 0.6453
HBW.high.eduCoeff <- 1.0
HBW.high.fsdCoeff <- 0.5051
HBW.high.govCoeff <- 0.5051
HBW.high.hssCoeff <- 0.5051
HBW.high.mfgCoeff <- 0.5051
HBW.high.mhtCoeff <- 1.0
HBW.high.osvCoeff <- 0.6453
HBW.high.pbsCoeff <- 1.0
HBW.high.rcsCoeff <- 0.0750
HBW.high.twuCoeff <- 0.5051
HBW.high.wtCoeff  <- 0.3465


# -----------------------
# HOME-BASED COLLEGE (DC)
# estimation model: 35, 12/05/2016

HBC.lsLowWeight  <- 0.29
HBC.lsMidWeight  <- 0.57
HBC.lsHighWeight <- 0.14

HBC.lsCoeff <- 0.2

HBC.logdistXorwaCoeff        <- -2.01
HBC.logdistXwaorCoeff        <- -2.99
HBC.logdistXnoXingCoeff      <- -1.35
HBC.logdistXewWestHillsCoeff <- -0.55
HBC.logdistXweWestHillsCoeff <- -0.0836
HBC.logdistXewWillRiverCoeff <-  0
HBC.logdistXweWillRiverCoeff <- -0.5

HBC.enrollCoeff <- 1.0


# ---------------------
# HOME-BASED OTHER (DC)
# estimation model: 81, 12/05/2016

HBO.lsLowWeight  <- 0.13
HBO.lsMidWeight  <- 0.61
HBO.lsHighWeight <- 0.26

HBO.lsCoeff <- 0.788

HBO.logdistXorwaCoeff        <- -1.75
HBO.logdistXwaorCoeff        <- -2.75
HBO.logdistXnoXingCoeff      <- -1.50
HBO.logdistXewWestHillsCoeff <-  0
HBO.logdistXweWestHillsCoeff <- -0.0523
HBO.logdistXewWillRiverCoeff <-  0
HBO.logdistXweWillRiverCoeff <- -0.172

HBO.aerCoeff <- 0.1262
HBO.amfCoeff <- 0.3712
HBO.conCoeff <- 0.0048
HBO.eduCoeff <- 0.1437
HBO.fsdCoeff <- 1.0
HBO.govCoeff <- 0.0916
HBO.hssCoeff <- 0.1588
HBO.mfgCoeff <- 0.0048
HBO.mhtCoeff <- 0.0048
HBO.osvCoeff <- 1.0
HBO.pbsCoeff <- 0.0665
HBO.rcsCoeff <- 0.2060
HBO.twuCoeff <- 0.1620
HBO.wtCoeff  <- 0.0048
HBO.hhCoeff  <- 0.1044


# --------------------------
# HOME-BASED RECREATION (DC)
# estimation model: 122, 12/05/2016

HBR.lsLowWeight  <- 0.15
HBR.lsMidWeight  <- 0.58
HBR.lsHighWeight <- 0.27

HBR.lsCoeff <- 0.547

HBR.logdistXorwaCoeff        <- -2.78
HBR.logdistXwaorCoeff        <- -2.78
HBR.logdistXnoXingCoeff      <- -2.10
HBR.logdistXewWestHillsCoeff <-  0
HBR.logdistXweWestHillsCoeff <-  0
HBR.logdistXewWillRiverCoeff <-  0
HBR.logdistXweWillRiverCoeff <-  0

HBR.aerCoeff <- 0.5117
HBR.amfCoeff <- 0
HBR.conCoeff <- 0
HBR.eduCoeff <- 0.0276
HBR.fsdCoeff <- 0.0963
HBR.govCoeff <- 0.0048
HBR.hssCoeff <- 0
HBR.mfgCoeff <- 0
HBR.mhtCoeff <- 0
HBR.osvCoeff <- 0
HBR.pbsCoeff <- 0
HBR.rcsCoeff <- 0
HBR.twuCoeff <- 0
HBR.wtCoeff  <- 0
HBR.hhCoeff  <- 0.0063

HBR.activeAcresCoeff    <- 0.3499
HBR.parkAcresDiv10Coeff <- 1


# ------------------------
# HOME-BASED SHOPPING (DC)
# estimation model: 119, 12/05/2016

HBS.lsLowWeight  <- 0.19
HBS.lsMidWeight  <- 0.60
HBS.lsHighWeight <- 0.21

HBS.lsCoeff <- 1.37

HBS.logdistXorwaCoeff        <- -2.25
HBS.logdistXwaorCoeff        <- -3.00
HBS.logdistXnoXingCoeff      <- -1.75
HBS.logdistXewWestHillsCoeff <-  0.1
HBS.logdistXweWestHillsCoeff <-  0
HBS.logdistXewWillRiverCoeff <-  0.1
HBS.logdistXweWillRiverCoeff <- -0.05

HBS.aerCoeff <- 0
HBS.amfCoeff <- 0
HBS.conCoeff <- 0
HBS.eduCoeff <- 0
HBS.fsdCoeff <- 0.1720
HBS.govCoeff <- 0
HBS.hssCoeff <- 0
HBS.mfgCoeff <- 0
HBS.mhtCoeff <- 0
HBS.osvCoeff <- 0.1541
HBS.pbsCoeff <- 0
HBS.rcsCoeff <- 1.0
HBS.twuCoeff <- 0
HBS.wtCoeff  <- 0


# ------------------------
# NON-HOME-BASED WORK (DC)
# estimation model: 47, 12/05/2016

NHW.lsCoeff <- 1.01

NHW.logdistXorwaCoeff        <- -1.15
NHW.logdistXwaorCoeff        <- -1.40
NHW.logdistXnoXingCoeff      <- -1.49
NHW.logdistXewWestHillsCoeff <-  0.1
NHW.logdistXweWestHillsCoeff <-  0
NHW.logdistXewWillRiverCoeff <-  0.1
NHW.logdistXweWillRiverCoeff <-  0

NHW.aerCoeff <- 0.1153
NHW.amfCoeff <- 0.4033
NHW.conCoeff <- 0.0561
NHW.eduCoeff <- 0.1920
NHW.fsdCoeff <- 1.0
NHW.govCoeff <- 0.0829
NHW.hssCoeff <- 0.0573
NHW.mfgCoeff <- 0.0027
NHW.mhtCoeff <- 0.0027
NHW.osvCoeff <- 0.6114
NHW.pbsCoeff <- 0.0686
NHW.rcsCoeff <- 0.3679
NHW.twuCoeff <- 0.1013
NHW.wtCoeff  <- 0.0027
NHW.hhCoeff  <- 0.0781


# ----------------------------
# NON-HOME-BASED NON-WORK (DC)
# estimation model: 25, 12/05/2016

NHNW.lsCoeff <- 1.13

NHNW.logdistXorwaCoeff        <- -1.8
NHNW.logdistXwaorCoeff        <- -2.4
NHNW.logdistXnoXingCoeff      <- -1.8
NHNW.logdistXewWestHillsCoeff <-  0
NHNW.logdistXweWestHillsCoeff <- -0.153
NHNW.logdistXewWillRiverCoeff <- -0.1
NHNW.logdistXweWillRiverCoeff <- -0.167

NHNW.aerCoeff <- 0.1604
NHNW.amfCoeff <- 0.2060
NHNW.conCoeff <- 0.1249
NHNW.eduCoeff <- 0.1901
NHNW.fsdCoeff <- 0.4253
NHNW.govCoeff <- 0.0255
NHNW.hssCoeff <- 0.0429
NHNW.mfgCoeff <- 0.0005
NHNW.mhtCoeff <- 0.0005
NHNW.osvCoeff <- 1.0
NHNW.pbsCoeff <- 0.0106
NHNW.rcsCoeff <- 0.3263
NHNW.twuCoeff <- 0.0185
NHNW.wtCoeff  <- 0.0085


########################################################
# ------------------- MODE CHOICE -------------------- #
########################################################

# --------------------
# HOME-BASED WORK (MC)
# estimation model: HBW_060, 11/14/2016

#constants
HBW.MC.dpconst          <- -3.62
HBW.MC.paconst          <- -4.15
HBW.MC.tranconst        <- -1.20
HBW.MC.prconst          <-  1.85
HBW.MC.bikeconst        <- -2.12
HBW.MC.walkconst        <- -0.55

HBW.LS.dpconst          <- -3.21
HBW.LS.paconst          <- -3.49
HBW.LS.tranconst        <-  0.00258
HBW.LS.prconst          <-  HBW.MC.prconst
HBW.LS.bikeconst        <- -1.81
HBW.LS.walkconst        <- -0.0511

#cost coefficients (auto operating)
HBW.low.cc              <- -0.309
HBW.medium.cc           <- -0.252
HBW.high.cc             <- -0.252

#cost coefficients (auto out of pocket: parking and tolls)
HBW.low.pktc            <- -0.509
HBW.medium.pktc         <- -0.509
HBW.high.pktc           <- -0.461

#cost coefficients (transit fares)
HBW.low.faresc          <- HBW.low.cc
HBW.medium.faresc       <- HBW.medium.cc
HBW.high.faresc         <- HBW.high.cc

#division of cost among HOV drivers and passengers
HBW.dp.autoCostFac      <- 0.6667
HBW.pa.autoCostFac      <- 0.3333

#coefficients
HBW.ivCoeff             <- -0.0414

HBW.da.walkCoeff        <- -0.100
HBW.dp.walkCoeff        <-  HBW.da.walkCoeff
HBW.pa.walkCoeff        <-  HBW.da.walkCoeff
HBW.pa.logMixTotACoeff  <-  0.0506
HBW.pa.logMixRetPCoeff  <-  0.0297

HBW.tr.wait1Coeff       <- -0.0543
HBW.tr.wait2Coeff       <- -0.0610
HBW.tr.walkCoeff        <-  HBW.da.walkCoeff
HBW.tr.transCoeff       <- -0.16
HBW.tr.logMixTotACoeff  <-  0.080
HBW.tr.trOVIVCoeff      <- -0.400

HBW.bk.inbikeCoeff      <-  1.35
HBW.bk.ubdistCoeff      <- -0.250
HBW.bk.cbcostCoeff      <-  0.0636
HBW.bk.logMixTotACoeff  <-  0.0517

HBW.wk.logMixRetPCoeff  <- 0.107
HBW.wk.walkCoeff        <- HBW.da.walkCoeff

#markets
HBW.da.cv0              <-  0
HBW.da.cv1              <- -1.9
HBW.da.cv23             <-  0

HBW.dp.cv0              <-  0
HBW.dp.cv1              <- -1.020
HBW.dp.cv23             <-  0
HBW.dp.hh1              <- -1.4
HBW.dp.hh2              <-  0
HBW.dp.hh34             <-  0.729
HBW.pa.hh1              <-  0
HBW.pa.hh2              <-  0.299
HBW.pa.hh34             <-  0

HBW.tr.cv0              <-  1.34
HBW.tr.cv1              <-  0.349
HBW.tr.cv23             <-  0
HBW.tr.sw               <-  0.784
HBW.tr.mw               <-  0

#peak/off-peak factors
HBW.pkfact              <- 0.6346
HBW.opfact              <- 1 - HBW.pkfact


# -----------------------
# HOME-BASED COLLEGE (MC)
# estimation model: 243, 11/18/2016

#constants
HBC.MC.dpconst          <- -3.10
HBC.MC.paconst          <- -2.45
HBC.MC.tranconst        <-  0
HBC.MC.prconst          <-  2.85
HBC.MC.bikeconst        <- -1.90
HBC.MC.walkconst        <-  0.25

HBC.LS.dpconst          <- -3.24
HBC.LS.paconst          <- -2.93
HBC.LS.tranconst        <-  0.0169
HBC.LS.prconst          <-  HBC.MC.prconst
HBC.LS.bikeconst        <- -1.97
HBC.LS.walkconst        <-  0

#cost coefficients (auto operating)
HBC.low.cc              <- -0.463
HBC.medium.cc           <- -0.383
HBC.high.cc             <- -0.184

#cost coefficients (auto out of pocket: parking and tolls)
HBC.low.pktc            <- HBC.low.cc
HBC.medium.pktc         <- HBC.medium.cc
HBC.high.pktc           <- HBC.high.cc

#cost coefficients (transit fares)
HBC.low.faresc          <- HBC.low.cc
HBC.medium.faresc       <- HBC.medium.cc
HBC.high.faresc         <- HBC.high.cc

#division of cost among HOV drivers and passengers
HBC.dp.autoCostFac      <- 0.6667
HBC.pa.autoCostFac      <- 0.3333

#coefficients
HBC.ivCoeff             <- -0.0346

HBC.da.walkCoeff        <- -0.08
HBC.dp.walkCoeff        <-  HBC.da.walkCoeff
HBC.pa.walkCoeff        <-  HBC.da.walkCoeff

HBC.tr.wait1Coeff       <- -0.055
HBC.tr.wait2Coeff       <- -0.055
HBC.tr.walkCoeff        <- -0.08
HBC.tr.transCoeff       <- -0.15
HBC.tr.trOVIVCoeff      <-  0.000

HBC.bk.inbikeCoeff      <-  0.0
HBC.bk.ubdistCoeff      <- -0.300
HBC.bk.cbcostCoeff      <-  0.05
HBC.bk.logMixTotACoeff  <-  0.1

HBC.wk.walkCoeff        <- HBC.da.walkCoeff
HBC.wk.logMixRetPCoeff  <- 0.119

#markets
HBC.da.cv0              <- 0
HBC.da.cv1              <- -1.36
HBC.da.cv23             <- 0

HBC.dp.cv0              <- 0
HBC.dp.cv123            <- 0

HBC.tr.cv0              <- 0.763
HBC.tr.cv1              <- 0.528
HBC.tr.cv23             <- 0

#peak/off-peak factors
HBC.pkfact              <- 0.4126
HBC.opfact              <- 1 - HBC.pkfact


# ---------------------
# HOME-BASED OTHER (MC)
# estimation model: HBNW_131, 11/14/2016

#constants
HBO.MC.dpconst          <- -0.90
HBO.MC.paconst          <- -0.60
HBO.MC.tranconst        <- -3.60
HBO.MC.prconst          <- -2.20
HBO.MC.bikeconst        <- -2.75
HBO.MC.walkconst        <-  0.00

HBO.LS.dpconst          <- -0.517
HBO.LS.paconst          <- -1.5
HBO.LS.tranconst        <-  0.844
HBO.LS.prconst          <-  HBO.MC.prconst
HBO.LS.bikeconst        <- -2.31
HBO.LS.walkconst        <-  0

#cost coefficients (auto operating)
HBO.low.cc              <- -0.255
HBO.medium.cc           <- -0.255
HBO.high.cc             <- -0.174

#cost coefficients (auto out of pocket: parking and tolls)
HBO.low.pktc            <- -0.731
HBO.medium.pktc         <- -0.393
HBO.high.pktc           <- -0.393

#cost coefficients (transit fares)
HBO.low.faresc          <- HBO.low.cc
HBO.medium.faresc       <- HBO.medium.cc
HBO.high.faresc         <- HBO.high.cc

#division of cost among HOV drivers and passengers
HBO.dp.autoCostFac      <- 0.6667
HBO.pa.autoCostFac      <- 0.3333

#coefficients
HBO.ivCoeff             <- -0.0315

HBO.da.walkCoeff        <- -0.125
HBO.dp.walkCoeff        <-  HBO.da.walkCoeff
HBO.pa.walkCoeff        <-  HBO.da.walkCoeff
                        
HBO.tr.wait1Coeff       <- -0.0500
HBO.tr.wait2Coeff       <- -0.0500
HBO.tr.walkCoeff        <-  HBO.da.walkCoeff
HBO.tr.transCoeff       <- -0.16
HBO.tr.logMixRetPCoeff  <-  0.203
HBO.tr.logMixTotACoeff  <-  0.213
HBO.tr.trOVIVCoeff      <- -1.000

HBO.bk.inbikeCoeff      <-  1.03
HBO.bk.ubdistCoeff      <- -0.223
HBO.bk.nbcostCoeff      <-  0.199
HBO.bk.logMixTotACoeff  <-  0.212

HBO.wk.walkCoeff        <- HBO.da.walkCoeff
HBO.wk.logMixRetPCoeff  <- 0.188

#markets
HBO.da.cv0              <-  0
HBO.da.cv1              <- -0.704
HBO.da.cv23             <-  0

HBO.dp.cv0              <-  0
HBO.dp.cv1              <- -0.436
HBO.dp.cv23             <-  0
HBO.dp.hh1              <- -1.63
HBO.dp.hh2              <-  0
HBO.dp.hh34             <-  0.889

HBO.pa.cv0              <-  0
HBO.pa.cv123            <-  0
HBO.pa.hh1              <- -1.41
HBO.pa.hh2              <-  0
HBO.pa.hh34             <-  0.256

HBO.tr.cv0              <- 1.96
HBO.tr.cv1              <- 0.665
HBO.tr.cv2              <- 0
HBO.tr.cv3              <- 0

#peak/off-peak factors
HBO.pkfact              <- 0.3853
HBO.opfact              <- 1 - HBO.pkfact


# --------------------------
# HOME-BASED RECREATION (MC)
# estimation model: HBNW_131, 11/14/2016

#constants
HBR.MC.dpconst          <- -1.00
HBR.MC.paconst          <- -0.15
HBR.MC.tranconst        <- -2.70
HBR.MC.prconst          <- -2.00
HBR.MC.bikeconst        <- -1.65
HBR.MC.walkconst        <-  0.70

HBR.LS.dpconst          <- -0.703
HBR.LS.paconst          <- -1.54
HBR.LS.tranconst        <-  0.775
HBR.LS.prconst          <-  HBR.MC.prconst
HBR.LS.bikeconst        <- -1.61
HBR.LS.walkconst        <-  0

#cost coefficients (auto operating)
HBR.low.cc              <- HBO.low.cc
HBR.medium.cc           <- HBO.medium.cc
HBR.high.cc             <- HBO.high.cc

#cost coefficients (auto out of pocket: parking and tolls)
HBR.low.pktc            <- HBO.low.pktc
HBR.medium.pktc         <- HBO.medium.pktc
HBR.high.pktc           <- HBO.high.pktc

#cost coefficients (transit fares)
HBR.low.faresc          <- HBR.low.cc
HBR.medium.faresc       <- HBR.medium.cc
HBR.high.faresc         <- HBR.high.cc

#division of cost among HOV drivers and passengers
HBR.dp.autoCostFac      <- HBO.dp.autoCostFac
HBR.pa.autoCostFac      <- HBO.pa.autoCostFac

#coefficients
HBR.ivCoeff             <- HBO.ivCoeff

HBR.da.walkCoeff        <- HBO.da.walkCoeff
HBR.dp.walkCoeff        <- HBR.da.walkCoeff
HBR.pa.walkCoeff        <- HBR.da.walkCoeff
                        
HBR.tr.wait1Coeff       <- HBO.tr.wait1Coeff
HBR.tr.wait2Coeff       <- HBO.tr.wait2Coeff
HBR.tr.walkCoeff        <- HBR.da.walkCoeff
HBR.tr.transCoeff       <- HBO.tr.transCoeff
HBR.tr.logMixRetPCoeff  <- HBO.tr.logMixRetPCoeff
HBR.tr.logMixTotACoeff  <- HBO.tr.logMixTotACoeff
HBR.tr.trOVIVCoeff      <- HBO.tr.trOVIVCoeff

HBR.bk.inbikeCoeff      <- HBO.bk.inbikeCoeff
HBR.bk.ubdistCoeff      <- HBO.bk.ubdistCoeff
HBR.bk.nbcostCoeff      <- HBO.bk.nbcostCoeff
HBR.bk.logMixTotACoeff  <- HBO.bk.logMixTotACoeff

HBR.wk.walkCoeff        <- HBR.da.walkCoeff
HBR.wk.logMixRetPCoeff  <- HBO.wk.logMixRetPCoeff

#markets
HBR.da.cv0              <- HBO.da.cv0
HBR.da.cv1              <- HBO.da.cv1
HBR.da.cv23             <- HBO.da.cv23

HBR.dp.cv0              <- HBO.dp.cv0
HBR.dp.cv1              <- HBO.dp.cv1
HBR.dp.cv23             <- HBO.dp.cv23
HBR.dp.hh1              <- HBO.dp.hh1
HBR.dp.hh2              <- HBO.dp.hh2
HBR.dp.hh34             <- HBO.dp.hh34

HBR.pa.cv0              <- HBO.pa.cv0
HBR.pa.cv123            <- HBO.pa.cv123
HBR.pa.hh1              <- HBO.pa.hh1
HBR.pa.hh2              <- HBO.pa.hh2
HBR.pa.hh34             <- HBO.pa.hh34

HBR.tr.cv0              <- HBO.tr.cv0
HBR.tr.cv1              <- HBO.tr.cv1
HBR.tr.cv2              <- HBO.tr.cv2
HBR.tr.cv3              <- HBO.tr.cv3

#peak/off-peak factors
HBR.pkfact              <- 0.3650
HBR.opfact              <- 1 - HBR.pkfact


# ------------------------
# HOME-BASED SHOPPING (MC)
# estimation model: HBNW_131, 11/14/2016

#constants
HBS.MC.dpconst          <- -1.40
HBS.MC.paconst          <- -0.85
HBS.MC.tranconst        <- -3.00
HBS.MC.prconst          <- -3.10
HBS.MC.bikeconst        <- -2.65
HBS.MC.walkconst        <- -0.80

HBS.LS.dpconst          <- -1.06
HBS.LS.paconst          <- -1.65
HBS.LS.tranconst        <-  1.32
HBS.LS.prconst          <-  HBS.MC.prconst
HBS.LS.bikeconst        <- -1.92
HBS.LS.walkconst        <- -0.197

#cost coefficients (auto operating)
HBS.low.cc              <- HBO.low.cc
HBS.medium.cc           <- HBO.medium.cc
HBS.high.cc             <- HBO.high.cc

#cost coefficients (auto out of pocket: parking and tolls)
HBS.low.pktc            <- HBO.low.pktc
HBS.medium.pktc         <- HBO.medium.pktc
HBS.high.pktc           <- HBO.high.pktc

#cost coefficients (transit fares)
HBS.low.faresc          <- HBS.low.cc
HBS.medium.faresc       <- HBS.medium.cc
HBS.high.faresc         <- HBS.high.cc

#division of cost among HOV drivers and passengers
HBS.dp.autoCostFac      <- HBO.dp.autoCostFac
HBS.pa.autoCostFac      <- HBO.pa.autoCostFac

#coefficients
HBS.ivCoeff             <- HBO.ivCoeff

HBS.da.walkCoeff        <- HBO.da.walkCoeff
HBS.dp.walkCoeff        <- HBS.da.walkCoeff
HBS.pa.walkCoeff        <- HBS.da.walkCoeff
                        
HBS.tr.wait1Coeff       <- HBO.tr.wait1Coeff
HBS.tr.wait2Coeff       <- HBO.tr.wait2Coeff
HBS.tr.walkCoeff        <- HBS.da.walkCoeff
HBS.tr.transCoeff       <- HBO.tr.transCoeff
HBS.tr.logMixRetPCoeff  <- HBO.tr.logMixRetPCoeff
HBS.tr.logMixTotACoeff  <- HBO.tr.logMixTotACoeff
HBS.tr.trOVIVCoeff      <- HBO.tr.trOVIVCoeff

HBS.bk.inbikeCoeff      <- HBO.bk.inbikeCoeff
HBS.bk.ubdistCoeff      <- HBO.bk.ubdistCoeff
HBS.bk.nbcostCoeff      <- HBO.bk.nbcostCoeff
HBS.bk.logMixTotACoeff  <- HBO.bk.logMixTotACoeff

HBS.wk.walkCoeff        <- HBS.da.walkCoeff
HBS.wk.logMixRetPCoeff  <- HBO.wk.logMixRetPCoeff

#markets
HBS.da.cv0              <- HBO.da.cv0
HBS.da.cv1              <- HBO.da.cv1
HBS.da.cv23             <- HBO.da.cv23

HBS.dp.cv0              <- HBO.dp.cv0
HBS.dp.cv1              <- HBO.dp.cv1
HBS.dp.cv23             <- HBO.dp.cv23
HBS.dp.hh1              <- HBO.dp.hh1
HBS.dp.hh2              <- HBO.dp.hh2
HBS.dp.hh34             <- HBO.dp.hh34

HBS.pa.cv0              <- HBO.pa.cv0
HBS.pa.cv123            <- HBO.pa.cv123
HBS.pa.hh1              <- HBO.pa.hh1
HBS.pa.hh2              <- HBO.pa.hh2
HBS.pa.hh34             <- HBO.pa.hh34

HBS.tr.cv0              <- HBO.tr.cv0
HBS.tr.cv1              <- HBO.tr.cv1
HBS.tr.cv2              <- HBO.tr.cv2
HBS.tr.cv3              <- HBO.tr.cv3

#peak/off-peak factors
HBS.pkfact              <- 0.3390
HBS.opfact              <- 1 - HBS.pkfact


# ------------------------
# NON-HOME-BASED WORK (MC)
# estimation model: NHW_310, 11/14/2016

#constants
NHW.MC.dpconst          <- -2.20
NHW.MC.paconst          <- -2.60
NHW.MC.tranconst        <-  0.50
NHW.MC.bikeconst        <- -3.55
NHW.MC.walkconst        <- -1.15

NHW.LS.dpconst          <- -2.45
NHW.LS.paconst          <- -3.03
NHW.LS.tranconst        <-  0.759
NHW.LS.bikeconst        <- -3.33
NHW.LS.walkconst        <-  0

#cost coefficients (auto operating)
NHW.all.cc              <- -0.194

#cost coefficients (auto out of pocket: parking and tolls)
NHW.all.pktc            <- -0.557

#cost coefficients (transit fares)
NHW.all.faresc          <- NHW.all.cc

#division of cost among HOV drivers and passengers
NHW.dp.autoCostFac      <- 0.6667
NHW.pa.autoCostFac      <- 0.3333

#coefficients
NHW.ivCoeff             <- -0.0452

NHW.da.walkCoeff        <- -0.157
NHW.dp.walkCoeff        <-  NHW.da.walkCoeff
NHW.pa.walkCoeff        <-  NHW.da.walkCoeff

NHW.tr.wait1Coeff       <- -0.1180
NHW.tr.wait2Coeff       <- -0.1180
NHW.tr.walkCoeff        <-  NHW.da.walkCoeff
NHW.tr.transCoeff       <- -0.16
NHW.tr.trOVIVCoeff      <- -1.000

NHW.bk.inbikeCoeff      <-  1.13
NHW.bk.ubdistCoeff      <- -0.22
NHW.bk.nbcostCoeff      <-  0.0841
NHW.bk.logMixTotACoeff  <-  0.10

NHW.wk.walkCoeff        <- NHW.da.walkCoeff
NHW.wk.logMixRetPCoeff  <- 0.248

#peak/off-peak factors
NHW.pkfact              <- 0.4623
NHW.opfact              <- 1 - NHW.pkfact


# ----------------------------
# NON-HOME-BASED NON-WORK (MC)
# estimation model: NHNW_311, 11/14/2016

#constants
NHNW.MC.dpconst         <- -0.40
NHNW.MC.paconst         <- -0.30
NHNW.MC.tranconst       <-  0.79
NHNW.MC.bikeconst       <- -3.30
NHNW.MC.walkconst       <- -2.25

NHNW.LS.dpconst         <- -0.379
NHNW.LS.paconst         <- -1.33
NHNW.LS.tranconst       <-  0.329
NHNW.LS.bikeconst       <- -2.76
NHNW.LS.walkconst       <- -0.438

#cost coefficients (auto operating)
NHNW.all.cc              <- -0.150

#cost coefficients (auto out of pocket: parking and tolls)
NHNW.all.pktc            <- -0.335

#cost coefficients (transit fares)
NHNW.all.faresc          <- NHNW.all.cc

#division of cost among HOV drivers and passengers
NHNW.dp.autoCostFac      <- 0.6667
NHNW.pa.autoCostFac      <- 0.3333

#coefficients
NHNW.ivCoeff            <- -0.0278

NHNW.da.walkCoeff       <- -0.125
NHNW.dp.walkCoeff       <- NHNW.da.walkCoeff
NHNW.pa.walkCoeff       <- NHNW.da.walkCoeff

NHNW.tr.wait1Coeff      <- -0.0781
NHNW.tr.wait2Coeff      <- -0.0841
NHNW.tr.walkCoeff       <- NHNW.da.walkCoeff
NHNW.tr.transCoeff      <- -0.16
NHNW.tr.trOVIVCoeff     <- -1.000

NHNW.bk.inbikeCoeff     <-  1.13
NHNW.bk.ubdistCoeff     <- -0.453
NHNW.bk.nbcostCoeff     <-  0.13
NHNW.bk.logMixTotACoeff <-  0.172

NHNW.wk.walkCoeff       <- NHNW.da.walkCoeff
NHNW.wk.logMixRetPCoeff <- 0.301

#peak/off-peak factors
NHNW.pkfact             <- 0.3495
NHNW.opfact             <- 1 - NHNW.pkfact


########################################################
# ---------- PARK-AND-RIDE LOT CHOICE MODEL ---------- #
########################################################

PNR.autoWeight        <- 2.0

PNR.cvConstant        <-  0
HBW.cv1Constant       <- -1.498

#coefficients
PNR.pnrNestCoeff      <- 0.75
PNR.formalNestCoeff   <- 0.5
PNR.informalNestCoeff <- 0.5
PNR.lotParkCostCoeff  <- 0

#vehicle occupancy factors
HBW.vehOccFactor      <- 1.0595
HBC.vehOccFactor      <- 1.083333
HBO.vehOccFactor      <- 1.258065
HBR.vehOccFactor      <- 1.954545
HBS.vehOccFactor      <- 1.789474

#formal and informal nest constants
HBW.formalConstant    <-  0
HBC.formalConstant    <-  0
HBO.formalConstant    <-  0
HBR.formalConstant    <-  HBO.formalConstant
HBS.formalConstant    <-  HBO.formalConstant
HBW.informalConstant  <- -5.0
HBC.informalConstant  <- -6.0
HBO.informalConstant  <- -4.5
HBR.informalConstant  <-  HBO.informalConstant
HBS.informalConstant  <-  HBO.informalConstant
