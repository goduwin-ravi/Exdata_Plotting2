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
## Question-3:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.


## **********************************************************************
## Reading input file. This could take a few seconds. Be Patient!
DF <- data.frame(readRDS(file1))


## **********************************************************************
## Select and organize data for the graph. This could take a few more seconds. Be Patient!
DF1 <- sqldf("select year as year, type as type, sum(Emissions) as emissions from DF 
                  where fips=24510
                  group by year, type order by year, type")
DF1


## **********************************************************************
## Plotting graph using PNG device
png(filename="./plot3.png")

ggplot(DF1, aes(x = year, y = emissions)) + geom_line() + geom_point() + facet_grid(type ~ .)


## **********************************************************************
## Close graphics device
dev.off()

## Close SQL connections
sqldf()


