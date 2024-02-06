library(raster)
library(spatialwarnings)
library(poweRlaw)
library(ggplot2)

################ Spatialwarnings ################
##  Select the raster
setwd("A:/Work")
r1 <- raster('file path')     # Selecting a Raster File
s1 <- as.matrix(r1)                                     # Converting the raster into a matrix

s1[s1<0.5804]<-0                                        # Making it binary such that any value below the threshold is zero
s1[s1>=0.5804]<-1                                       # and any value above a threshold is 1

r2 <- raster('file path')     # Selecting a second raster File
s2 <- as.matrix(r2)                                     # and converting the raster into a matrix
                                                        # same as done in the raster above
s2[s2<0.5843]<-0
s2[s2>=0.5843]<-1

## Subtracting both matrices from one another to get information of
s3<-s2-s1                         #vegetation gained over the years
s3[s3<0]<-0

s4<-(-s2-s1)                       #vegetation lost over the years      
s4[s3<0]<-0

## For Vegetation Gained over the years
t1<-matrix(as.logical(s3), dim(s3))             # Converting the binary matrix to a logical matrix
cs1<-patchsizes(t1, nbmask = "moore")           # To produce a list of cluster sizes  #nbmask is used to define type of neighbourhood. Uses Von Neumann by default
c_xmin1<-xmin_estim(cs1)                        # Estimate Xmin
c_xmin1

## For Vegetation Lost over the years
t2<-matrix(as.logical(s4), dim(s4))             # Converting the binary matrix to a logical matrix
cs2<-patchsizes(t2, nbmask = "moore")           # To produce a list of cluster sizes 
c_xmin2<-xmin_estim(cs2)                        # Estimate Xmin
c_xmin2

##  Produce a inverse-cdf of cluster size
cdist1<- patchdistr_sews(t1,xmin=c_xmin1, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot1<- plot_distr(cdist1, best_only = FALSE)

cdist2<- patchdistr_sews(t2,xmin=c_xmin2, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot2<- plot_distr(cdist2, best_only = FALSE)

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot1
dev.off()

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot2
dev.off()

################ poweRlaw ################

## Use the list of cluster sizes to produce a cluster size distribution
## For vegetation gained within the years
cd1=conpl$new(cs1)
par_cd1<-estimate_pars(cd1)
xmin_cd1<-estimate_xmin(cd1, xmax = max(cs1))
cd1$setXmin(xmin_cd1)
xmin_cd1
x.name=c("Patchsize")
y.name=c("P(X<x)")

##Saving the image as a jpeg file
jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd1<-plot(cd1, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd11", xlab=x.name, ylab=y.name)
lnpl1<-lines(cd1,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)                     # Using parameters from xmin_cd1
dev.off()

## Use the list of cluster sizes to produce a cluster size distribution
## For vegetation gained within the years
cd2=conpl$new(cs2)
par_cd2<-estimate_pars(cd2)
xmin_cd2<-estimate_xmin(cd2, xmax = max(cs2))
cd2$setXmin(xmin_cd2)
xmin_cd2
x.name=c("Patchsize")
y.name=c("P(X<x)")

##Saving the image as a jpeg file
jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd2<-plot(cd2, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd12", xlab=x.name, ylab=y.name)
lnpl2<-lines(cd2,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)                     # Using parameters from xmin_cd2
dev.off()

##############
cs3<-append(cs1,cs2)                                    # Joining both lists to get a list of net change in cluster sizes 
cd3=conpl$new(cs3)                                      # Use the list of cluster sizes to produce a cluster size distribution
par_cd3<-estimate_pars(cd3)
xmin_cd3<-estimate_xmin(cd3, xmax = max(cs3))
cd3$setXmin(xmin_cd3)
xmin_cd3
x.name=c("Patchsize")
y.name=c("P(X<x)")

##Saving the image as a jpeg file
jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
plotcd3<-plot(cd3, xlim=c(1,1000000), ylim=c(0.000001,1),main="Pd13", xlab=x.name, ylab=y.name)
lnpl3<-lines(cd3,col=3)
legend("topright", legend=c("PlXmin = 77", "PlExpo = 2.23"), cex=1)                     # Using parameters from xmin_cd3
dev.off()

############################################################################
################## Same as above, but with Von Neumann #####################
############################################################################
t1<-matrix(as.logical(s3), dim(s3))
cs1<-patchsizes(t1)
c_xmin1<-xmin_estim(cs1)
c_xmin1

##Patches Lost
t2<-matrix(as.logical(s4), dim(s4))
cs2<-patchsizes(t2)
c_xmin2<-xmin_estim(cs2)
c_xmin2

cdist1<- patchdistr_sews(t1,xmin=c_xmin1, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot1<- plot_distr(cdist1, best_only = FALSE)

cdist2<- patchdistr_sews(t2,xmin=c_xmin2, fit_lnorm=TRUE, nbmask = "moore") ##Merge=TRUE uses all possible fits
cdistplot2<- plot_distr(cdist2, best_only = FALSE)

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
cdistplot1
dev.off()

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
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

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
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

jpeg(filename = "file path.jpeg", width = 950, height = 950, units = "px", pointsize = 15, quality = 100)
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
