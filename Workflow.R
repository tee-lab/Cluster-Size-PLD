library(raster)
library(spatialwarnings)
library(poweRlaw)
library(ggplot2)

setwd("A:/Work")
r1 <- raster('Diff NDVI Try Out/Krg12_10_norm.tif')
s1 <- as.matrix(r1)

s1[s1<0.5804]<-0
s1[s1>=0.5804]<-1

r2 <- raster('Diff NDVI Try Out/Krg12_12_norm.tif')
s2 <- as.matrix(r2)

s2[s2<0.5843]<-0
s2[s2>=0.5843]<-1

s3<-s2-s1
s4<-(-s2-s1)

s3[s3<0]<-0
s4[s3<0]<-0

##Patches Gained
t1<-matrix(as.logical(s3), dim(s3))
cs1<-patchsizes(t1, nbmask = "moore")
c_xmin1<-xmin_estim(cs1)
c_xmin1

##Patches Lost
t2<-matrix(as.logical(s4), dim(s4))
cs2<-patchsizes(t2, nbmask = "moore")
c_xmin2<-xmin_estim(cs2)
c_xmin2

cdist1<- patchdistr_sews(t1,xmin=c_xmin1, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot1<- plot_distr(cdist1, best_only = FALSE)

cdist2<- patchdistr_sews(t2,xmin=c_xmin2, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot2<- plot_distr(cdist2, best_only = FALSE)

jpeg(filename = "PLD/Diff_Gain/Pd12_MATLAB_SW_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot1
dev.off()

jpeg(filename = "PLD/Diff_Loss/Pd12_MATLAB_SW_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot2
dev.off()

##PowerLaw##
cd1=conpl$new(cs1)
par_cd1<-estimate_pars(cd1)
xmin_cd1<-estimate_xmin(cd1, xmax = max(cs1))
cd1$setXmin(xmin_cd1)
xmin_cd1
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd1<-plot(cd1, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd11", xlab=x.name, ylab=y.name)
lnpl1<-lines(cd1,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()

##

cd2=conpl$new(cs2)
par_cd2<-estimate_pars(cd2)
xmin_cd2<-estimate_xmin(cd2, xmax = max(cs2))
cd2$setXmin(xmin_cd2)
xmin_cd2
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd2<-plot(cd2, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd12", xlab=x.name, ylab=y.name)
lnpl2<-lines(cd2,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()

##############
cs3<-append(cs1,cs2)
cd3=conpl$new(cs3)
par_cd3<-estimate_pars(cd3)
xmin_cd3<-estimate_xmin(cd3, xmax = max(cs3))
cd3$setXmin(xmin_cd3)
xmin_cd3
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd3<-plot(cd3, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd13", xlab=x.name, ylab=y.name)
lnpl3<-lines(cd3,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()

############################################################################

t1<-matrix(as.logical(s3), dim(s3))
cs1<-patchsizes(t1, nbmask = "moore")
c_xmin1<-xmin_estim(cs1)
c_xmin1

##Patches Lost
t2<-matrix(as.logical(s4), dim(s4))
cs2<-patchsizes(t2, nbmask = "moore")
c_xmin2<-xmin_estim(cs2)
c_xmin2

cdist1<- patchdistr_sews(t1,xmin=c_xmin1, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot1<- plot_distr(cdist1, best_only = FALSE)

cdist2<- patchdistr_sews(t2,xmin=c_xmin2, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot2<- plot_distr(cdist2, best_only = FALSE)

jpeg(filename = "PLD/Diff_Gain/Pd12_MATLAB_SW_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot1
dev.off()

jpeg(filename = "PLD/Diff_Loss/Pd12_MATLAB_SW_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot2
dev.off()

##PowerLaw##
cd1=conpl$new(cs1)
par_cd1<-estimate_pars(cd1)
xmin_cd1<-estimate_xmin(cd1, xmax = max(cs1))
cd1$setXmin(xmin_cd1)
xmin_cd1
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd1<-plot(cd1, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd12", xlab=x.name, ylab=y.name)
lnpl1<-lines(cd1,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()

##

cd2=conpl$new(cs2)
par_cd2<-estimate_pars(cd2)
xmin_cd2<-estimate_xmin(cd2, xmax = max(cs))
cd$setXmin(xmin_cd2)
xmin_cd2
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd2<-plot(cd2, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd12", xlab=x.name, ylab=y.name)
lnpl2<-lines(cd2,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()

###
cs3<-append(cs1,cs2)
cd3=conpl$new(cs3)
par_cd3<-estimate_pars(cd3)
xmin_cd3<-estimate_xmin(cd3, xmax = max(cs3))
cd3$setXmin(xmin_cd3)
xmin_cd3
x.name=c("Patchsize")
y.name=c("P(X<x)")

jpeg(filename = "PLD/Individual/Pd12_MATLAB_PL_PLD.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd3<-plot(cd3, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd13", xlab=x.name, ylab=y.name)
lnpl3<-lines(cd3,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)
dev.off()