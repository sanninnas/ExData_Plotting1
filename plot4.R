## data download & extraction
# create a directory "Assignment1"
if(!file.exists("Assignment1")){
    dir.create("Assignment1")
}
# download and unzip the file in the directory that was just created
# set "Assingment1" as the working directory
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./Assignment1/data.zip", method = "curl")
unzip("./Assignment1/data.zip", exdir = "./Assignment1/")
setwd("./Assignment1/")

## read relevent subset of the data into R and assign as "df"
# with sql
library("sqldf")
df<-read.csv2.sql("household_power_consumption.txt", sql = "select * from file where Date == '1/2/2007' OR Date =='2/2/2007'")

## set and store datetime in the new variable $dateTimeStrp
Sys.setlocale("LC_ALL","C")
df$dateTime<-paste(df$Date, df$Time, sep=" ")
df$dateTimeStrp<-strptime(df$dateTime, "%d/%m/%Y %H:%M:%S")

## plot 4
# create graphic device plot4.png in the folder that was forked and cloned from the github repository
# set parameter to display four plots 
# sequentially plot the four plots in plot4.png
png(file="./ExData_Plotting1/plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))
plot(df$dateTimeStrp, df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(df$dateTimeStrp, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(df$dateTimeStrp, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(df$dateTimeStrp, df$Sub_metering_1, col="black")
lines(df$dateTimeStrp, df$Sub_metering_2, col="red")
lines(df$dateTimeStrp, df$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
plot(df$dateTimeStrp, df$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()