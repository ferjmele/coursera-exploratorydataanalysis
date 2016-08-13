##open files and adjust data
rm(list=ls()) ##to free memory
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##take target data
yearsum<-aggregate(nei$Emissions ~ nei$year, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "Total.Emissions")
yearsum$Total.Emissions<-yearsum$Total.Emissions/1000000
##plot
png(filename = "plot1.png", width=480, height=480)
barplot(yearsum$Total.Emissions, names.arg=yearsum$Year, col = "red", main = "Total PM2.5 USA Emissions by Year", ylab = "Total PM2.5 Emissions in MM of Tons", xlab = "Year")
dev.off()