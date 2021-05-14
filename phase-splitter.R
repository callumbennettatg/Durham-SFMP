library(readr)
LGs <- read_delim("phased.txt", "\t", escape_double = FALSE, col_types = cols(CHR = col_character(), POS = col_character()), trim_ws = TRUE)
LGs<-data.frame(LGs)
LGs.1<-subset(LGs,LGs$PHASE==1)
LGs.2<-subset(LGs,LGs$PHASE==2)
write.table(LGs.1[,1:ncol(LGs.1)],file=paste("phased1.txt",sep=""),quote=F,sep="\t",row.names=F)
write.table(LGs.2[,1:ncol(LGs.1)],file=paste("phased2.txt",sep=""),quote=F,sep="\t",row.names=F)


sed -i 's/\r$//' 