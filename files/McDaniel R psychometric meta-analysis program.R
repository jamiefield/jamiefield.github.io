##  Bring this code into your program with a source command

# This program is conducts an individualy correct meta-analysis of correlations that includes 
# reliability correction of both X and Y and indirect range restrictions corrections for
# indirect range restriction on X
# 
# Created by Mike McDaniel (mamcdani@vcu.edu)   Version July 5, 2016

#Your variable names should be these:
#N  = sample size
#r  = correlation 
#u = ratio of restricted to unrestricted standard deviation on x
#rxxi = relaibility of X in a restricted sample
#ryy = Reliability of Y

## if you are not correcting for range restruction, make the value of u for all observations to be 1

##  Bring this code into your program with a source command

# This program is conducts an individualy correct meta-analysis of correlations that includes 
# reliability correction of both X and Y and indirect range restrictions corrections for
# indirect range restriction on X
# 
# Created by Mike McDaniel (mamcdani@vcu.edu)   Version July 5, 2016

#Your variable names should be these:
#N  = sample size
#r  = correlation 
#u = ratio of restricted to unrestricted standard deviation on x
#rxxi = relaibility of X in a restricted sample
#ryy = Reliability of Y

## if you are not correcting for range restruction, make the value of u for all observations to be 1

#get the number of rows
k = nrow(dat)   
#k

#sum the sample sizes 
sumN <- sum(dat$N) 
#sumN

### Correct for measurement error in both X and Y and indirect range restriction
### The steps notations below refer to steps in Table 2 of Hunter, Schmidt and Le (2006) 

### if r = 0 add a small constant so that division will work
#sprintf("%5.8f",dat$r)
dat$r <- ifelse(dat$r == 0, 0.0000001, dat$r)
#sprintf("%5.8f",dat$r)

#Step 1: correct for measurement error in Y where Y is a measures of construct P. The input
# is correlation between X and Y in the restricted population. The output is the correlation
# between X and P in the restricted population.
dat$rho.XP.i <- dat$r / sqrt(dat$ryy)
#dat$rho.XP.i

#Step 2 assumes that you have the reliablilty of X in an unrestricted population and
#need to calculate the reliability of X in a restricted population.  In most circumstances,
#one does not have the reliablilty of X in an unrestricted population, but alreday
#know the reliability of X in a restricted population.  Given, this, our next step is #3,

#Step 3: correct for measurement error in X in which X is a measure of construct T. 
dat$rho.TP.i <- dat$rho.XP.i / sqrt(dat$rxxi)  
#dat$rho.TP.i

#Step 4: Estimate the reliability of X in the unrestricted population. The input is the 
#correlation between X and P in the restricted population. The input is range 
#restriction on X (u) and the reliability of X (rxxi) in the restricted population. 
dat$rxx.a <- 1 - ( (dat$u^2) *(1-dat$rxxi) )  
#dat$rxx.a

#Step 5: Estimate the range restriction on T (T is a construct without measurement error).
#The input is the range restriction on X and the reliability of X in the unrestricted population.
dat$u.T <- sqrt( ( (dat$u^2) - (1 - dat$rxx.a))/dat$rxx.a) 
#dat$u.T


#Step 6: Correct for the effects of indirect range restriction. Input is the range 
#restriction on T (the big U) and the correlation between T and P in the unrestricted 
#population dat$rho.TP.1. Output is the correlation between T and P in the unrestricted 
#population (dat$rho.TP.a) 
dat$U.T <- 1/dat$u.T   
#dat$U.T
dat$rho.TP.a <- (dat$U.T * dat$rho.TP.i)/ (sqrt(1 + ((dat$U.T^2 -1) * (dat$rho.TP.i^2)  )  ))
#dat$rho.TP.a

#Now we calulate the sampling error variance of each fully corrected correlation.
#A is the compound artifact correction factor that indicates the ratio of the observed 
#correlation to the #corrected correlation

dat$A <- dat$r/dat$rho.TP.a  
#dat$A

#### calculate sampling error variance for each effect consistent with psychometric meta-analysis ###
#get N weighted mean of observed (uncorrected correlation)
dat$niri <- dat$N*dat$r  
#dat$niri
sumniri <- sum(dat$niri) 
#sumniri 
mean.r <- sumniri/sumN  
print(paste("The mean observed (uncorrected r) is", mean.r))

#get the sampling error variance of the population correlation in 3 steps
#First, get the sampling error of each observed r following the psychometric tradition
#for next line, See Brannick spreadsheet cell Q19:Q23
dat$samplingvar.1 <- (1 - mean.r*mean.r) * (1 - mean.r*mean.r) / (dat$N -1) 
#dat$samplingvar.1
#Second, get a second estimate
dat$samplingvar.2 <- dat$samplingvar.1/(dat$A^2) 
#dat$samplingvar.2
#Third, correct the second sampling variance estimate for the non-linearity of the
#indirect range restriction estimate
dat$arr <- 1 / (  (dat$U.T * dat$U.T - 1) * dat$r * dat$r + 1) 
#dat$arr
dat$samplingvar.3 <- dat$arr^2 * dat$samplingvar.2  
#dat$samplingvar.3

## rename to maintain sanity
dat$Population.r <- dat$rho.TP.a
dat$Pop.r.sampling.variance <- dat$samplingvar.3

## study weight
dat$wi <- dat$N*dat$A^2  
#dat$wi

## sum of the study weights
sum.wi <- sum(dat$wi) 
#sum.wi

## weight the corrected correlation 
dat$wr.c <- dat$wi*dat$rho.TP.a   
#dat$wr.c

