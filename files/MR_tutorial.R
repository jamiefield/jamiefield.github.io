##Set the working directory
##NOTE TO CLASS: YOU WILL HAVE TO EDIT THE FOLLOWING COMMAND TO MATCH YOUR WORKING DIRECTORY##
  setwd("C:/Storage/Dropbox/Digital Measures/WVU 2019/Teaching/MSIR/Module 3 - GLM")

##Import data file
##NOTE TO CLASS: YOU WILL HAVE TO EDIT THE FOLLOWING COMMAND TO MATCH YOUR FILE NAME##
  dat <- read.csv("Module 2 Data_v3.csv", header=TRUE, na.strings = "")

##Text-to-columns
##NOTE TO CLASS: USE THE FOLLOWING COMMANDS (LINES 14-26) TO REMOVE A DELIMITER FROM A COLUMN OF DATA
##NOTE TO CLASS: IN THE FOLLOWING COMMAND (LINE 14) YOU MAY HAVE CHANGE THE COLUMN NAME ("employeeID" IN THIS CASE) AND THE DELIMITER SYMBOL ("-" IN THIS CASE)
  dat_temp <- as.data.frame(do.call('rbind', strsplit(as.character(dat$employeeID),'_',fixed=TRUE)))

##Give new names to the new columns
##NOTE TO CLASS: IN THE FOLLOWING COMMAND (LINE 18), I GIVE NAMES TO THE NEW COLUMNS OF DATA. YOU MAY NEED TO GIVE DIFFERENT NAMES TO YOUR COLUMNS OF DATA  
  names(dat_temp) <- c("Location", "Department", "Employee")

##Bind the new columns to the original data file
##NOTE TO CLASS: YOU NEED NOT CHANGE THE FOLLOWING COMMAND (LINE 22)
  dat <- as.data.frame(cbind(dat, dat_temp))

##Remove the old employeeID column
##NOTE TO CLASS: IF YOU CHANGED THE COLUMN LABEL IN THE ABOVE COMMAND (SEE LINE 14), YOU WILL HAVE TO MAKE A SIMILAR CHANGE IN THE FOLLOWING COMMAND (LINE 26)
  dat <- subset(dat, select = -c(employeeID))

##Remove data frames that are no longer needed (this step is optional)
  ##NOTE TO CLASS: YOU NEED NOT CHANGE THE FOLLOWING COMMAND (LINE 30)
  rm(dat_temp)

##NOTE TO CLASS: THE COLUMN NAMES THAT APPEAR IN THE PARENTHESES IN THE FOLLOWING COMMAND ("Location," "Employee;" LINE 34) MATCH THE NAMES THAT WERE GIVEN TO THE NEW COLUMNS IN AN ABOVE COMMAND (SEE LINE 18)
  dat$Location <- as.numeric(dat$Location)
  dat$Department <- as.numeric(dat$Department)
  dat$Employee <- as.numeric(dat$Employee)
  
##NOTE TO CLASS: THE FOLLOWING COMMANDS (LINES 37-76) ARE AUTOMATED. AS SUCH, YOU CAN HIGHLIGHT ALL OF THEM AND RUN THEM AT ONCE
  install.packages("moments")
  library(moments) 
  
#Calculate the mean for each column in the dataframe called "dat"
  meanOverall <- as.data.frame(apply(dat, 2, mean))
##Round each mean to the second decimal place
  meanOverall <- round(meanOverall, digits = 2)
##Give the column of means a header called "mean"
  colnames(meanOverall)[1] <- "mean_Overall"

##Do the same for median, SD, skewness, and kurtosis  
  medianOverall <- as.data.frame(apply(dat, 2, median))
  medianOverall <- round(medianOverall, digits = 2)
  colnames(medianOverall)[1] <- "median_Overall"
  
  sdOverall <- as.data.frame(apply(dat, 2, sd))
  sdOverall <- round(sdOverall, digits = 2)
  colnames(sdOverall)[1] <- "SD_Overall"
  
  skewnessOverall <- as.data.frame(apply(dat, 2, skewness))
  skewnessOverall <- round(skewnessOverall, digits = 2)
  colnames(skewnessOverall)[1] <- "skewness_Overall"
  
  kurtosisOverall <- as.data.frame(apply(dat, 2, kurtosis))
  kurtosisOverall <- round(kurtosisOverall, digits = 2)
  colnames(kurtosisOverall)[1] <- "kurtosis_Overall"
  
