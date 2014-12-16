## Install required packages
#install.packages("ggplot2")  #Uncomment this line only if necessary

## Load the required libraries
library(sqldf)
library(ggplot2) 

file1  <- "summarySCC_PM25.rds"
file2  <- "Source_Classification_Code.rds"
keyCol <- "SCC"

## Read file1. This could take a few seconds. Be Patient!
DF <- data.frame(readRDS(file1))

## Select data for the graph
DF1 <- sqldf("select year as year, type as type, sum(Emissions) as emissions from DF 
                  where fips=24510
                  group by year, type order by year, type")

## Plot graph using PNG device
x <- DF1$year
y <- DF1$emissions/1000
type <- 1:4

png(filename="./plot3.png")

qplot(x, y, data=DF1, shape=am, color=am, 
         facets=type, size=I(3),
         main="Emissions by Type for Baltimore", col.main="black", 
         xlab="Year (1999-2008)", ylab="Total Emissions PM25 (in thousand particles)", col.lab="blue") 
#lines(x, y, col="red")

## Close graphics device
dev.off()

## Close SQL connections
sqldf()


