NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearSums <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

barplot(yearSums$x, yearSums$Category,main = "Emissions by year", xlab = "Year", ylab = "Emissions",
        names.arg = c("1999","2002","2005","2008"))