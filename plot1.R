#download file from website
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")

#load dplyr
library(dplyr)

#read file into data frame
NEI <- readRDS("summarySCC_PM25.rds")

#summarize data
TE <- summarize(group_by(NEI, year), Emissions=sum(Emissions)/1000)

#create plot1.png file
png(filename = "plot1.png")

#plot data
barplot(TE$Emissions, 
        names= unique(NEI$year), 
        xlab = "YEARS", ylab = "PM2.5 kilotons", 
        main = "PM2.5 kilotons/year - USA")

#turn device off
dev.off()  
