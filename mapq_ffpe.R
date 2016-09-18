args=commandArgs(TRUE)
png(args[2], width=1280, height=480, units="px")
par(mfrow=c(1,1), xpd=T)
library(plyr)
library(plotrix)
library(ggplot2)
library(methods)
############################# 求 map 质量的分布
dna <- read.table(args[1])
dna_map <- table(dna)
############################ 数据
var1 <- as.numeric(dimnames(dna_map)$dna)
MAPQ60 <- sum(dna_map[var1 >= 60])
MAPQ01 <- sum(dna_map[var1>=1 & var1 <60])
MAPQ <- sum(dna_map[var1<1])
sum1 <- sum(dna_map)
################################数据标签
read1 <- c(MAPQ60, MAPQ01, MAPQ)
name <- c("MAPQ>=60", "MAPQ>=1", "unmapping")
per1 <- round(read1/sum1*100, 1)
name1 <- paste( per1, "%", sep=" ")
################################# 标签位置
pie(read1, radius=0.9 , labels=name1, cex=0.9, col=c("#669966", "#6699CC","#999999"), main="mapping quality distribution of DNA reads")
legend("topright", legend=c(name), cex=0.9, pch=16, col=c("#669966", "#6699CC","#999999"))

dev.off()
