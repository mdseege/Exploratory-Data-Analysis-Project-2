#download zip file from internet
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")

#load dplyr and ggplot
library(dplyr)
library(ggplot2)

#read file into data frame
NEI <- readRDS("summarySCC_PM25.rds")

#filter in Baltimore City data
NEI.BAL <- filter(NEI, fips == "24510")

#summarize data for plotting
TE.BAL.TYPE <- summarize(group_by(NEI.BAL, year, type), Emissions = sum(Emissions)/1000)

#create plot3.png file
png(filename = "plot3.png")

#plot data
ggplot(data = TE.BAL.TYPE)+
  geom_point(mapping = aes(x = year, y = Emissions))+
  geom_smooth(mapping = aes(x = year, y = Emissions))+
  facet_wrap(~type) +
  xlab("YEARS") +
  ylab("PM2.5 kilotons") +
  ggtitle("PM2.5 kilotons/year/type - Baltimore City")

#turn device off
dev.off()  
