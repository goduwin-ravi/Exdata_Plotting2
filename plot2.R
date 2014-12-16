## Load the required libraries
library(sqldf)

file1  <- "summarySCC_PM25.rds"
file2  <- "Source_Classification_Code.rds"
keyCol <- "SCC"

## Read file1. This could take a few seconds. Be Patient!
DF <- data.frame(readRDS(file1))

## Select data for the graph
DF1 <- sqldf("select year as year, sum(Emissions) as emissions from DF 
                  where fips=24510
                  group by year order by year")

## Plot graph using PNG device
x <- DF1$year
y <- DF1$emissions/1000

png(filename="./plot2.png")
plot(x, y, type="n", main="Emissions from All Sources for Baltimore", col.main="black", 
                     xlab="Year (1999-2008)", ylab="Total Emissions PM25 (in thousand particles)", col.lab="blue") 
lines(x, y, col="red")

## Close graphics device
dev.off()

## Close SQL connections
sqldf()


