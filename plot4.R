plot4<-function(){
    #NEI <- readRDS("summarySCC_PM25.rds")
    #SCC <- readRDS("Source_Classification_Code.rds")
    coalIndex <- data.frame(as.character(SCC$SCC)[grep(pattern = "coal", 
                    x = SCC$EI.Sector, ignore.case = T)], stringsAsFactors =F)
    names(coalIndex) <- "SCC"
    data <- merge(x = NEI, y = coalIndex, by.x = "SCC", by.y = "SCC", all = F)
    
    total <- with(data, tapply(Emissions, year, sum))
    Year <- unique(data$year)
    
    png(filename = "plot4.png", width = 640, height = 480, units = "px", 
        bg = "white", pointsize = 12)
    par(mar = c(4,4,2,2))
    plot(x = Year, y = total*0.001, xaxt = "n", pch = 16, col = "red", 
         ylab = "PM2.5 emission(in thousand Tons)", 
         main = "Coal combustion-related sources Across the USA")
    axis (side = 1, at = Year)
    dev.off()
}