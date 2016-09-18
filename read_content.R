args <- commandArgs(TRUE)
png(filename=paste(args[1],"/",args[2],"_read_content.png",sep=""),width=1280,height=480,units="px")
par(mfrow=c(1,2))
GCC   <- read.table(args[3])
#ATCG
cycle <- GCC[ ,1]
A     <- GCC[ ,2]
C     <- GCC[ ,3]
G     <- GCC[ ,4]
t     <- GCC[ ,5]
GC    <- G + C
#GC
tmp    <- cbind(cycle, GC)
cycles <- length(tmp[ ,2])
GC_sum <- sum(tmp[ ,2])
GC_mean<-round(GC_sum/cycles, 2)
#plot AGCT
plot(GCC[ ,1:2], xlab="position in read(bp)", ylab="ATCG percent(%)", cex.lab=0.8, cex.axis=0.8, cex.main=0.8, ylim=c(0,100), type="l", lwd=1.5, col="green", main="ATCG of all read content", yaxt="n", xaxt="n")
axis(2,at=seq(0,100,5))
axis(1,at=seq(0,cycles,10))
lines(cycle, C, type="l", lwd=1.5, col="blue")
lines(cycle, G, type="l", lwd=1.5, col="black")
lines(cycle, t, type="l", lwd=1.5, col="red")
#grid(nx=10,ny=14)
legend("topright", legend=c("A%", "C%", "G%", "T%"), text.col = c("green","blue","black","red"), bty="n", horiz = T, lty=1, col = c("green","blue","black","red"), cex = 0.8)
#plot GC
plot(tmp, xlab="position in read(bp)", ylab="GC percent(%)", ylim=c(0,100), type="l", lwd=1.5, col= "black",  main="GC of all read content", cex.lab=0.8, cex.axis=0.8, cex.main=0.8, yaxt="n", xaxt="n")
axis(2,at=seq(0,100,5))
axis(1,at=seq(0,cycles,10))
lines(cycle, rep(GC_mean,cycles), lty=1, lwd=1.5, col="red")
#grid(nx=10,ny=14)
legend("topright", legend=c("GC%", "Mean_GC%"), text.col = c("black", "red"), bty="n", horiz = T, lty = 1, col = c("black", "red"), cex = 0.8)
#read info
write.csv(GC_mean,file=paste(args[1],"/",args[2],"_GC_percent.csv",sep=""),row.names=FALSE)
dev.off()
