

library(dplyr)
library(data.table)
library(lubridate)

#file downloaded "2015-03-02" from http://archive.ics.uci.edu/ml/

household_data<-data.table(read.table("household_power_consumption.txt",sep=";",header=TRUE,as.is=TRUE))

#grab only the required data

trim_data<-household_data[Date %in% c('1/2/2007','2/2/2007')]

#create a date column as a date tyoe if needed

trim_data$date<-as.Date(parse_date_time(trim_data$Date,"d!/m*!/y"))

#add day of the week just to check

trim_data$day<-wday(trim_data$date,label=TRUE)

#open the device

png(filename = "plot2.png",
    width = 480, height = 480,)

#These are the boudries for the days 

daysBoundry<-c(0,1441,2881)

plot(as.numeric(trim_data$Global_active_power),     
     ylab="Global Active Power (kilowatts)" , 
     xaxt="n",type="l",xlab="")

#add custome axis
axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))

#close device

dev.off()
