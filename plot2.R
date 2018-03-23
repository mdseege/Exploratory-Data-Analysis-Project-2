#download zip file from internet
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")

#load dplr
library(dplyr)

#read zip file into data frame
NEI <- readRDS("summarySCC_PM25.rds")

#filter in Baltimore City Data
NEI.BAL <- filter(NEI, fips == "24510")
TE.BAL <- summarize(group_by(NEI.BAL, year), Emissions =sum(Emissions)/1000)

#create plot2.png file
png(filename = "plot2.png")

#plot data
barplot(TE.BAL$Emissions, 
        names= unique(NEI$year), 
        xlab = "YEARS", ylab = "PM2.5 kilotons", 
        main = "PM2.5 kilotons/year - Baltimore City")

#turn device off
dev.off()  
