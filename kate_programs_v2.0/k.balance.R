#  This program uses a balancing scheme similar to the one in Emme2.
#  edited by WRS 11/22/06
balance<-function(mfmat,mo.target,md.target,lmax)
{
iter<-1

while(iter<=lmax)
{
   mo.row.sum<-apply(mfmat,1,sum)
   mo.col.sum<-apply(mfmat,2,sum)
   row.factor<-mo.target/mo.row.sum 
#   row.factor[row.factor[]=="NaN"]<-0
   row.factor[!is.finite(row.factor[])]<-0
   col.factor<-md.target/mo.col.sum
#   col.factor[col.factor[]=="NaN"]<-0
   col.factor[!is.finite(col.factor[])]<-0
   row.factor<-matrix(row.factor,length(row.factor),length(row.factor))
   col.factor<-matrix(col.factor,length(col.factor),length(col.factor),byrow=T)
   mfmat<-mfmat*row.factor*col.factor
   iter<-iter+1
}
mfmat
}
