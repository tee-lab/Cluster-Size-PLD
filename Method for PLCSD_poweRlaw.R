library(raster)
library(poweRlaw)
library(spatialwarnings)

r <- raster('F:/Ashish/1.Part1prjct/Binary map/Senanga20_binary40.tif')
##summary(r)
########COnvert the raster into a matrix
s <- as.matrix(r)
##summary(s)
########Convert the matrix into a logical matrix
t<-matrix(as.logical(s), dim(s))
##summary(t)
########Produce a list of cluster sizes
csize.list<-patchsizes(t)

################PoweRlaw################
########Select the list of cluster size
cd=conpl$new(csize.list)
##summary(cd)
########estimate parameters
par_cd<-estimate_pars(cd)
xmin_cd<-estimate_xmin(cd)

########Set the parameters
cd$setXmin(xmin_cd)

########Plot the distribution
x.name=c("Patchsize")
y.name=c("P(X<x)")
plot(cd, xlim=c(1,1000000), ylim=c(0.000001,1),main="Name",sub="yr", xlab=x.name, ylab=y.name)
lnpl<-lines(cd,col=3)

########Bootstrapping
bspl<-bootstrap_p(cd)
plot(bspl)
