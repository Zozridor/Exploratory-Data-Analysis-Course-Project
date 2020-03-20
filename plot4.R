NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC", all.y=TRUE)

coalCombustion <- subset(mergedData, 
                         grepl("[Cc][Oo][Aa][Ll]", Short.Name) ||
                         grepl("[Cc][Oo][Aa][Ll]", EI.Sector) ||
                         grepl("[Cc][Oo][Aa][Ll]", SCC.Level.One) ||
                         grepl("[Cc][Oo][Aa][Ll]", SCC.Level.Two) ||
                         grepl("[Cc][Oo][Aa][Ll]", SCC.Level.Three) ||
                         grepl("[Cc][Oo][Aa][Ll]", SCC.Level.Four) 
                         &&
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", Short.Name) ||
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", EI.Sector) ||
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", SCC.Level.One) ||
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", SCC.Level.Two) ||
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", SCC.Level.Three) ||
                         grepl("[Cc][Oo][Mm][Bb][Uu][Ss][Tt][Ii][Oo][Nn]", SCC.Level.Four))

yearSumsCoal <- aggregate(coalCombustion$Emissions, by=list(Category=coalCombustion$year), FUN=sum)

barplot(yearSumsCoal$x, yearSumsCoal$Category, main = "Emissions by Year (Coal Combustion)", xlab = "Year", ylab = "Emissions",
        names.arg = c("1999","2002","2005","2008"))