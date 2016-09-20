
yield <- c(2.882,3.492,3.768,5.714,6.368,6.467,9.258,11.37)
after <- c(0.96,1.1,1.23,1.76,1.98,2.19,2.83,3.53)
qc <- c(3.9,4.3,4.39,5.31,5.36,4.5,3.8,3.8)

plot(yield,type = 'o',pch=20,lty=1,ylim=c(0,12),xlab="samples",ylab='',yaxt='n',col='red')
axis(2,at=seq(0,12,0.5),cex.axis=0.8)
lines(after,type = 'o',pch=20,lty=2,col="blue")
lines(qc,type = 'o',pch=20,lty=3,col="forestgreen")
legend('topright',legend=c('Data yield(G)','After time(h)','AfterQC time(min)'),text.col = c("red","blue","forestgreen"),bty="n",horiz=T,pch = 20,lty = c(1,2,3),col = c("red","blue","forestgreen"),cex = 0.9)
lines(yield,type = "h",lty=3,col="grey")
lines(qc,type = "h",lty=3,col="grey")

text(1:8,yield-0.2,labels=yield,col='red')
text(1:8,after-0.2,labels=after,col='blue')
text(1:8,qc-0.2,labels=qc,col='forestgreen')