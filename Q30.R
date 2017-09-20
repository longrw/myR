args <- commandArgs(TRUE)
png(args[2], width=1180, height=715, units="px")
par(mar=c(6,5,4,2))
par(mgp=c(3.5,1,0))
#data
data <- read.table(args[1],sep = ",")
samples <- c(1:length(data$V1))
q20 <- as.numeric(gsub("%","",data$V6))
q30 <- as.numeric(gsub("%","",data$V7))
gc <- as.numeric(gsub("%","",data$V13))
#main
plot(samples,q20,type = "o",pch=20,lty=3,ylim = c(30,100),xlab = "samples",ylab = "percentage(%)", main=paste("Quality Control of ", args[3], sep=""), xaxt="n",yaxt="n",col="red")
#text(1,1,data$V1)
axis(1,at=seq(1,length(data$V1),1),lab = data$V1,las=3,cex.axis=0.6)
axis(2,at=seq(10,100,5),cex.axis=0.8)
lines(samples,q30,type = "o",pch=20,lty=3,col="forestgreen")
lines(samples,gc,type = "o",pch=20,lty=3,col="blue")
legend("topright",legend=c("Q20","Q30","GC%"),text.col = c("red","forestgreen","blue"),bty="n",horiz=T,pch = 20,lty = 3,col = c("red","forestgreen","blue"),cex = 0.8)
#easy to find sample
lines(samples,q20,type = "h",lty=3,col="grey")
#for (i in samples){
#  abline(v=i,lty=3,lwd=0.5)
#}

#reference value
abline(h=85,lty=1,lwd=0.3,col="black")
abline(h=45,lty=1,lwd=0.3,col="black")
dev.off()
