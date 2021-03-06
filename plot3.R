

library(dplyr)
library(data.table)
library(lubridate)

#file downloaded "2015-03-02" from http://archive.ics.uci.edu/ml/

household_data<-data.table(read.table("household_power_consumption.txt",sep=";",header=TRUE,as.is=TRUE))

#select the needed data

trim_data<-household_data[Date %in% c('1/2/2007','2/2/2007')]
\
#add some dates

trim_data$date<-as.Date(parse_date_time(trim_data$Date,"d!/m*!/y"))
trim_data$day<-wday(trim_data$date,label=TRUE)
\
#open the device

png(filename = "plot3.png",
    width = 480, height = 480,)

#day boundries

daysBoundry<-c(0,1441,2881)

#plot first variable

plot(as.numeric(trim_data$Sub_metering_1),     
     ylab="Energy sub metering" , 
     xaxt="n",type="l",xlab="")

#add additional data

lines(as.numeric(trim_data$Sub_metering_2),col="red")
lines(as.numeric(trim_data$Sub_metering_3),col="blue")

#add axis

axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))

#add legend

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1)

dev.off()
