plot1<-function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    total <- with(NEI, tapply(Emissions, year, sum))
    Year <- as.numeric(names(total))
    
    png(filename = "plot1.png", width = 640, height = 480, units = "px", bg = "white", pointsize = 12)
    par(mar = c(4,4,2,2))
    plot(x = Year, y = total*1.e-6, xaxt = "n", pch = 16, col = "red", 
         ylab = "PM2.5 emission(in million Tons)", 
         main = "PM2.5 emission from all sources over the years")
    axis (side = 1, at = Year)
    dev.off()
}
