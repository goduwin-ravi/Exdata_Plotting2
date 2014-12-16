## Load the required libraries
library(sqldf)

file1  <- "summarySCC_PM25.rds"
file2  <- "Source_Classification_Code.rds"
keyCol <- "SCC"

## Read file1. This could take a few seconds. Be Patient!
DF <- data.frame(readRDS(file1))

## Select data for the graph
DF1 <- sqldf("select year as year, sum(Emissions) as emissions from DF 
                  where year in ('1999', '2002', '2005', '2008')
                  group by year order by year")

## Plot graph using PNG device
png(filename="./plot1.png")
x <- DF1$year
y <- DF1$emissions/1000

plot(x, y, type="n", main="Emissions from All Sources for USA", col.main="black", 
                     xlab="Year (1999-2008)", ylab="Total Emissions PM25 (in thousand particles)", col.lab="blue") 
lines(x, y, col="red")

## Close graphics device
dev.off()

## Close SQL connections
sqldf()


