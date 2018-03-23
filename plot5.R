#download zip file from internet
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")

#load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#read NEI and SCC files into data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge NEI and SCC data frames
NEI.SCC <- merge(NEI, SCC)

#filter in Baltimore City data
NEI.SCC.BAL <- filter(NEI.SCC, fips == "24510")

#filter on road emissions data
NEI.SCC.BAL.MOT <- filter(NEI.SCC.BAL, EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"|
                            EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"|
                            EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles"|
                            EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

#summarize data for plotting
plot5 <- summarize(group_by(NEI.SCC.BAL.MOT, year), Emissions = sum(Emissions)/1000)

#create plot5.png file
png(filename = "plot5.png")

#plot data
ggplot(data = plot5)+
  geom_point(mapping = aes(x = year, y = Emissions))+
  geom_smooth(mapping = aes(x = year, y = Emissions))+
  xlab("YEARS") +
  ylab("PM2.5 kilotons") +
  ggtitle("PM2.5 kilotons/year - Baltimore City")                          

#turn device off
dev.off()  
