args <- commandArgs(TRUE)
png(filename=paste(args[1],"/","coverage_distribution_of_different_depth.png",sep=""),width=1280,height=480,units="px")
par(mfrow=c(1,1))
data <- read.table(paste(args[1],"/covInfo.csv",sep=""),sep=",")
covgs <- data[1,3:14]
covgm <- data[2,3:14]
gdna <- cbind(t(covgs),t(covgm))
depth <- c("1x","5x","20x","50x","100x","200x","500x","1000x","2500x","5000x","7500x","10000x")

barplot(t(gdna),beside=TRUE,ylim=c(0,1),width=1,col=c("black","grey"),ylab="coverage",xlab="depth",main=paste(args[2],"_dna",sep=""),density=80,names.arg=depth,axes=FALSE)
axis(2,at=seq(0,1,0.1),cex.axis=0.8)
legend("topright",legend=c("raw","dedup"),fill=c("black","grey"),cex=1,density=80)
box()
dev.off()
