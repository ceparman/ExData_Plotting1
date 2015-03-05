

library(dplyr)
library(data.table)
library(lubridate)
#file downloaded "2015-03-02" from http://archive.ics.uci.edu/ml/

household_data<-data.table(read.table("household_power_consumption.txt",sep=";",header=TRUE,as.is=TRUE))

trim_data<-household_data[Date %in% c('1/2/2007','2/2/2007')]

trim_data$date<-as.Date(parse_date_time(trim_data$Date,"d!/m*!/y"))
trim_data$day<-wday(trim_data$date,label=TRUE)

png(filename = "plot4.png",
    width = 480, height = 480,)

#create 4 panel plot

par(mfrow =c(2,2))

#plot #1

#same as plot #3

daysBoundry<-c(0,1441,2881)

plot(as.numeric(trim_data$Global_active_power),     
     ylab="Global Active Power (kilowatts)" , 
     xaxt="n",type="l",xlab="")
axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))

#plot #2

#plot voltage

plot(as.numeric(trim_data$Voltage),     
     ylab="Voltage" , 
     xaxt="n",type="l",xlab="datetime")

#add axis

axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))

#plot #3
#sample as plot #3

plot(as.numeric(trim_data$Sub_metering_1),     
     ylab="Energy sub metering" , 
     xaxt="n",type="l",xlab="")
lines(as.numeric(trim_data$Sub_metering_2),col="red")
lines(as.numeric(trim_data$Sub_metering_3),col="blue")
axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))

#only change - remove box from legend

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1,bty="n")

#plot #4


#plot similar to second in the set with ne variable

plot(as.numeric(trim_data$Global_reactive_power),     
     ylab="Global_reactive_power" , 
     xaxt="n",type="l",xlab="datetime")
axis(1,daysBoundry,labels=c("Thu","Fri","Sat"))




dev.off()
par(mfrow =c(1,1))