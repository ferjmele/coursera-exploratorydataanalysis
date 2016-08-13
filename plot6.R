##open files and adjust data
rm(list=ls())
library(ggplot2)
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##take LA and Bal and aggregate
balla<-subset(nei, nei$fips=="24510" | nei$fips== "06037")
rm(nei) ##to free memory
balla2<-merge(balla,scc,by="SCC")
rm(balla) ##to free memory
vehicles<-grepl("vehicles", balla2$EI.Sector, ignore.case = TRUE)
vehiemissions<-balla2[vehicles,c("SCC","year", "fips", "Emissions")]
rm(vehicles)
rm(balla2)
yearsum<-aggregate(vehiemissions$Emissions ~ vehiemissions$year + vehiemissions$fips, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "County","Total.Emissions")
yearsum$County<-gsub("24510","BAL", yearsum$County)
yearsum$County<-gsub("06037","LA", yearsum$County)
##plot
png(filename = "plot6.png", width=480, height=480)
g<-ggplot(yearsum, aes(Year, Total.Emissions, group= County, color=County))
g<-g+geom_line() + geom_point()
g<-g+xlab("Year")+ylab("Total PM2.5 emissions (tons)")+ggtitle(" PM2.5 Total Emissions by County by Year")
g<-g+annotate("text", x=2, y=2500, label= "Baltimore changed more than LA from 1999 to 2008")
print(g)
dev.off()