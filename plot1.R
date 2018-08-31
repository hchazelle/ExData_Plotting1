setwd("C:/Users/Hchazelle/Desktop/Coursera/Course4Week1Assignment")

if(!file.exists("dataepc")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "dataepc")
  unzip(zipfile = "dataepc")
}


#using grep in read.table to only readLines of file beginning by 1/2/2007 or 2/2/2007
#By using this code, we must specify the column names as we lost them in the process

mydata <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE), 
           header = FALSE, sep = ";", col.names=c("Date","Time","Global_active_power","Global_reactive_power",
                       "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           na.strings = "?")

#Open png device, create file and plot
dev.new(png)
dev.set(dev.list()["png"])
png(filename = "plot1.png", width = 480, height = 480)
with(mydata, hist(Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
