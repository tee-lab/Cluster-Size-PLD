library(raster)
library(spatialwarnings)
library(ggplot2)
################Spatialwarnings################

########Select the raster
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
##summary(csize.list)

########Find the xmin
c_xmin<-xmin_estim(csize.list)
##summary(c_xmin)
########Produce a inverse-cdf of cluster size
cdist<- patchdistr_sews(t, xmin=c_xmin, fit_lnorm=TRUE) ## Merge=TRUE uses all possible fits and merge=FALSE uses only one fit
##summary(cdist)

########Fits different distributionand gets back the AIC, BIC and AICc
cdist.indi<-indicator_psdtype(t, xmin=c_xmin)

########Gives the Power law range
cdist_plrange<-indicator_plrange(t)

######## Used to get the absolute Power law range
cdist.predict<-predict(cdist)          ########~ to get components of cdist

########Plot the inverse-cdf of cluster size
cdistplot<- plot_distr(cdist, best_only = FALSE)
##summary(cdistplot)
