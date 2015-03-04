

library(dplyr)
library(data.table)
library(lubridate)
#file downloaded "2015-03-02" from http://archive.ics.uci.edu/ml/

household_data<-data.table(read.table("household_power_consumption.txt",sep=";",header=TRUE,as.is=TRUE))

trim_data<-household_data[Date %in% c('1/2/2007','2/2/2007')]

trim_data$date<-as.Date(parse_date_time(trim_data$Date,"d!/m*!/y"))

png(filename = "plot1.png",
    width = 480, height = 480,)

hist(as.numeric(trim_data$Global_active_power),
     xlab="Global Active Power (kilowatts)" , main="Global Active Power",
     col="red")
dev.off()
