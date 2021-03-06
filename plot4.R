## READING DATA
## The script requires the "sqldf" package
require("sqldf")

## The script assumes that household_power_consumption.txt 
## is in the working directory
powerFile <- "household_power_consumption.txt"

## Use a sql query to read only required dates from the file
powerSelect <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
power <- read.csv2.sql(powerFile, powerSelect)

## Create a datetime column with th date and time converted to Date format.
power$datetime <- strptime(paste(power$Date, power$Time, sep=" "), 
                           format = "%d/%m/%Y %H:%M:%S")

## PLOTTING DATA
## NOTE:  I decided to keep the white background for my plots
## because it is more comfortable to read and this is how they are shown on the project page

## Initialize png graphic device split into 2 rows and 2 columns
## The bg is white and size is 480x480px by the default settings
png(file = "plot4.png")
par(mfrow=c(2,2))

## Plot 1 of 4: Global active power by date and time
with(power, plot(datetime, Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = ""))

## Plot 2 of 4: Voltage by date and time
with(power, plot(datetime, Voltage, type = "l"))

## Plot 3 of 4: Sub metering by date and time
with(power, plot(datetime, Sub_metering_1, type = "l", 
                 ylab = "Energy sub metering", xlab = ""))
with(power, lines(datetime, Sub_metering_2, col = "red"))
with(power, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = names(power)[7:9], 
       col = c("black", "red", "blue"), lwd = 1, bty = "n")

## Plot 4 of 4: Global reactive power by date and time
with(power, plot(datetime, Global_reactive_power, type = "l"))
dev.off()