
# Descarga
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./DataProject1.zip")){
  download.file(url,"./DataProject1.zip", method= "curl")
}
unzip("./DataProject1.zip", exdir = getwd())

#Importación
library(data.table)
DataEnergy<-read.table("./household_power_consumption.txt",
                       header = T,
                       sep = ";",
                       dec = ".",
                       na.strings = "?")

# Dar formato a las variables
DataEnergy$Date <- as.Date(DataEnergy$Date, "%d/%m/%Y")

# unir Fecha y Hora
Date_time <- paste(as.Date(DataEnergy$Date), DataEnergy$Time)
DataEnergy$Date_time <- as.POSIXct(Date_time)

# filtrar solo 2 días (1 y 2 de enero de 2007)
library(dplyr)
DataEnergy<-filter(DataEnergy,  Date=="2007-2-1" | Date=="2007-2-2")


#############################################################################
# PLOT 4
par(mfrow = c(2,2))

with(DataEnergy, {
  plot(Global_active_power ~ Date_time, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Date_time, type = "l", ylab = "Voltage", xlab = "Datetime")
  plot(Sub_metering_1 ~ Date_time, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Date_time, col = 'Red')
  lines(Sub_metering_3 ~ Date_time, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Date_time, type = "l", 
       ylab = "Global_rective_power", xlab = "Datetime")
})

# exportar en png
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
