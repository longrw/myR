args=commandArgs(TRUE)
png(args[3], width=960, height=480, units="px")
par(mfrow=c(1,2), xpd=T)
library(plyr)
library(plotrix)
library(ggplot2)
library(methods)
############################# 求 map 质量的分布
cfdna <- read.table(args[1])
gdna <- read.table(args[2])
cfdna_map <- table(cfdna)
gdna_map <- table(gdna)
############################ 数据
var1 <- as.numeric(dimnames(cfdna_map)$cfdna)
MAPQ60 <- sum(cfdna_map[var1 >= 60])
MAPQ01 <- sum(cfdna_map[var1>=1 & var1 <60])
MAPQ <- sum(cfdna_map[var1<1])
sum1 <- sum(cfdna_map)

var2 <- as.numeric(dimnames(gdna_map)$gdna)
Q60 <- sum(gdna_map[var2>= 60])
Q01 <- sum(gdna_map[var2>=1 & var2 <60])
Q <- sum(gdna_map[var2<1])
sum2 <- sum(gdna_map)
################################数据标签
read1 <- c(MAPQ60, MAPQ01, MAPQ)
read2 <- c(Q60, Q01, Q)
name <- c("MAPQ>=60", "MAPQ>=1", "unmapping")
per1 <- round(read1/sum1*100, 1)
per2 <- round(read2/sum2*100, 1)
name1 <- paste( per1, "%", sep=" ")
name2 <- paste( per2, "%", sep=" ")
################################# 标签位置
pie(read1, radius=0.9 , labels=name1, cex=0.9, col=c("#669966", "#6699CC","#999999"), main="mapping quality distribution of cfDNA reads")
#legend("top", legend=paste(sum1," reads "), bty="n",  horiz=T)
pie(read2, radius=0.9 , labels=name2, cex=0.9, col=c("#669966", "#6699CC","#999999"), main="mapping quality distribution of gDNA reads")
legend("topright", legend=c(name), cex=0.9, pch=16, col=c("#669966", "#6699CC","#999999"))

dev.off()
