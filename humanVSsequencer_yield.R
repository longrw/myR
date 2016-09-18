args <- commandArgs(TRUE)
png(filename=paste(args[2],"/",args[3],".png",sep=""),width=1180,height=715,units="px")
par(mfrow=c(1,1))
par(mar=c(6,5,4,2))
par(mgp=c(3.5,1,0))
data <- read.table(args[1],sep=',')
human <- data$V14
nextseq500 <- data$V15
production <- cbind(human,nextseq500)
id <- data$V1
ymax <- max(human,nextseq500) + 0.5
barplot(t(production),beside=TRUE,ylim=c(0,ymax),width=1,col=c("black","green"),ylab="data_yield(G)",xlab="samples",main=paste("data yield for ",args[3],sep=""),density=80,names.arg=id,cex.names=0.6,las=3,axes=FALSE)
axis(2,at=seq(0,ymax,0.5),cex.axis=0.8)
legend("topright",legend=c("estimated yield","real yield"),fill=c("black","green"),cex=0.7,density=80)
abline(h=0.5,col='red',cex=1)
box()
dev.off()
