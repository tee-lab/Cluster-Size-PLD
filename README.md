# Cluster-Size-PLD

PRODUCING BINARY RASTER FROM SATELLITE IMAGE

In QGIS, produce an NDVI image using multispectral image. The NDVI image is compared with the greyscale image for more precise identification of vegetation. 
A range of values are considered such that the lowest threshold indicates area with a mix of vegetation and bare ground, and the highest value indicates pixels that surely contain vegetation.
A binary map is produced using each threshold, which is analysed in R.
To obtain a map which shows the change in vegetation over years, we just need to subtract one map from the other.

ANALYSING CLUSTER SIZE DISTRIBUTION IN R

1. Using spatialwarnings package

First we select the raster file using 'raster'. The raster file is then converted to a logical matrix.

'patchsizes' is used to obtain the list of patches present in the raster. It follows Von neumann neighbourhood as a default, but can be customised for Moore using 'nbmask'
patchsizes(t1)   ## This gives patch sizes based on Von Neumann neighourhood (Default)
patchsizes(t, nbmask = "moore")    ## This gives patch sizes based on Moore neighourhood

'xmin_estim' is used to estimate the xmin parameter 

'patchdistr_sews' is run on the logical matrix and this computes the distribution which can be visualised using 'plot_distr'. 'patchdistr_sews can be customised as follows:
A. To include a lognormal fit, we can use 'lnorm=TRUE'
B. To select the criterion for best fit use 'best_by = x' where x= "AIC","BIC", "AICc". Default is BIC
C. To specify the xmin use 'xmin = ...' 
Example,
patchdistr_sews( x, xmin= y, best_by=AIC, lnorm=TRUE) 
This produced an inverse cdf of patch size distribution from a logicl matrix "x" with xmin value of "y" and fits power law, exponential and lognormal using AIC criterion


2. Using poweRlaw package

'poweRlaw' package can only be used to fit power laws into the distribution and requires a list of clusters instead of a raster as in 'spatialwarnings'

In case the data we have are raster files, we can use the following functions to convert it into a list of patch sizes
First we select the raster file using 'raster'. The raster file is then converted to a logical matrix.
'patchsizes' is used to obtain the list of patches present in the raster. It follows Von neumann neighbourhood as a default, but can be customised for Moore using 'nbmask'
patchsizes(t1)   ## This gives patch sizes based on Von Neumann neighourhood (Default)
patchsizes(t, nbmask = "moore")    ## This gives patch sizes based on Moore neighourhood

Once this is done, we can use functions from 'poweRlaw' to analyse

'conpl$new(...)' To select the list of cluster sizes to show a continuous power law
Can also use "displ" instead of "conpl" for discrete power law, "disexp" and "conexp" for discrete and continuous exponential respectively and "dislnorm" and "conlnorm" for discrete and continuous log normal respectively.

"estimate_pars" and "estimate_xmin" are used to find the best power law fit for the distribution 
"setXmin" and "setPars" are used to set the values to the distribution.

"plot" and "line" to visualise the distribution