##Above we created five new dataframes. The following command merges these into a single dataframe
##Importantly, for the "cbind" command to work, each dataframe must have the same number of observations
  overall.descriptive.statistics <- as.data.frame(cbind(meanOverall, medianOverall, sdOverall, skewnessOverall, kurtosisOverall))
  
##The following command saves the descriptive statistics to a .csv file
  write.csv(overall.descriptive.statistics, file = "overall.descriptive.statistics.csv")
  
  rm(meanOverall,
     medianOverall,
     sdOverall,
     skewnessOverall,
     kurtosisOverall)
  
##Create two data subsets, one for females and one for males
##NOTE TO CLASS: IN THE FOLLOWING COMMANDS, WE ARE STRATIFYING THE DATASET BY GENDER. IN OTHER EXAMPLES, YOU MAY WANT TO STRATIFY BY A DIFFERENT VARIABLE (E.G., LOCATION). IN THIS CASE, YOU WILL HAVE TO CHANGE THE LABEL THAT APPEARS AFTER THE '$' (E.G., dat$location)
  dat <- dat[order(dat$Gender),] #this command just reorders the data set by the gender column
  group1 <- dat[ which(dat$Gender=='1'),] #this is the male group
  group2 <- dat[ which(dat$Gender=='2'),] #this is the female group

##Now, let's calculate *all* of the descriptive statistics for both groups (males and females)
##NOTE TO CLASS: IF THE ABOVE COMMANDS ARE EXECUTED CORRECTLY, THEN THE FOLLOWING COMMANDS (LINES 86-131) ARE AUTOMATED. AS SUCH, YOU CAN HIGHLIGHT ALL OF THEM AND RUN THEM AT ONCE 
  meanGroup1 <- as.data.frame(apply(group1, 2, mean))
  meanGroup1 <- round(meanGroup1, digits = 2)
  colnames(meanGroup1)[1] <- "mean_Males"
  medianGroup1 <- as.data.frame(apply(group1, 2, median))
  medianGroup1 <- round(medianGroup1, digits = 2)
  colnames(medianGroup1)[1] <- "median_Males"
  sdGroup1 <- as.data.frame(apply(group1, 2, sd))
  sdGroup1 <- round(sdGroup1, digits = 2)
  colnames(sdGroup1)[1] <- "SD_Males"
  skewnessGroup1 <- as.data.frame(apply(group1, 2, skewness))
  skewnessGroup1 <- round(skewnessGroup1, digits = 2)
  colnames(skewnessGroup1)[1] <- "skewness_Males"
  kurtosisGroup1 <- as.data.frame(apply(group1, 2, kurtosis))
  kurtosisGroup1 <- round(kurtosisGroup1, digits = 2)
  colnames(kurtosisGroup1)[1] <- "kurtosis_Males"
  group1.descriptive.statistics <- as.data.frame(cbind(meanGroup1, medianGroup1, sdGroup1, skewnessGroup1, kurtosisGroup1))
  
  meanGroup2 <- as.data.frame(apply(group2, 2, mean))
  meanGroup2 <- round(meanGroup2, digits = 2)
  colnames(meanGroup2)[1] <- "mean_Females"
  medianGroup2 <- as.data.frame(apply(group2, 2, median))
  medianGroup2 <- round(medianGroup2, digits = 2)
  colnames(medianGroup2)[1] <- "median_Females"
  sdGroup2 <- as.data.frame(apply(group2, 2, sd))
  sdGroup2 <- round(sdGroup2, digits = 2)
  colnames(sdGroup2)[1] <- "SD_Females"
  skewnessGroup2 <- as.data.frame(apply(group2, 2, skewness))
  skewnessGroup2 <- round(skewnessGroup2, digits = 2)
  colnames(skewnessGroup2)[1] <- "skewness_Females"
  kurtosisGroup2 <- as.data.frame(apply(group2, 2, kurtosis))
  kurtosisGroup2 <- round(kurtosisGroup2, digits = 2)
  colnames(kurtosisGroup2)[1] <- "kurtosis_Females"
  group2.descriptive.statistics <- as.data.frame(cbind(meanGroup2, medianGroup2, sdGroup2, skewnessGroup2, kurtosisGroup2))
  
  countGroup1 <- nrow(group1)
  countGroup2 <- nrow(group2)
  countAll <- countGroup1 + countGroup2
  
  relative.frequency.Group1 <- countGroup1/countAll
  relative.frequency.Group2 <- countGroup2/countAll
  relative.frequency <- as.data.frame(cbind(countGroup1, countGroup2, relative.frequency.Group1, relative.frequency.Group2))
  
  overall.descriptive.statistics <- as.data.frame(cbind(overall.descriptive.statistics, group1.descriptive.statistics, group2.descriptive.statistics))
  
