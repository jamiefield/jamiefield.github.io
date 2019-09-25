##Set the working directory
  setwd("C:/Storage/Dropbox/Digital Measures/WVU 2019/Teaching/MSIR/Module 2 - Means")

##Import data file
  dat <- read.csv("Module 2 Data.csv", header=TRUE, na.strings = "")
  #dat <- read.csv("Module 2_v2.csv", header=TRUE, na.strings = "")
  dat <- read.csv("Module 2_v3.csv", header=TRUE, na.strings = "")

## Text-to-columns
  dat_temp <- data.frame(do.call('rbind', strsplit(as.character(dat$employeeID),'_',fixed=TRUE)))

## Give new names to the new columns
  names(dat_temp) <- c("Location", "Department", "Employee")

##Bind the new columns to the original data file
  dat <- as.data.frame(cbind(dat, dat_temp))

##Remove the old employeeID column
  dat <- subset(dat, select = -c(employeeID))

##Remove data frames that are no longer needed (this step is optional)
  rm(dat_temp)

##Compare means across genders
##Specify the dimension you want to compare across (e.g., males vs. females)
  #dimen <- dat$Gender
  #name <- "Gender"
  
  means <- aggregate(dat[, 3:7], list(dat$Gender), mean)

#Rename column
  colnames(means)[colnames(means)=="Group.1"] <- "Gender"

##Transform 1 and 2 to Male and Female, respectively
  means$Gender[means$Gender==1]<-"Male"
  means$Gender[means$Gender==2]<-"Female"
  
##Plot by group
##First, let's define the important characteristics of the plot
  x <- means$Gender
  y <- round(means$Performance,2)
  z <- means$Gender
  ylab <- "Mean performance rating"
  xlab <- "Gender"
  min <- 0
  max <- 10
  by <- 1
  plotTitle <- "Fig. 1 - Comparing Average Male and Female Job Performance"

##Now, let's plot the comparison
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
  dat <- dat[order(dat$Gender),]
  
  ##Create two data subsets, one for females and one for males
  group1 <- dat[ which(dat$Gender=='1'),]
  group2 <- dat[ which(dat$Gender=='2'),]
  
  
##First, we need to test for homoscedasticity (i.e., are the groups homogenous). We do this by conducting a Fishers F-test
##If the p-value from this test is p > .05 (greater than .05), hen you can assume that the variances of both samples are homogenous. 
##In this case, we run a classic Student's two-sample t-test by setting the parameter var.equal = TRUE
  x <- group1$Performance
  y <- group2$Performance
  var.test(x,y)

  t.test(x, y, var.equal = TRUE)
  
##Now, let's examine a pivot table of the data  
  install.packages("rpivotTable")
  library(rpivotTable)
  
  testPivot <- rpivotTable(dat_new, rows = c("Gender", "Location", "Department"), cols=c("Stress"), width = "100%", height = "400px")
