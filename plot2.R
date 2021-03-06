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

## Plot Global_active_power over datetime in a png file
## The bg is white and size is 480x480px by the default settings
png(file = "plot2.png")
with(power, plot(datetime, Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()