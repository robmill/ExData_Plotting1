# Rob Miller
# plot1.R
# Course Project 1


# read data from temp directory
df<-read.table("c:/temp/household_power_consumption.txt",sep = ";",header = TRUE,stringsAsFactors = FALSE)

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
df_start<-as.Date("2007-02-01")
df_end<-as.Date("2007-02-02")


# subset dataset between start and end dates
#system.time(df_subset<-df[df$Date>=df_start & df$Date<=df_end,])
df_subset<-subset(df, Date>=df_start & Date<=df_end)


# plot histogram
with(df_subset,hist(as.numeric(Global_active_power),main = "Global Active Power",col = "red",xlab="Global Active Power (kilowatts)"))

dev.copy(png,file="plot.1.png")
dev.off()


