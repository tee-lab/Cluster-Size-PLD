library(raster)
library(spatialwarnings)
library(poweRlaw)
library(ggplot2)

################Spatialwarnings################
########Select the raster
setwd("A:/Work")
r <- raster('Threshold/Sn12_NDVI_N.tif')
s <- as.matrix(r)

dups<-s

s[dups<=0.68]<-1
s[dups>0.68]<-0

t<-matrix(as.logical(s), dim(s))
cs<-patchsizes(t, nbmask = "moore")
c_xmin<-xmin_estim(cs)
c_xmin

##summary(c_xmin)
########Produce a inverse-cdf of cluster size
cdist<- patchdistr_sews(t,xmin=c_xmin, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits

cdistplot<- plot_distr(cdist, best_only = FALSE)

svg(filename = "PLD/Moore/Individual/Sn/Sn12_NDVI_sw.svg", width = 950, height = 950, units = "px", pointsize = 55, res = 125)
cdistplot
dev.off()

cd=conpl$new(cs)
par_cd<-estimate_pars(cd)
xmin_cd<-estimate_xmin(cd, xmax = max(cs))
cd$setXmin(xmin_cd)
xmin_cd
x.name=c("Patchsize")
y.name=c("P(X<x)")

svg(filename = "PLD/Moore/Individual/Sn/Sn12_NDVI_sw.svg", width = 950, height = 950, units = "px", pointsize = 15, res = 125)
plotcd<-plot(cd, xlim=c(1,1000000), ylim=c(0.000001,1),main="Ts12", xlab=x.name, ylab=y.name)
lnpl<-lines(cd,col=3)
legend("topright", legend=c("PlXmin = 1296", "PlExpo = 3.54"), cex=1)
dev.off()

#####

t<-matrix(as.logical(s), dim(s))
cs<-patchsizes(t)
c_xmin<-xmin_estim(cs)
c_xmin

cdist<- patchdistr_sews(t,xmin=c_xmin, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits

cdistplot<- plot_distr(cdist, best_only = FALSE)

svg(filename = "PLD/VonNeumann/Individual/Sn/Sn12_NDVI_sw.svg", width = 950, height = 950, units = "px", pointsize = 15, res = 125)
cdistplot
dev.off()

cd=conpl$new(cs)
par_cd<-estimate_pars(cd)
xmin_cd<-estimate_xmin(cd, xmax = max(cs))
cd$setXmin(xmin_cd)
xmin_cd
x.name=c("Patchsize")
y.name=c("P(X<x)")

svg(filename = "PLD/VonNeumann/Individual/Sn/Sn12_NDVI_.svg", width = 950, height = 950, units = "px", pointsize = 15, quality = 125)
plotcd<-plot(cd, xlim=c(1,1000000), ylim=c(0.000001,1),main="Ts12", xlab=x.name, ylab=y.name)
lnpl<-lines(cd,col=3)
legend("topright", legend=c("PlXmin = 880", "PlExpo = 4.89"), cex=1)
dev.off()
