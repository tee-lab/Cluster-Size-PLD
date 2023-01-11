library(spatialwarnings)
library(poweRlaw)
library(raster)
library(ggplot2)
################Spatialwarnings################
########Select the raster
r <- raster('H:/1.Part1prjct/Binary map/Senanga12_binary30.tif')
##summary(r)
########COnvert the raster into a matrix
s <- as.matrix(r)
##summary(s)
########Convert the matrix into a logical matrix
t<-matrix(as.logical(s), dim(s))
##summary(t)
########Produce a list of cluster sizes
csize.list<-patchsizes(t)
ssize<-length(csize.list)
########Find the xmin
c_xmin<-xmin_estim(csize.list)
##summary(c_xmin)
########Produce a inverse-cdf of cluster size
cdist<- patchdistr_sews(t, xmin = c_xmin)
##summary(cdist)


##cdist.predict<-predict(cdist, 1000)          ########~ to get components of cdist
##cdist.obs<-cdist.predict$obs
##yofcdist<-cdist.obs$y
##xofcdist<-cdist.obs$patchsize

##linecd<-data.frame(x=xofcdist, y=yofcdist)           ########~ A data frame of patch size and icdf
##class(linecd)
########Plot the inver-cdf of cluster size
cdistplot<- plot_distr(cdist)+geom_ribbon(aes())

summary(cdistplot)
################PoweRlaw################
########Select the list of cluster size
cd=conpl$new(csize.list)
##summary(cd)
########estimate parameters
par_cd<-estimate_pars(cd)
xmin_cd<-estimate_xmin(cd, xmax=1e+06)

########Set the parameters
cd$setXmin(xmin_cd)

########Plot the distribution
x.name=c("Patchsize")
y.name=c("P(X<x)")
distcd<-plot(cd, xlim=c(1,1000000), ylim=c(0.000001,1),main="Sen12_Moore30",sub="PLD", xlab=x.name, ylab=y.name)
lnpl<-lines(cd,col=3)
xmin_cd
##summary(distcd)
##length(distcd$x)
########Bootstrapping
bspl<-bootstrap_p(cd, xmax = 1e+07)
plot(bspl)

########Visualise graphs
lnx<-lnpl$x                 ######## x of lnpl
lny<-lnpl$y                 ######## y of lnpl
plot(lnx,lny)               ######## power law plot
plot(log(lnx),log(lny))     ######## log-log plot

########Fitted line 
fit<-lm(y~ x ,)
summary(fit)
plot(fit)                   ########No idea what it showed

################Checking consistency of dist################(Still need to figure out)
######## produce random PLD with xmin and par
newpl<- rpldis(ssize,xmin=1,alpha=2.097)

cd1=conpl$new(newpl)
cd1$getXmin()
cd1$getPars()

par_cd1<- estimate_pars(cd1)
xmin_cd1<-estimate_xmin(cd1, xmax=1e+06)

cd1$setXmin(xmin_cd1)
cd1$setPars(par_cd1)

plot(cd1, xlim= c(1,100000),ylim= c(0.00001,1), main="Sen12M30Random1",sub="RandomPLD")
lnpl1<-lines(cd1)
xmin_cd1
##fit1<-lm(y~ x ,lnpl1)

######## produce second random PLD with xmin and par
newpl2<- rpldis(ssize,xmin=1,alpha=2.0897)

cd2=conpl$new(newpl2)
cd2$getXmin()
cd2$getPars()

par_cd2<- estimate_pars(cd2)
xmin_cd2<-estimate_xmin(cd2, xmax=1e+06)

cd2$setXmin(xmin_cd2)
cd2$setPars(par_cd2)

plot(cd2, xlim= c(1,100000),ylim= c(0.00001,1), main="Sen12M30Random2",sub="RandomPLD")
lnpl2<-lines(cd2)
xmin_cd2
######## produce third random PLD with xmin and par
newpl3<- rpldis(ssize,xmin=1,alpha=2.040117)

cd3=conpl$new(newpl3)
cd3$getXmin()
cd3$getPars()

par_cd3<- estimate_pars(cd3)
xmin_cd3<-estimate_xmin(cd3, xmax=1e+06)

cd3$setXmin(xmin_cd3)
cd3$setPars(par_cd3)

plot(cd3, xlim= c(1,100000),ylim= c(0.00001,1), main="Sen12M30Random3",sub="RandomPLD")
lnpl3<-lines(cd3)
xmin_cd3
######## produce fourth random PLD with xmin and par
newpl4<- rpldis(ssize,xmin=1,alpha=2.007)

cd4=conpl$new(newpl4)
cd4$getXmin()
cd4$getPars()

par_cd4<- estimate_pars(cd4)
xmin_cd4<-estimate_xmin(cd4, xmax=1e+06)

cd4$setXmin(xmin_cd4)
cd4$setPars(par_cd4)

plot(cd4, xlim= c(1,100000),ylim= c(0.00001,1), main="Sen12M30Random4",sub="RandomPLD")
lnpl4<-lines(cd4)
xmin_cd4
######## Compare Distributions
compare_distributions(cd,cd4)

