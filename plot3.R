library(dplyr)

#Reading data into R. File with data should be in the working directory.
energy <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                     na.strings = "?", stringsAsFactors = TRUE)

#creating new "data" coloumn with dates corresponding strings in "Data",
#filtering only measurements from 2007-02-01 or 2007-02-02,
#creating coloumn "datetime" by combyning "Date" and "Time" and converting into date format 
energy <- energy %>% mutate(date = as.Date(Date, format = "%d/%m/%Y")) %>%
        filter(date == "2007-02-01"| date == "2007-02-02") %>%
        mutate(datetime = as.POSIXct( strptime(paste(Date, Time),
                                format = "%d/%m/%Y %H:%M:%S"))) 

#opening graphic device
png("plot3.png")

#creating a plot
with(energy, {plot (datetime, Sub_metering_1, type = "n",
                   xlab = "", ylab = "Energy Sub Metering")
        lines (datetime,Sub_metering_1)
        lines (datetime,Sub_metering_2, col = "red")
        lines (datetime,Sub_metering_3, col = "blue")
})

#adding legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1) , col = c("black", "red", "blue"))

#closing graphic device
dev.off()

