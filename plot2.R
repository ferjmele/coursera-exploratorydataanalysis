##open files and adjust data
rm(list=ls()) ##to free memory
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##obtain target data
baltimore<-subset(nei, nei$fips=="24510")
yearsum<-aggregate(baltimore$Emissions ~ baltimore$year, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "Total.Emissions")
##plot
png(filename = "plot2.png", width=480, height=480)
barplot(yearsum$Total.Emissions, names.arg=yearsum$Year, col = "red", main = "Total PM2.5 Baltimore Emissions by Year", ylim= c(0,max(yearsum$Total.Emissions, na.rm = TRUE)), ylab = "Total PM2.5 Emissions in Tons", xlab = "Year")
dev.off()