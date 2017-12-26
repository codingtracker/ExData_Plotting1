##
## Author: Chen Ye
## 


## hpc for household_power_consumption
hpc <- read.csv("household_power_consumption.txt", sep = ";")

##
## Convert from factor to Date, pay attention to the format letter case.
##
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")


##
## bd for begin date; ed for end date
##
bd <- as.Date("2007-02-01")
ed <- as.Date("2007-02-02")


##
## filter date between bd and ed and coerce Global_active_power from factor to numeric vector.
## merge two time variables using paste to address strptime unable to print only %H:%M:%S issue
##
dataset <- hpc[hpc$Date >= bd & hpc$Date <= ed, ] 
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format="%Y-%m-%d %H:%M:%S")
dataset$Date <- format(as.Date(dataset$Date), format="%a")

dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))

dataset$Sub_metering_1 <- as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2 <- as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3 <- as.numeric(as.character(dataset$Sub_metering_3))

dataset$Voltage <- as.numeric(as.character(dataset$Voltage))

dataset$Global_reactive_power <- as.numeric(as.character(dataset$Global_reactive_power))

##
## Reset 
##
## This change made the plot4 legend showing full strings
##
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), oma = c(0, 0, 0, 0))


##
## Plot 1
##
with(dataset, plot(Global_active_power ~ Time, t="l", xlab="", ylab = "Global Active Power" ))

##
## Plot 2
##
with(dataset, plot(Voltage ~ Time, t="l", xlab="datetime", ylab = "Voltage" ))

##
## Plot 3
##
with(dataset, plot(Sub_metering_1 ~ Time, t="l", xlab="", ylab = "Energy sub metering", col="black" ))
with(dataset, lines(Sub_metering_2 ~ Time, t="l", xlab="", ylab = "", col="red" ))
with(dataset, lines(Sub_metering_3 ~ Time, t="l", xlab="", ylab = "", col="blue" ))
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , bty="n")

##
## Plot 4
##
with(dataset, plot(Global_reactive_power ~ Time, t="l", xlab="datetime", ylab = "Global_reactive_power"))


##
## Save as a png file
##

dev.off()


##
## Cleanup
##
rm(hpc, bd, ed, dataset)