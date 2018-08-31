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

#install and load lubridate package
if("lubridate" %in% rownames(installed.packages())==FALSE) {
  install.packages("lubridate")
}
library(lubridate)


#install and load dplyr package
if("dplyr" %in% rownames(installed.packages())==FALSE) {
  install.packages("dplyr")
}
library(dplyr)

#Create date time variable
mydata$Date <- as.Date(dmy(mydata$Date))
mydata <- mutate(mydata, datetime=as.POSIXct(paste(mydata$Date, mydata$Time), format="%Y-%m-%d %H:%M:%S"))


#Open png device, create file and plot
dev.new(png)
dev.set(dev.list()["png"])
png(filename = "plot2.png", width = 480, height = 480)
par(mar = c(3,4,3,2))
with(data = mydata, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
with(data = mydata, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data = mydata, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty=1, lwd=2)
dev.off()