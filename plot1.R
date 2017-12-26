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
## Filter date between bd and ed and coerce factor to numeric vector.
##
dataset <- hpc[hpc$Date >= bd & hpc$Date <= ed, ] 
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))

##
## Reset to one graphic per screen
##
par(mfrow=c(1,1))


##
## Plot and save as a png file
##
with(dataset, hist(Global_active_power, col="red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power"))
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()


##
## Cleanup
##
rm(hpc, bd, ed, dataset)
