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
cdist<- patchdistr_sews(t, merge=TRUE, xmin=332) ##Merge=TRUE uses all possible fits
?patchdistr_sews
##summary(cdist)
cdist.indi<-indicator_psdtype(t, xmin=c_xmin, merge = TRUE)
cdist_plrange<-indicator_plrange(t)
cdist.predict<-predict(cdist, 10000)          ########~ to get components of cdist
?predict
##cdist.obs<-cdist.predict$obs
##yofcdist<-cdist.obs$y
##xofcdist<-cdist.obs$patchsize

##linecd<-data.frame(x=xofcdist, y=yofcdist)           ########~ A data frame of patch size and icdf
##class(linecd)
########Plot the inver-cdf of cluster size
cdistplot<- plot_distr(cdist, best_only = FALSE)
?plot_distr
##summary(cdistplot)

################################################################################################################
################################################################################################################
########Visualise graphs
##lnx<-lnpl$x                 ######## x of lnpl
##lny<-lnpl$y                 ######## y of lnpl
##plot(lnx,lny)               ######## power law plot
##plot(log(lnx),log(lny))     ######## log-log plot

########Fitted line 
##fit<-lm(y~ x ,)
##summary(fit)
plot(fit)                   ########No idea what it showed

################Checking consistency of dist################(Still need to figure out)
######## produce random PLD with xmin and par
newpl<- rpldis(1000,xmin=1,alpha=1.777)

cd2=conpl$new(newpl)
cd2$getXmin()
cd2$getPars()

par_cd2<- estimate_pars(cd2)
xmin_cd2<-estimate_xmin(cd2, xmax=1e+06)

cd2$setXmin(xmin_cd2)
cd2$setPars(par_cd2)

plot(cd2, xlim= c(1,100000),ylim= c(0.00001,1), main="Regression")
lnpl2<-lines(cd2)

fit2<-lm(y~ x ,lnpl2)

######## Compare Distributions
compare_distributions(cd,newpl)
cd
