# distsum.R - creates 8-district summary - WRS 12/04/02
# adapted from collapse.v2 by Brian Gregor (ODOT)

distsum <- function (mat, desc, ens, digits, rpt, proj, init) {

# INPUT    DESCRIPTION          EXAMPLE
# mat      matrix name          "mf.colldt"
# desc     matrix description   "College Distribution"
# ens      ensemble             "ga"
# digits   max decimal points    3
# rpt      report file name     "dist"
# proj     project name*        "R Test"
# init     user initials*       "wrs"

# *Note:  project and initials do not change - can be predefined in workspace 
# example:  distsum ("mf.colldt", "College Distribution", "ga", 3,
#             "dist", project, initials)

# Set maximum number of digits to report HERE
  maxlen <- 7

# Test for matrix type
  type <- substr (mat, 1, 2) 
  if (type != "mf" && type != "ma") {
    stop ("ERROR:  mat must be mf.* OR ma.*\n")
  }

# Print header lines
  outfile <- file ("tmpfile", "w")
#  if (length (system (paste ("ls ", rpt, ".rpt"test, sep=''),TRUE,TRUE)) == 1) {
#    writeLines ("\f", con=outfile, sep='')
#  }
  writeLines (proj, con=outfile, sep="\n")
  writeLines (paste ("Metro (", toupper (init), ") - ", date(), sep=''),
    con=outfile, sep="\n")
  writeLines (paste (mat, desc, sep=" - "), con=outfile, sep="\n\n")
  for (x in 1:87) {
    writeLines ("-", con=outfile, sep='')
  }
  if (type == "mf") grp="groups" else grp="zones"
  writeLines (paste("\n\n", "        destination ", grp, sep=''),
    con=outfile, sep="\n")
  close (outfile)

# Load ensemble
  enssize <- length (get (paste ("ensemble", ens, sep=".")))
  numdist <- max (get (paste ("ensemble", ens, sep=".")))
  dist.name <- sort (unique (get (paste ("ensemble", ens, sep="."))))
  for (x in 1:numdist) {
    if (x<10) {dist.name[x] <- paste (ens, "0", dist.name[x], sep='')}
    else {dist.name[x] <- paste (ens, dist.name[x], sep='')}
  }
  dist.name <- append (dist.name, "SUM")

# Test for number of zones
  if (type == "mf") numzones <- sqrt (length (get (mat)))
  else numzones <- length (get (mat))
  if (enssize != numzones) {
    stop ("ERROR:  ensemble and matrix sizes do not match")
  }

# Process full matrix
  if (type == "mf") {

    collapse.row <- apply (get (mat), 2, function (x)
      tapply (x, get (paste ("ensemble", ens, sep=".")), sum))
    dist.sum <- t (apply (t (collapse.row), 2, function (x)
      tapply (x, get (paste ("ensemble", ens, sep=".")), sum)))

    ma.rowsum <- append (apply (dist.sum, 1, sum), sum (dist.sum))
    ma.colsum <- apply (dist.sum, 2, sum)
    dist.sum <- cbind (rbind (dist.sum, ma.colsum), ma.rowsum)

    dist.sum <- data.frame (dist.sum)
    names (dist.sum) <- row.names (dist.sum) <- dist.name

    dist.sum <- round (dist.sum, digits)
    for (i in 1:(numdist+1)) {
      for (j in 1:(numdist+1)) {
        if (nchar (dist.sum [i,j]) > maxlen) {
          leftlen <- nchar (strsplit (as.character(dist.sum [i,j]), "\\.") [[1]][1])
          newdig <- maxlen - leftlen - 1 
          newdig [newdig < 0] <- 0
          dist.sum [i,j] <- round (dist.sum[i,j], newdig)
        }
      }
    }

    options (warn = -1)
    write.table (round (dist.sum, digits), "tmpfile", append=T,
      row.names=T, col.names=T, quote=F, sep=",")
#    options (warn = 1)

    tmpfile<-"tmpfile"
    if(.Platform$OS=="unix"){
    system (paste ("awk -f ", R.path,"/src/awk/distsum.awk",
      " -v numdist=", numdist,
      " tmpfile >> ", rpt, ".rpt", sep=''))
    }
    if(.Platform$OS=="windows") {
    shell (paste ("gawk -f ", R.path,"/src/awk/distsum.awk",
      " -v numdist=", numdist,
      " tmpfile >> ", rpt, ".rpt", sep=''))
    }

    if (file.exists("tmpfile") == 1) {system ("rm tmpfile")}
  }

# Process mo/md (array)
  if (type == "ma") {

    foo <- data.frame (get (mat))
    goo <- data.frame (get (paste ("ensemble", ens, sep=".")))
    dist.sum <- apply (foo, 2, function (x) tapply (x, goo, sum))

    ms.totsum <- sum (dist.sum)
    dist.sum <- rbind (dist.sum, ms.totsum)

    dist.sum <- data.frame (dist.sum)
    row.names (dist.sum) <- dist.name
    names (dist.sum) <- "ALL"

    dist.sum <- round (dist.sum, digits)
    for (i in 1:(numdist+1)) {
      if (nchar (dist.sum [i,1]) > maxlen) {
        leftlen <- nchar (strsplit (as.character(dist.sum [i,1]), "\\.") [[1]][1])
        newdig <- maxlen - leftlen - 1
        newdig [newdig < 0] <- 0
        dist.sum [i,1] <- round (dist.sum[i,1], newdig)
      }
    }

    options (warn = -1)
    write.table (round (dist.sum, digits), "tmpfile", append=T,
      row.names=T, col.names=T, quote=F, sep=",")
#    options (warn = 0)
    if(.Platform$OS=="unix"){
    system (paste ("awk -f ", R.path,"/src/awk/distsum.awk",
      " -v numdist=1 tmpfile >> ", rpt, ".rpt", sep=''))
    }
    if(.Platform$OS=="windows"){
    shell (paste ("gawk -f ", R.path,"/src/awk/distsum.awk",
      " -v numdist=1 tmpfile >> ", rpt, ".rpt", sep=''))
    }
    if (file.exists("tmpfile") == 1) {system ("rm tmpfile")}
  }
}

