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
## Initialize png graphic device with transparent background
## Split it into 2 rows and 2 columns
png(file = "plot4.png", bg = "transparent")
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