library(readr)
binary0 <- read_delim("spain.0.3.PT.binary", "\t", escape_double = FALSE, col_types = cols(CHROM = col_character(), POS = col_character()), trim_ws = TRUE)
LGs <- read_delim("h0.7375.s110.LG.txt", "\t", escape_double = FALSE, col_types = cols(CHR = col_character(), POS = col_character()), trim_ws = TRUE)
#add shared chr-pos columns
binary0<-data.frame(binary0)
ids<-paste(binary0[,1],binary0[,2],sep="_")
binary0<-data.frame(ids,binary0)
LGs<-data.frame(LGs)
ids<-paste(LGs[,2],LGs[,3],sep="_")
LGs<-data.frame(ids,LGs)
#split files by LG and print to separate files, note that LG 0 has been excluded
binaries<-NULL
for(i in c(1:max(LGs$LG))){
  binaries<-c(binaries,paste("binary",i,sep=""))
}
for(i in 1:max(LGs$LG)){
  LGx<-subset(LGs,LGs$LG==i)
  binaryx<-subset(binary0,binary0$ids%in%LGx$ids)
  write.table(binaryx[,2:ncol(binaryx)],file=paste(binaries[i],".binary",sep=""),quote=F,sep="\t",row.names=F)
}

#if using in linux environment, change file type as follows:
#ls . to view files
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#cp nameoffile.ending nameoffilex.ending to copy file
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text