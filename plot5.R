library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC", all.y=TRUE)

baltimoreMerged <- subset(mergedData, fips=="24510")

 baltimoreMotorVehicles <- subset(baltimoreMerged, 
                           grepl("[Vv][Ee][Hh]", Short.Name) |
                           grepl("[Vv][Ee][Hh]", EI.Sector) |
                           grepl("[Vv][Ee][Hh]", SCC.Level.One) |
                           grepl("[Vv][Ee][Hh]", SCC.Level.Two) |
                           grepl("[Vv][Ee][Hh]", SCC.Level.Three) |
                           grepl("[Vv][Ee][Hh]", SCC.Level.Four))

 
yearSumsBaltimoreMV <- aggregate(Emissions ~ year, baltimoreMotorVehicles, FUN=sum)

lines(yearSumsBaltimoreMV$Category, yearSumsBaltimoreMV$x, 
        main = "Emissions by Year (Motor Vehicles in Baltimore)", 
        xlab = "Year", ylab = "Emissions")

   