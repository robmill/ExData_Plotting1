# Rob Miller
# plot4.R
# Course Project 1


# read data from temp directory
df<-read.table("c:/temp/household_power_consumption.txt",sep = ";",header = TRUE,stringsAsFactors = FALSE)

# create new variable combining Date and Time columns
# reformat
# extract day names and assign to new variable
df$DateTime<-paste(df$Date,df$Time)
df$DateTime<-strptime(df$DateTime,format = "%d/%m/%Y %H:%M:%S",tz="")
df$days<-weekdays(df$DateTime)

# reassign classes of variables
df$Date<-as.Date(df$Date,"%d/%m/%Y");
df$Global_active_power<-as.numeric(df$Global_active_power)
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Voltage<-as.numeric(df$Voltage)
df$Global_intensity<-as.numeric(df$Voltage)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)

# set start and end dates
df_start<-as.POSIXlt("2007-02-01 00:00:00")
df_end<-as.POSIXlt("2007-02-03 00:00:00")


# subset dataset between start and end dates
df_subset<-subset(df, df$DateTime>=df_start & df$DateTime<=df_end)

# extract weekay names for x-axis
x_axis_days<-unique(df_subset$day)

# format plotting area
par(mfrow=c(2,2))

# plot upper left position - Global Active Power line chart
#plot Gloval Active Power
plot(y=df_subset$Global_active_power,x=df_subset$DateTime,type="l", xlab='',ylab='')
title(ylab="Global Active Power (kilowatts)",xlab=NULL)

# plot upper right position - Voltage by datetime
plot(y=df_subset$Voltage,x=df_subset$DateTime,type="l",xlab='',ylab='')
title(ylab="Voltage",xlab="datetime")

# plot bottom left position - Energy sub metering
plot(y=df_subset$Sub_metering_1,x=df_subset$DateTime, type="l",xlab='',ylab='')
lines(y=df_subset$Sub_metering_2,x=df_subset$DateTime,col="red",type="l")
lines(y=df_subset$Sub_metering_3,x=df_subset$DateTime,col="blue",type="l")
# apply legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

# plot bottom right position - Global_reactive_power by datetime
plot(y=df_subset$Global_reactive_power,x=df_subset$DateTime,type="l",xlab='',ylab='')
title(ylab="Global_reactive_power",xlab="datetime")

# output to 480x480 PNG file
dev.copy(png,file="plot4.png")
dev.off()