library(raster)
library(poweRlaw)
library(spatialwarnings)

r <- raster('F:/Ashish/1.Part1prjct/Binary map/Senanga20_binary40.tif')
##summary(r)

########Use a CSV file to get the data
r<- read.csv("file path")

########Convert the raster into a matrix
s <- as.matrix(r)
##summary(s)

########Convert the matrix into a logical matrix
t<-matrix(as.logical(s), dim(s))
##summary(t)
########Produce a list of cluster sizes
csize.list<-patchsizes(t)

########      Find the xmin
c_xmin<-xmin_estim(csize.list)
##summary(c_xmin)

########      Fits different distributionand gets back the AIC, BIC and AICc
cdist.indi<-indicator_psdtype(t, xmin=c_xmin, fit_lnorm=TRUE)

########      Trying to remove the percolation cluster
if(cdist.indi$percolation[1] == TRUE){
  d<-which(csize.list == max(csize.list))    ##Finding the largest cluster
  csize.list<-csize.list[-d]                 ##Removing the largest cluster
  c_xmin<-xmin_estim(csize.list)             ##Estimating Xmin using the new list of patchsizes
}

################PoweRlaw################
########Select the list of cluster size
cd=conpl$new(csize.list)
##summary(cd)
######## estimate parameters
xmin_cd<-estimate_xmin(cd, xmax=1e+06)    ##Gives both xmin and the power law exponent. Can replace with estimate_xmin(cd ,xmax=1e+07), but it is usualy a percolating cluster so can be ignored

########Set the parameters
cd$setXmin(xmin_cd)

########Plot the distribution
x.name=c("Patchsize")
y.name=c("P(X<x)")
plot(cd, xlim=c(1,1000000), ylim=c(0.000001,1),main="Name",sub="yr", xlab=x.name, ylab=y.name)
lnpl<-lines(cd,col=3)

########Bootstrapping
bspl<-bootstrap_p(cd, xmax=1e+06)  ##Takes quite some time. Can replace with bootstrap_p(cd, xmax=1e+07) to consider those, but are usually percolating cluster so can be ignored)
plot(bspl)