##The following command saves the descriptive statistics to a .csv file
  write.csv(overall.descriptive.statistics, file = "overall.descriptive.statistics.csv")
  write.csv(relative.frequency, file = "relative.frequency.csv")
  
  rm(meanGroup1, meanGroup2,
     medianGroup1, medianGroup2,
     sdGroup1, sdGroup2,
     skewnessGroup1, skewnessGroup2,
     kurtosisGroup1, kurtosisGroup2
  )
  
##Compare means across genders
##NOTE TO CLASS: IN THE RUNNING EXAMPLE, WE ARE INTERESTED IN COMPARING AVERAGE PERFORMANCE FOR MALES VS. FEMALES. IF YOU WANT TO EXAMINE PERFORMANCE LEVELS IN DIFFERENT SUB-GROUPS (E.G., LOCATION), YOU WILL HAVE TO CHANGE "dat$gender" to "dat$XXX" IN THE FOLLOWING COMMAND (LINE 134)
  means <- aggregate(dat[, 2:7], list(dat$Gender), mean)

#Rename column
##NOTE TO CLASS: GIVE THE APPROPRIATE LABEL TO THE VARIABLE YOU ARE INTERESTED IN COMPARING ACROSS
  colnames(means)[colnames(means)=="Group.1"] <- "Gender"

##Transform 1 and 2 to Male and Female, respectively
##NOTE TO CLASS: GIVE THE APPROPRIATE SUB-GROUP LABELS (CAUTION: MAKE SURE THAT THE LABELS MATCH THE APPROPRIATE NUMBER; IT WOULD BE WRONG TO REPLACE ALL INSTANCES OF "2" WITH "MALE")
  means$Gender[means$Gender==1]<-"Male"
  means$Gender[means$Gender==2]<-"Female"
  
  meansT <- as.data.frame(t(means))

##Plot by group
##First, let's define the important characteristics of the plot
##The plot to be produced will compare average level of performance for male vs. female;
##The plot axis labels and title are defined and the x-axis will range from 0 to 10
##NOTE TO CLASS: DEFINE THE FOLLOWING 
  x <- means$Gender #this defines what will appear on the x-axis (in this case we are comparing males vs. females)
  y <- round(means$Performance,2) #this deines what will appear on the y-axis (or what is actually being compared)
  z <- means$Gender #make sure that this matches what appears in Line 161
  ylab <- "Mean performance rating" #defines the y-axis label
  xlab <- "Gender" #defines the x-axis label
  min <- 0 #defines the minimum value of the y-axis (note that we don't do this for the x-axis because "male" and "female" will appear there)
  max <- 10 #defines the maximum value of the y-axis (note that we don't do this for the x-axis because "male" and "female" will appear there)
  by <- 1 #defines how the y-axis range will be incremented (for very wide ranges [i.e., when your maximum value is large], I suggest using a larger number here, maybe 3, 5, or 10)
  plotTitle <- "Fig. 1 - Comparing Average Male and Female Job Performance" #defines the chart title

