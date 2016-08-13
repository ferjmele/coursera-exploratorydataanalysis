##open files and adjust data
rm(list=ls()) ##to free memory
library(ggplot2)
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##take baltimore data from vehicle sources
baltimore<-subset(nei, nei$fips=="24510")
rm(nei) ##to free memory
baltimore2<-merge(baltimore,scc,by="SCC")
rm(baltimore) ##to free memory
vehicles<-grepl("vehicles", baltimore2$EI.Sector, ignore.case = TRUE)
vehiemissions<-baltimore2[vehicles,c("SCC","year", "Emissions")]
rm(vehicles)
rm(baltimore2)
yearsum<-aggregate(vehiemissions$Emissions ~ vehiemissions$year, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "Total.Emissions")
##plot
png(filename = "plot5.png", width=480, height=480)
barplot(yearsum$Total.Emissions, names.arg=yearsum$Year, col = "red", main = "Total PM2.5 Baltimore Vehicle Emissions by Year", ylab = "Total PM2.5 Emissions in Tons", xlab = "Year")
dev.off()