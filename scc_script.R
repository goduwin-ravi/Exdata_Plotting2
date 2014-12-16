## Load the required libraries
library(sqldf)

file1  <- "summarySCC_PM25.rds"
file2  <- "Source_Classification_Code.rds"
keyCol <- "SCC"

## Read & merge the two input files. This could take a few seconds. Be Patient!
DF <- data.frame(merge(readRDS(file1),readRDS(file2),by=c(keyCol)))

## Sort input data by year, county, type of emission, and SCC Code. Once again, Be Patient!
DF <- DF[with(DF,order(year, fips, type, SCC)),]

## Save the output to a .csv file, just in case! Just one more time, Be Patient!
#write.csv(DF, "MergedSCC_PM25.csv")

## Select data for the graph
DF1 <- sqldf("select year as year, sum(Emissions) as emissions from DF 
                  where fips=24510
                  group by year order by year")

## Plot graph using PNG device
xRange <- DF1$year
yRange <- DF1$emissions/1000

png(filename="./plot2.png")
plot(xRange, yRange, type="n", main="US Emissions from All Sources", col.main="black", 
                     xlab="Year (1999-2008)", ylab="Total Emissions PM25 (in thousand particles)", col.lab="blue") 
lines(xRange, yRange, col="red")

## Close graphics device
dev.off()

## Close SQL connections
sqldf()


