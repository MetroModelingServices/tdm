#k.whia.R
#Worker Model

# Constants & Coefficients
worker0.const       <- 7.9
worker1.const       <- 6.99
worker2.const       <- 5.315
worker0.HHsizeCoeff <- -2.1436
worker1.HHsizeCoeff <- -1.8371
worker2.HHsizeCoeff <- -1.2747

hia <- 0

# Loop through household sizes (1-4)
for (h in 1:4) {

# Loop through incomes (1-4)
  for (i in 1:4) {

# Income Coefficients (iw0 = 0 workers, iw1 = 1 worker, iw2 = 2 workers)
    if (i==1) {iw0 <- 6.1394; iw1 <- 3.7194; iw2 <- 1.2257}
    if (i==2) {iw0 <- 3.0767; iw1 <- 2.265;  iw2 <- 0.7633}
    if (i==3) {iw0 <- 0.9966; iw1 <- 0.7563; iw2 <- 0.2345}
    if (i==4) {iw0 <- 0;      iw1 <- 0;      iw2 <- 0}

# Loop through ages (1-4)
    for (a in 1:4) {

# Age Coefficients (aw0 = 0 workers, aw1 = 1 worker, aw2 = 2 workers)
      if (a==1) {aw0 <- -6.4436; aw1 <- -2.9365; aw2 <- -0.7221}
      if (a==2) {aw0 <- -3.7234; aw1 <- -0.4402; aw2 <- 0.6739}
      if (a==3) {aw0 <- -3.4183; aw1 <- -1.3386; aw2 <- -0.432}
      if (a==4) {aw0 <- 0;       aw1 <- 0;       aw2 <- 0}

      # 0-worker
      Temp0WorkerUtility <- exp(worker0.const + worker0.HHsizeCoeff * h + iw0 + aw0)
      
      # 1-worker
      Temp1WorkerUtility <- exp(worker1.const + worker1.HHsizeCoeff * h + iw1 + aw1)
      
      # 2-worker
      Temp2WorkerUtility <- 0
      if (h>=2) {
        Temp2WorkerUtility <- exp(worker2.const + worker2.HHsizeCoeff * h + iw2 + aw2)
      }

      # 3-worker
      Temp3WorkerUtility <- 0
      if (h>=3) {
        Temp3WorkerUtility <- 1
      }

      WorkerUtilitySum <- Temp0WorkerUtility + Temp1WorkerUtility + Temp2WorkerUtility + Temp3WorkerUtility

      hia <- hia + 1

      temp.w0hia <- Temp0WorkerUtility / WorkerUtilitySum * mf.hia[,hia]
      temp.w1hia <- Temp1WorkerUtility / WorkerUtilitySum * mf.hia[,hia]
      temp.w2hia <- Temp2WorkerUtility / WorkerUtilitySum * mf.hia[,hia]
      temp.w3hia <- Temp3WorkerUtility / WorkerUtilitySum * mf.hia[,hia]

      if (hia==1) {
        mf.w0hia <- temp.w0hia
        mf.w1hia <- temp.w1hia
        mf.w2hia <- temp.w2hia
        mf.w3hia <- temp.w3hia
      }

      else{
        mf.w0hia <- cbind(mf.w0hia, temp.w0hia)
        mf.w1hia <- cbind(mf.w1hia, temp.w1hia)
        mf.w2hia <- cbind(mf.w2hia, temp.w2hia)
        mf.w3hia <- cbind(mf.w3hia, temp.w3hia)
      }
    }
  }
}

mf.whia <- cbind(mf.w0hia, mf.w1hia, mf.w2hia, mf.w3hia)

### SUMMARY STATISTICS (for diagnostic purposes only)

## Total HH by Worker Group
Sum.0WorkerHH <- sum(mf.w0hia)
Sum.1WorkerHH <- sum(mf.w1hia)
Sum.2WorkerHH <- sum(mf.w2hia)
Sum.3WorkerHH <- sum(mf.w3hia)
Sum.AllWorkerHH <- Sum.0WorkerHH + Sum.1WorkerHH + Sum.2WorkerHH + Sum.3WorkerHH

## Total Workers
Sum.AllWorkers  <- Sum.0WorkerHH + Sum.1WorkerHH + Sum.2WorkerHH + Sum.3WorkerHH * 3.27 #3.27 is 2015 factor for 3+ worker households

