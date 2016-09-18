args=commandArgs(TRUE)
png(args[3], width=1280, height=480, units="px")
par(mfrow=c(1,2))

cfdna_tempLen <- read.table(args[1])
cfdna_tempLen <- abs(cfdna_tempLen)
tmp <- table(cfdna_tempLen)
var1 <- as.numeric(dimnames(tmp)$cfdna_tempLen)
cfdna_y <- as.numeric(tmp[var1>0 & var1<=1000])
m <- length(cfdna_y)
cfdna_x <- (0:(m-1))
cfdna <- cbind(cfdna_x, cfdna_y)
plot(cfdna, xlab="template length(cfDNA)", ylab="template number", cex.lab=1, font.lab=2, type="l", col="red", lwd=2, xaxt="n", cex.axis=0.9)
axis(1, at=seq(0,m,50), cex.axis=0.9)


gdna_tempLen <- read.table(args[2])
gdna_tempLen <- abs(gdna_tempLen)
res <- table(gdna_tempLen)
var2 <- as.numeric(dimnames(res)$gdna_tempLen)
gdna_y <- as.numeric(res[var2>0 & var2<=1000])
n <- length(gdna_y)
gdna_x <- (0:(n-1))
gdna <- cbind(gdna_x, gdna_y)
plot(gdna, xlab="template length(gDNA)", ylab="template number", cex.lab=1, font.lab=2, type="l", col="blue", lwd=2, xaxt="n", cex.axis=0.9)
axis(1, at=seq(0,n,50), cex.axis=0.9)


dev.off()