#sum the weighted corrected correlations  
sum.wr.c <- sum(dat$wr.c)  
#sum.wr.c

#mean weight corrected correlations   
mean.weighted.corrected.r <- sum.wr.c / sum.wi 
#mean.weighted.corrected.r

#Calculate the observed variance of the corrected correlation
dat$wrc.obs.var.step.1 <- dat$wi * (dat$rho.TP.a - mean.weighted.corrected.r)^2 
#dat$wrc.obs.var.step.1
## Observed variance of corrected correlations
Obs.var.rc <- sum(dat$wrc.obs.var.step.1)/ sum.wi 
#Obs.var.rc
## Observed sd of corrected correlations
Obs.sd.rc <- sqrt(Obs.var.rc)
#Obs.sd.rc

#Average sampling error variance
#weight sampling error variance.v3
dat$Weighted.sampling.error.variance.3 <- dat$wi * dat$samplingvar.3
#dat$Weighted.sampling.error.variance.3

#sampling error variance & its square root
samp.err.var.corrected.r <- sum(dat$Weighted.sampling.error.variance.3)/ sum.wi
#samp.err.var.corrected.r
samp.err.sd.corrected.r <- sqrt(samp.err.var.corrected.r)
#samp.err.sd.corrected.r

#variance of rho
Variance.of.rho <- Obs.var.rc - samp.err.var.corrected.r  
#Variance.of.rho
sd.of.rho <- ifelse(Variance.of.rho > 0, sqrt(Variance.of.rho), 0)
#sd.of.rho 

#standard error or the mean rho
#drawn from p 154 (schmidt & Hunter, 2015)
standard.error.of.mean.corr.r <- sqrt(Obs.var.rc)/ sqrt(k)
#standard.error.of.mean.corr.r

#95% Confidence interval around mean rho
Lower.ci.rho  <- mean.weighted.corrected.r - (1.96 * standard.error.of.mean.corr.r) 
#Lower.ci.rho
Upper.ci.rho  <- mean.weighted.corrected.r + (1.96 * standard.error.of.mean.corr.r) 
#Upper.ci.rho
CI.95per <- paste(sprintf("%5.3f", Lower.ci.rho), "to", sprintf("%5.3f", Upper.ci.rho))
#CI.95per

#80% Credibility interval of population distribution
Lower.80per.CR <- mean.weighted.corrected.r - (1.28 * (sd.of.rho))
#Lower.80per.CR
Upper.80per.CR <- mean.weighted.corrected.r + (1.28 * (sd.of.rho))
#Upper.80per.CR
CR.80per <- paste(sprintf("%5.3f", Lower.80per.CR), "to", sprintf("%5.3f", Upper.80per.CR))
#CR.80per

#Prepare output for display
text.title1 <- "Psychometric Meta-Analysis. Corrections for" 
text.title2 <- "Measurement Error and Indirect Range Restriction" 
Output.Nothing <- " "
text1 <- "Number of correlations"; Outuput.k <- k
text2 <- "Total sample size"; Output.sumN <- sumN
text3 <- "Mean true score correlation (mean rho)"; Output.mean.rho <- sprintf("%5.3f", mean.weighted.corrected.r)
text4 <- "Variance of true score correlations (variance of rho)"; Output.Variance.rho <- sprintf("%5.3f", Variance.of.rho)
text5 <- "Standard deviation of true score correlations (SD of rho)";Output.SD.rho <- sprintf("%5.3f", sd.of.rho)
text6 <- "80% Credibility Interval"; Output.80perCR <- CR.80per
text7 <- "Observed variance of the corrected correlations"; Output.obs.var.rc <- sprintf("%5.3f", Obs.var.rc) 
text8 <- "Observed standard deviation of the corrected correlations"; Output.obs.sd.rc <- sprintf("%5.3f", Obs.sd.rc)
text9 <- "Variance in corrected correlations attributable to all artifacts";
Output.samp.err.var.corrected <- sprintf("%5.3f",samp.err.var.corrected.r)
text10 <- "Standard deviation of corrected correlations predicted from all artifacts"
Output.samp.err.sd.corrected <- sprintf("%5.3f",samp.err.sd.corrected.r)
text11 <- "Standard error of Rho"; Output.standard.error.of.rho <- sprintf("%5.3f",standard.error.of.mean.corr.r)
text12 <- "95% confidence interval of rho mean rho"; Output.CI.95per.of.rho <- CI.95per

Output.Labels <- c(text.title1,text.title2,text1, text2, text3, text4, text5,text6,text7, text8, 
                   text9, text10, text11, text12)
Output.Labels
Output.Vector <- c(Output.Nothing,Output.Nothing,Outuput.k, Output.sumN, Output.mean.rho, 
                   Output.Variance.rho, Output.SD.rho, Output.80perCR,
                   Output.obs.var.rc, Output.obs.sd.rc, Output.samp.err.var.corrected, 
                   Output.samp.err.sd.corrected,
                   Output.standard.error.of.rho, CI.95per )
Output.Vector


output.dataframe <- data.frame(Output.Labels, Output.Vector)
print(output.dataframe)


#write table to clipboard than to Excel then, optionally, can move it into Word
write.table(output.dataframe,file="clipboard",sep="\t",col.names=NA)

print(paste("Output has been copied to the clipboard. Go to Excel or other spreadsheet and paste.")  )

print(paste("In the data file   dat   one can find dat$Population.r which is the estimated population"))
print(paste("correlation and dat$Pop.r.sampling.variance which is the estimated sampling error variance"))
print(paste("of the estimated population correlation."))

