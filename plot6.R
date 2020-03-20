NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC", all.y=TRUE)

baltimoreMerged <- subset(mergedData, fips=="24510")

losAngelesMerged <- subset(mergedData, fips=="06037")

baltimoreMotorVehicles <- subset(baltimoreMerged, 
                                 grepl("[Vv][Ee][Hh]", Short.Name) |
                                   grepl("[Vv][Ee][Hh]", EI.Sector) |
                                   grepl("[Vv][Ee][Hh]", SCC.Level.One) |
                                   grepl("[Vv][Ee][Hh]", SCC.Level.Two) |
                                   grepl("[Vv][Ee][Hh]", SCC.Level.Three) |
                                   grepl("[Vv][Ee][Hh]", SCC.Level.Four))

laMotorVehicles <- subset(losAngelesMerged, 
                          grepl("[Vv][Ee][Hh]", Short.Name) |
                          grepl("[Vv][Ee][Hh]", EI.Sector) |
                          grepl("[Vv][Ee][Hh]", SCC.Level.One) |
                          grepl("[Vv][Ee][Hh]", SCC.Level.Two) |
                          grepl("[Vv][Ee][Hh]", SCC.Level.Three) |
                          grepl("[Vv][Ee][Hh]", SCC.Level.Four))

yearSumsBaltimoreMV <- aggregate(Emissions ~ year, baltimoreMotorVehicles, FUN=sum)
yearSumsLosAngelesMV <- aggregate(Emissions ~ year, laMotorVehicles, FUN=sum)

par(mfrow=c(1,2))

barplot(yearSumsBaltimoreMV$Emissions, yearSumsBaltimoreMV$year, 
        main = "Emissions by Year (Motor Vehicles in Baltimore)",
        xlab = "Year", ylab = "Emissions",
        names.arg = c("1999","2002","2005","2008"))

barplot(yearSumsLosAngelesMV$Emissions, yearSumsLosAngelesMV$year, 
        main = "Emissions by Year (Motor Vehicles in L.A.)",
        xlab = "Year", ylab = "Emissions",
        names.arg = c("1999","2002","2005","2008"))