## Total HH by Worker Group and Household Size
#Sum.0WorkerHHh1 <- apply(mf.w0hia[,1:16],1,sum)
#Sum.0WorkerHHh2 <- apply(mf.w0hia[,17:32],1,sum)
#Sum.0WorkerHHh3 <- apply(mf.w0hia[,33:48],1,sum)
#Sum.0WorkerHHh4 <- apply(mf.w0hia[,49:64],1,sum)
#Sum.1WorkerHHh1 <- apply(mf.w1hia[,1:16],1,sum)
#Sum.1WorkerHHh2 <- apply(mf.w1hia[,17:32],1,sum)
#Sum.1WorkerHHh3 <- apply(mf.w1hia[,33:48],1,sum)
#Sum.1WorkerHHh4 <- apply(mf.w1hia[,49:64],1,sum)
#Sum.2WorkerHHh1 <- apply(mf.w2hia[,1:16],1,sum)
#Sum.2WorkerHHh2 <- apply(mf.w2hia[,17:32],1,sum)
#Sum.2WorkerHHh3 <- apply(mf.w2hia[,33:48],1,sum)
#Sum.2WorkerHHh4 <- apply(mf.w2hia[,49:64],1,sum)
#Sum.3WorkerHHh1 <- apply(mf.w3hia[,1:16],1,sum)
#Sum.3WorkerHHh2 <- apply(mf.w3hia[,17:32],1,sum)
#Sum.3WorkerHHh3 <- apply(mf.w3hia[,33:48],1,sum)
#Sum.3WorkerHHh4 <- apply(mf.w3hia[,49:64],1,sum)
#Sum.AllWorkerHHh <- Sum.0WorkerHHh1 + Sum.0WorkerHHh2 + Sum.0WorkerHHh3 + Sum.0WorkerHHh4 +
#                    Sum.1WorkerHHh1 + Sum.1WorkerHHh2 + Sum.1WorkerHHh3 + Sum.1WorkerHHh4 +
#                    Sum.2WorkerHHh1 + Sum.2WorkerHHh2 + Sum.2WorkerHHh3 + Sum.2WorkerHHh4 +
#                    Sum.3WorkerHHh1 + Sum.3WorkerHHh2 + Sum.3WorkerHHh3 + Sum.3WorkerHHh4
#
## Total HH by Worker Group and Income Level
#Sum.0WorkerHHi1 <- apply(mf.w0hia[,c(1:4,17:20,33:36,49:52)],1,sum)
#Sum.0WorkerHHi2 <- apply(mf.w0hia[,c(5:8,21:24,37:40,53:56)],1,sum)
#Sum.0WorkerHHi3 <- apply(mf.w0hia[,c(9:12,25:28,41:44,57:60)],1,sum)
#Sum.0WorkerHHi4 <- apply(mf.w0hia[,c(13:16,29:32,45:48,61:64)],1,sum)
#Sum.1WorkerHHi1 <- apply(mf.w1hia[,c(1:4,17:20,33:36,49:52)],1,sum)
#Sum.1WorkerHHi2 <- apply(mf.w1hia[,c(5:8,21:24,37:40,53:56)],1,sum)
#Sum.1WorkerHHi3 <- apply(mf.w1hia[,c(9:12,25:28,41:44,57:60)],1,sum)
#Sum.1WorkerHHi4 <- apply(mf.w1hia[,c(13:16,29:32,45:48,61:64)],1,sum)
#Sum.2WorkerHHi1 <- apply(mf.w2hia[,c(1:4,17:20,33:36,49:52)],1,sum)
#Sum.2WorkerHHi2 <- apply(mf.w2hia[,c(5:8,21:24,37:40,53:56)],1,sum)
#Sum.2WorkerHHi3 <- apply(mf.w2hia[,c(9:12,25:28,41:44,57:60)],1,sum)
#Sum.2WorkerHHi4 <- apply(mf.w2hia[,c(13:16,29:32,45:48,61:64)],1,sum)
#Sum.3WorkerHHi1 <- apply(mf.w3hia[,c(1:4,17:20,33:36,49:52)],1,sum)
#Sum.3WorkerHHi2 <- apply(mf.w3hia[,c(5:8,21:24,37:40,53:56)],1,sum)
#Sum.3WorkerHHi3 <- apply(mf.w3hia[,c(9:12,25:28,41:44,57:60)],1,sum)
#Sum.3WorkerHHi4 <- apply(mf.w3hia[,c(13:16,29:32,45:48,61:64)],1,sum)
#Sum.AllWorkerHHi <- Sum.0WorkerHHi1 + Sum.0WorkerHHi2 + Sum.0WorkerHHi3 + Sum.0WorkerHHi4 +
#                    Sum.1WorkerHHi1 + Sum.1WorkerHHi2 + Sum.1WorkerHHi3 + Sum.1WorkerHHi4 +
#                    Sum.2WorkerHHi1 + Sum.2WorkerHHi2 + Sum.2WorkerHHi3 + Sum.2WorkerHHi4 +
#                    Sum.3WorkerHHi1 + Sum.3WorkerHHi2 + Sum.3WorkerHHi3 + Sum.3WorkerHHi4

rm(worker0.const,worker1.const,worker2.const,
   worker0.HHsizeCoeff,worker1.HHsizeCoeff,worker2.HHsizeCoeff,
   hia,h,i,a,
   iw0,iw1,iw2,aw0,aw1,aw2,
   Temp0WorkerUtility,Temp1WorkerUtility,Temp2WorkerUtility,Temp3WorkerUtility,WorkerUtilitySum,
   temp.w0hia,temp.w1hia,temp.w2hia,temp.w3hia)