##Now, let's plot the comparison
##NOTE TO CLASS: IF THE ABOVE COMMANDS ARE EXECUTED CORRECTLY (LINES 161-169), THE FOLLOWING COMMANDS ARE AUTOMATIC (LINES 176-196). AS SUCH, YOU CAN HIGHLIGHT ALL OF THEM AND RUN THEM AT ONCE 
  install.packages("ggplot2")
  library(ggplot2)
  
  figure1 <- ggplot(means, aes(x=x, y=y, fill=z))+
    geom_bar(position=position_dodge(), stat="identity",
             colour="black", # Use black outlines
             size=.3) +
    geom_text(aes(label=y), position=position_dodge(width=0.9), vjust=-0.25) +
    scale_y_continuous(name = ylab, breaks = seq(min, max, by), limits=c(min, max)) +
    xlab(xlab) +
    ggtitle(plotTitle) +
    theme_bw()+
    theme(plot.title = element_text(size = 10, face =  "bold")) +
    theme(legend.position = "none") +
    theme(panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line.x = element_line(colour = "black"),
          axis.line.y = element_line(colour = "black"))
  
  figure1
  
##Save plot to working directory
  ggsave(paste0(plotTitle,".png"))
  
##Let's conduct a t-test to statistically examine whether or not males vs. females differ on job performance
##Now, let's define some parameters and conduct the t-test
##NOTE TO CLASS: ASSUMING THAT OUR GROUPS ARE PROPERLY IDENTIFIED (SEE LINES 81 AND 82), ALL WE NEED TO DO IS TO SPECIFY WHAT NEEDS TO BE COMPARED. IN THIS EXAMPLE, WE WANT TO COMPARE "PERFORMANCE" ACROSS LEVELS OF GENDER. IF WE WANTED TO COMPARE SOMETHING ELSE (E.G., JOB SATISFACTION), THEN WE WOULD CHANGE WHAT APPEARS AFTER THE DOLLAR SIGN ($) IN THE FOLLOWING COMMANDS (LINES 201 AND 202)
  x <- group1$Performance
  y <- group2$Performance

##First, we need to test for homoscedasticity (i.e., are the groups homogenous). We do this by conducting a Fishers F-test
##If the p-value from this test is p > .05 (greater than .05), then you can assume that the variances of both samples are homogenous. 
##In this case, we run a classic Student's two-sample t-test by setting the parameter var.equal = TRUE
##If the p-value from this test is p < .05 (less than .05), then you can assume that the variances of both samples are not homogenous. 
##In this latter case, we change var.equal = FALSE
##NOTE TO CLASS: THE LAST TWO COMMANDS DO NOT NEED TO BE EDITED (UNLESS THE VAR.TEST RESULT IS P < .05; SEE NOTES IN LINES 204-209)
  var.test(x,y)

  t.test(x, y, alternative = "less", var.equal = TRUE)
  
###########################################################
###########################################################
###########################################################

  ## Install and call the relevant package    
  install.packages("Hmisc")
  library(Hmisc) 
  
  dat <- subset(dat, select = c(Gender:turnoverIntention))
  
## Create a matrix of correlations and corresponding p-values
## Note that this command creates matrices that have data above and below the diagonal
## The data above and below the diagonal are the same -- just reported in a different way
## After we export to a .csv, we can delete the data above (or below) the diagonal because they are redundant
  corrMatrix <- rcorr(as.matrix(dat))
  corrMatrix
  
## Isolate the correlation matrix and save it as a .csv to the working directory
  correlations <- as.data.frame(corrMatrix$r)
  correlations <- round(correlations, digits = 2)
  write.csv(correlations, file = "correlations.csv")
  
## Isolate the p-value matrix and save it as a .csv to the working directory
  pvalues <- corrMatrix$P
  pvalues <- round(pvalues, digits = 2)
  write.csv(pvalues, file = "pvalues.csv")
  
## After saving both .csv files, I suggest merging the matrices into a single matrix
  
###########################################################
###########################################################
###########################################################
  
  ## Simple Linear Regression (i.e., one predictor and one outcome)
  #http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
  
  model <- lm(turnoverIntention ~ Performance, data = dat)
  summary(model)
  
  summary(model)$r.squared

  r <- rcorr(dat$Performance,dat$turnoverIntention)
  r <- r$r[2,1]
  r^2
  
###########################################################
###########################################################
########################################################### 
  
##Multiple Regression (i.e., more than more predictor variable and one outcome variable)
  mr1 <- lm(turnoverIntention ~ Performance + Stress, data = dat)
  summary(mr1)
  
  mr2 <- lm(turnoverIntention ~ Performance + Stress + Gender, data = dat)
  summary(mr2)

  anova(mr1, mr2)  
  
  