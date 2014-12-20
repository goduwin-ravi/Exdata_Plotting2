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
## Question-6:
## Compare emissions from motor vehicle sources in Baltimore City (fips="24510") with emissions from 
## motor vehicle sources in Los Angeles County, California (fips="06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?


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

DF2 <- sqldf("select fips as fips, year as year, sum(Emissions) as emissions from DF1 
             where fips in ('24510', '06037') 
             group by fips, year order by fips, year")

## Map fips value to city name
DF2$city <- 0
DF2[DF2$fips=='24510', ]$city <- "Baltimore"
DF2[DF2$fips=='06037', ]$city <- "Los Angeles"
DF2


## **********************************************************************
## Plot graph using PNG device
png(filename="./plot6.png")

ggplot(DF2, aes(x = year, y = emissions)) + geom_line() + geom_point() + facet_grid(city ~ .)


## **********************************************************************
## Close graphics device
dev.off()

## Close SQL connections
sqldf()

