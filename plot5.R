##
## Install required packages
#install.packages("sqldf")    # Run only if necessary
#install.packages("ggplot2")  # Run only if necessary

## Load required libraries
require(sqldf); library(sqldf)
require(ggplot2); library(ggplot2)

## Initialize variables
file1  <- "summarySCC_PM25.rds"
file2  <- "Source_Classification_Code.rds"
keyCol <- "SCC"


## **********************************************************************
## Question-5:
## How have emissions from motor vehicle sources changed from 1999?2008 in Baltimore City (fips=24510)?


## **********************************************************************
## Read input file. This could take a few seconds. Be Patient!
DF <- data.frame(merge(readRDS(file1),readRDS(file2),by=c(keyCol)))
names(DF) <- gsub(".", "", names(DF), fixed=TRUE)
names(DF)


## **********************************************************************
## Select and organize data for the graph. This could take a few more seconds. Be Patient!
rowsNeeded <- as.vector(grep("motor|Motor", DF$ShortName))  ## All rows that contain the Key Word 
colsNeeded <- c("year", "fips", "Emissions")                ## Columns absolutely needed to generate plot

DF1 <- DF[rowsNeeded, colsNeeded]
DF2 <- sqldf("select year as year, sum(Emissions) as emissions from DF1 
             where fips=24510 group by year order by year")
DF2


## **********************************************************************
## Plot graph using PNG device
png(filename="./plot5.png")

x <- DF2$year
y <- DF2$emissions

plot(x, y, type="n", main="Motor Vehicle-Related PM25 Emissions for Baltimore", col.main="black", 
     xlab="Year (1999-2008)", ylab="PM25 Emissions", col.lab="blue") 
lines(x, y, col="red")


## **********************************************************************
## Close graphics device
dev.off()

## Close SQL connections
sqldf()

