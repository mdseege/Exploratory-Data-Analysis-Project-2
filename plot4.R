#download zip file from internet
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")

#load dplyr and ggplot
library(dplyr)
library(ggplot2)

#read NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge NEI and SCC files
NEI.SCC <- merge(NEI, SCC)

#filter in coal combustion data
NEI.SCC.COAL <- filter(NEI.SCC, EI.Sector == "Fuel Comb - Electric Generation - Coal"|
                         EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal"|
                         EI.Sector == "Fuel Comb - Comm/Institutional - Coal")

#summarize data for plotting
plot4 <- summarize(group_by(NEI.SCC.COAL, year), Emissions = sum(Emissions)/1000)

#create plot4.png file
png(filename = "plot4.png")

#plot data
ggplot(data = plot4)+
  geom_point(mapping = aes(x = year, y = Emissions))+
  geom_smooth(mapping = aes(x = year, y = Emissions))+
  xlab("YEARS") +
  ylab("PM2.5 kilotons") +
  ggtitle("PM2.5 kilotons/year - USA")

#turn device off
dev.off()  
