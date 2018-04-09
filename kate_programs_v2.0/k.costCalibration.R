# k.costCalibration.R
# Scales costs to current model estimation
# based on 2010 household travel survey
# AAB, 10/09/12
# updated by PGB, 10/2016

# average 2010 auto operating cost derived from BTS, EIA, AAA data
auto_op_cost <- 0.211

# values of time developed by CRC consultant for 2009, inflated to 2010 (*1.02)
peak_vot  <- 19.27
offpk_vot <- 12.82

# adjustment factors set to '1' since costs are in 2010$
pkgCostFac      <- 1
trfareCostFac   <- 1
autocostCostFac <- 1
pkvotCostFac    <- 1
opvotCostFac    <- 1

ma.ltpkg      <- pkgCostFac * ma.ltpkg
ma.stpkg      <- pkgCostFac * ma.stpkg
mf.trfare.mhi <- trfareCostFac * mf.trfare.mhi
mf.trfare.li  <- trfareCostFac * mf.trfare.li
mf.trfare     <- trfareCostFac * mf.trfare
autocost      <- autocostCostFac * auto_op_cost
pkvot         <- pkvotCostFac * peak_vot
opvot         <- opvotCostFac * offpk_vot
