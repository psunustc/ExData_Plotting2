plot5<-function(){
    #NEI <- readRDS("summarySCC_PM25.rds")
    #SCC <- readRDS("Source_Classification_Code.rds")
    data <- NEI[NEI$fips =="24510", -1] 
    coalIndex <- data.frame(as.character(SCC$SCC)[
                    grep(pattern = "Mobile", x = SCC$EI.Sector, ignore.case = T)], 
                    stringsAsFactors =F)
    names(coalIndex) <- "SCC"
    data <- merge(x = data, y = coalIndex, by.x = "SCC", by.y = "SCC", all = F)
    
    total <- with(data, tapply(Emissions, year, sum))
    Year <- as.numeric(rownames(total))
    
    png(filename = "plot5.png", width = 640, height = 480, units = "px", 
        bg = "white", pointsize = 12)
    par(mar = c(4,4,2,2))
    plot(x = Year, y = total*0.001, xaxt = "n", pch = 16, col = "red", 
         ylab = "PM2.5 emission(in thousand Tons)", 
         main = "Motor vehichle sources in Baltimore City, Maryland")
    axis (side = 1, at = Year)
    dev.off()
}