##open files and adjust data
rm(list=ls()) ##to free memory
library(ggplot2)
nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")
nei$fips<-as.factor(nei$fips)
nei$SCC<-as.factor(nei$SCC)
nei$type<-as.factor(nei$type)
nei$year<-as.factor(nei$year)
##merge with scc and extract coal related emissions
nei2<-merge(nei,scc,by="SCC")
rm(nei) ## to free memory
coal<-grepl("coal", nei2$EI.Sector, ignore.case = TRUE)
coalemissions<-nei2[coal,c("SCC","year", "Emissions")]
rm(nei2) ##to free memory
rm(coal) ##to free memory
yearsum<-aggregate(coalemissions$Emissions ~ coalemissions$year, FUN = sum, na.action = na.omit)
names(yearsum)<-c("Year", "Total.Emissions")
yearsum$Total.Emissions<-yearsum$Total.Emissions/1000
##plot
png(filename = "plot4.png", width=480, height=480)
barplot(yearsum$Total.Emissions, names.arg=yearsum$Year, col = "red", main = "Total PM2.5 USA Coal source Emissions by Year", ylab = "Total PM2.5 Emissions Coal Sources in TH of Tons", xlab = "Year")
dev.off()
