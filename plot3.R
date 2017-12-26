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
## filter date between bd and ed and coerce Sub_metering from factor to numeric vector.
## merge two time variables using paste to address strptime unable to print only %H:%M:%S issues
##
dataset <- hpc[hpc$Date >= bd & hpc$Date <= ed, ] 
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format="%Y-%m-%d %H:%M:%S")
dataset$Date <- format(as.Date(dataset$Date), format="%a")

dataset$Sub_metering_1 <- as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2 <- as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3 <- as.numeric(as.character(dataset$Sub_metering_3))


##
## Reset 
##
par(mfrow=c(1,1))


##
## Plot and save as a png file
## 
##
with(dataset, plot(Sub_metering_1 ~ Time, t="l", xlab="", ylab = "Energy sub metering", col="black" ))
with(dataset, lines(Sub_metering_2 ~ Time, t="l", xlab="", ylab = "", col="red" ))
with(dataset, lines(Sub_metering_3 ~ Time, t="l", xlab="", ylab = "", col="blue" ))
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png", width=480, height=480)
dev.off()


##
## Cleanup
##
rm(hpc, bd, ed, dataset)