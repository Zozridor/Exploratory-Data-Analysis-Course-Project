library(ggplot2)
library(dplyr)
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips== "24510")

sourcePoint <- subset(baltimore, type == "POINT")
Point <- aggregate(sourcePoint$Emissions, by=list(Category=sourcePoint$year), FUN=sum, na.omit=TRUE)

sourceNonPoint <- subset(baltimore, type == "NONPOINT")
NonPoint <- aggregate(sourceNonPoint$Emissions, by=list(Category=sourceNonPoint$year), FUN=sum, na.omit=TRUE)

sourceOnRoad <- subset(baltimore, type == "ON-ROAD")
OnRoad <- aggregate(sourceOnRoad$Emissions, by=list(Category=sourceOnRoad$year), FUN=sum, na.omit=TRUE)

sourceNonRoad <- subset(baltimore, type == "NON-ROAD")
NonRoad <- aggregate(sourceNonRoad$Emissions, by=list(Category=sourceNonRoad$year), FUN=sum, na.omit=TRUE)

total <- Point
total$source <- "Point"

total <- dplyr::bind_rows(total, NonPoint)
total[is.na(total)] <- "NonPoint"

total <- dplyr::bind_rows(total, OnRoad)
total[is.na(total)] <- "OnRoad"

total <- dplyr::bind_rows(total, NonRoad)
total[is.na(total)] <- "NonRoad"

df.long <- reshape2::melt(total, id.vars = c("Category","source"))
ggplot(df.long, aes(Category, value, col=source))+
  geom_line(stat="identity")+
  facet_grid(rows = vars(source), scales="free")+
  labs(x="Year",y="PM2.5 Emission (tons)")
  