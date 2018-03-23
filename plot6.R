#download file from website
pm2.5.zip <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "pm2.5.zip")

#unzip file
unzip("pm2.5.zip")
#load dplyr and ggplot2
library(dplyr)
library(ggplot2)

#read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merge NEI and SCC data frames
NEI.SCC <- merge(NEI, SCC)

#filter in Baltimore and Los Angeles data
NEI.SCC.BAL.LA <- filter(NEI.SCC, fips == "24510" |
                           fips == "06037")

#filter in on road data
NEI.SCC.BAL.LA.MOT <- filter(NEI.SCC.BAL.LA, EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"|
                               EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"|
                               EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles"|
                               EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

#summarize data for plotting
as.data.frame(plot6) <- summarize(group_by(NEI.SCC.BAL.LA.MOT, fips, year), Emissions = sum(Emissions)/1000)

#create plot6.png file
png(filename = "plot6.png")

#plot data
ggplot(data = plot6)+
  geom_smooth(mapping = aes(x = year, y = Emissions))+
  facet_wrap(~fips) +
  xlab("YEARS") +
  ylab("PM2.5 kilotons") +
  ggtitle("PM2.5 kilotons/year - Los Angeles(06037) and Baltimore City(24510)") 

#turn device off
dev.off()  
