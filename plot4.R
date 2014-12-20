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
## Question-4:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


## **********************************************************************
## Reading input file. This could take a few seconds. Be Patient!
DF <- data.frame(merge(readRDS(file1),readRDS(file2),by=c(keyCol)))
names(DF) <- gsub(".", "", names(DF), fixed=TRUE)
names(DF) <- gsub("year", "Year", names(DF), fixed=TRUE)


## **********************************************************************
## Select and organize data for the graph. This could take a few more seconds. Be Patient!
colsNeeded <- c("Year", "Emissions", "ShortName")
rowsNeeded <- as.vector(grep("coal",DF$ShortName))
DF <- DF[rowsNeeded, colsNeeded]

require(sqldf)
DF1 <- sqldf("select Year as year, sum(Emissions) as emissions from DF group by year order by year")
DF1


## **********************************************************************
## Plot graph using PNG device
png(filename="./plot4.png")

x <- DF1$year
y <- DF1$emissions

plot(x, y, type="n", main="US Coal Combustion-Related PM25 Emissions", col.main="black", 
     xlab="Year (1999-2008)", ylab="PM25 Emissions", col.lab="blue") 
lines(x, y, col="red")


## **********************************************************************
## Close graphics device
dev.off()

## Close SQL connections
sqldf()


