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
patchsizes(t, nbmask = matrix(c(0, 1, 0, 1, 0, 1, 0, 1, 0)))    ## This gives patch sizes based on Von Neumann neighourhood
patchsizes(t1, nbmask = matrix(c(1, 1, 1, 1, 1, 1, 1, 1, 1)))   ## This gives patch sizes based on Moore neighourhood

'xmin_estim' is used to estimate the xmin parameter 

'patchdistr_sews' is run on the logical matrix and this computes the distribution which can be visualised using 'plot_distr'. 'patchdistr_sews can be customised as follows:
A. To include a lognormal fit, we can use 'lnorm=TRUE'
B. To select the criterion for best fit use 'best_by = x' where x= "AIC","BIC", "AICc". Default is BIC
C. To specify the xmin use 'xmin = ...' 
Example,
patchdistr_sews( x, xmin= y, best_by=AIC, lnorm=TRUE) 
This produced an inverse cdf of patch size distribution from a logicl matrix "x" with xmin value of "y" and fits powr law, exponential and lognormal using AIC criterion

For Senanga 2020 with threshold 40, "patchdistr_sews(t, xmin=c_xmin, fit_lnorm=TRUE)" gives:
[  Spatial Early-Warning: Patch-based indicators

    N(uniq.) Cover Percl.Full Percl.Empt Type PLR
 94319(1054)  0.43      FALSE       TRUE  tpl 52%

The following methods are available: 
as.data.frame display_matrix indictest plot_distr predict  ]

'indicator_psdtype' fits diferent distribution and gives back the AIC, AICc and BIC values
Example
Using it on Senanga 2020 with threshold 40, "indicator_psdtype(t, xmin=c_xmin)"
[    method type npars      AIC     AICc      BIC  best   plexpo      cutoff xmin_fit percolation percolation_empty
pl      ll   pl     1 18969.83 18969.83 18982.21 FALSE 2.415113          NA      332       FALSE              TRUE
tpl     ll  tpl     2     -Inf     -Inf     -Inf  TRUE 2.415113 2.362204724      332       FALSE              TRUE
exp     ll  exp     1 20348.68 20348.68 20361.06 FALSE       NA 0.001251026      332       FALSE              TRUE   ]

'indicator_plrange' to get the power law range
Example
Using it on Senanga 2020 with threshold 40, "indicator_plrange(t)"
[    minsize maxsize xmin_est   plrange
1       1  175677      332 0.5192993    ]

'predict' to get the obseerved and fitted patch size distribution
Example
Using it on Senanga 2020 with threshold 40, "predict(cdist)"
[  $obs                                ##  The observed values
    patchsize           y
1           1 1.000000000
2           2 0.563672219
3           3 0.439646307

$pred                                  ## The predicted values
    type patchsize            y
1     pl       332 1.403747e-02
2     pl       340 1.357168e-02
3     pl       349 1.307837e-02     ]

2. Using poweRlaw package

Here we need the package 'spatialwarnings to obtain the different patch sizes in the raster

First we select the raster file using 'raster'. The raster file is then converted to a logical matrix.

'patchsizes' is used to obtain the list of patches present in the raster. It follows Von neumann neighbourhood as a default, but can be customised for Moore using 'nbmask'
patchsizes(t, nbmask = matrix(c(0, 1, 0, 1, 0, 1, 0, 1, 0)))    ## This gives patch sizes based on Von Neumann neighourhood
patchsizes(t1, nbmask = matrix(c(1, 1, 1, 1, 1, 1, 1, 1, 1)))   ## This gives patch sizes based on Moore neighourhood

'conpl$new(...)' To select the list of cluster sizes to show a continuous power law
Can also use "displ" instead of "conpl" for discrete power law, "disexp" and "conexp" for discrete and continuous exponential respectively and "dislnorm" and "conlnorm" for discrete and continuous log normal respectively.

"estimate_pars" and "estimate_xmin" is used to estimate the exponent and xmin values.
"setXmin" and "setPars" to set the parameters 

"plot" and "line" to visualise the distribution

3. 
"bootstrap_p" to perform bootstrapping and "plot(bootstrap_p)" to visualise the mean value and standard deviation of parameters and p value
