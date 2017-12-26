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
##
dataset <- hpc[hpc$Date >= bd & hpc$Date <= ed, ] 
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format="%Y-%m-%d %H:%M:%S")
dataset$Date <- format(as.Date(dataset$Date), format="%a")

dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))


##
## Reset 
##
par(mfrow=c(1,1))


##
## Plot and save as a png file
##
with(dataset, plot(Global_active_power ~ Time, t="l", xlab="", ylab = "Global Active Power(kilowatts)" ))
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()


##
## Cleanup
##
rm(hpc, bd, ed, dataset)