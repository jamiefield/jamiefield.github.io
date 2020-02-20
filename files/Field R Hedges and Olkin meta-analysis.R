# This program conducts a meta-analysis using the Hedges and Olkin approach 

# Created by Jamie Field (james.field2@mail.wvu.edu)   Version Feb, 2020

# Your variable names should be these:
#   N  = sample size
#   r  = correlation 

# Install metafor package (see https://cran.r-project.org/web/packages/metafor/metafor.pdf)
install.packages("metafor")
library(metafor)

# Set the working directory (i.e., point R to the folder that contains your meta-analytic data file[s])
# Uncomment the following line by removing the "#" -- this will active the command
#setwd("INSERT PATH TO YOUR FOLDER HERE")

# Import a meta-analytic data file
# Uncomment the following line by removing the "#" -- this will active the command
#dat <- read.csv("INSERT PATH TO YOUR FOLDER HERE/nameofdatafile.csv") #Frank's path


 datUploaded <- dat
 datRowsOrig <- nrow(dat)
 datOrig <- dat
  
# ADD z (yi) and variance of z (vi)
  dat <- escalc(measure="ZCOR", ri=r, ni=N, data = dat)
  dat$sei <- sqrt(dat$vi)
  
# Sort by sei
  dat <- dat[order(dat$sei),]
  
# Calculate cumulative N values
  dat$cumsumN <- round(cumsum(dat$N), digits = 2)
  dat$cumsumN <- paste0(dat$N," (", dat$cumsumN,")")
  
###########################################################################################################
#THE FOLLOWING IS CODE FOR RANDOM EFFECTS AND FIXED EFFECTS META-ANALYSIS
###########################################################################################################
  
#Run a basic meta on z scores using DerSimonian and Laird estimation method. Then, back-transform to r.
  res <- rma(measure="ZCOR", ri=r, ni=N, data=dat, level=95, method="DL", slab = dat$cumsumN)
  res_raw_r <- rma(measure="COR", ri=r, ni=N, data=dat, level=95, method="DL")
  OUTPUT.naive.RE.SDz <- res$se * sqrt(as.numeric(nrow(dat)))
  OUTPUT.naive.RE.SDr <- res_raw_r$se * sqrt(as.numeric(nrow(dat)))
  res
  
# Report the meta-analytic results
  OUTPUT.naive.RE.k <- as.numeric(nrow(dat))
  OUTPUT.naive.RE.N <- sum(dat$N)
  res.ztor.for.ci <- predict(res, level=95, transf=transf.ztor)
  OUTPUT.naive.RE.mean.r <- res.ztor.for.ci$pred
  OUTPUT.naive.RE.ci.l <- as.numeric(res.ztor.for.ci$ci.lb)
  OUTPUT.naive.RE.ci.h <- as.numeric(res.ztor.for.ci$ci.ub)
  res.ztor.for.pi <- predict(res, level=90, transf=transf.ztor)
  OUTPUT.naive.RE.cr.l <- as.numeric(res.ztor.for.pi$cr.lb)
  OUTPUT.naive.RE.cr.h <- as.numeric(res.ztor.for.pi$cr.ub)
  OUTPUT.naive.RE.QE <- res$QE
  OUTPUT.naive.RE.I2 <- res$I2
  OUTPUT.naive.RE.tau <- res$tau2^.5