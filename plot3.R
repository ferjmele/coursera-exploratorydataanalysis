##open files and adjust data
rm(list=ls()) ##to free memory
library(ggplot2)
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##select for Baltimore
baltimore<-subset(nei, nei$fips=="24510")
rm(nei) ##to free memory
yearsum<-aggregate(baltimore$Emissions ~ baltimore$year + baltimore$type, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "Type", "Total.Emissions")
##Plot
png(filename = "plot3.png", width=480, height=480)
g<-ggplot(yearsum, aes(Year, Total.Emissions, group= Type, color=Type))
g<-g+geom_line() + geom_point()
g<-g+xlab("Year")+ylab("Total PM2.5 emissions (tons)")+ggtitle("Baltimore´s PM2.5 Total Emissions by Type and Year")
print(g)
dev.off()