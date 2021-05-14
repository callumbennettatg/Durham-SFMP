setwd("C:/Users/Forxb/Documents/Masters/QTL analysis/cali511_509/")
library(readr)
#import all mstmap files in directory
readx<-function(x) {
  read_tsv(x,col_names=c("snp","lg","dist"))
}
temp = list.files(pattern="*.mstmap")
lgs = lapply(temp, readx)
#make a list of snps in map order
snplist<-NULL
lglist<-NULL
distlist<-NULL
for(i in 1:length(lgs)){
  snplist<-c(snplist,as.matrix(lgs[[i]])[,1])
  lglist<-c(lglist,as.matrix(lgs[[i]])[,2])
  distlist<-c(distlist,as.matrix(lgs[[i]])[,3])
}
#import binary file
binarydata <- read_delim("California.0.6.PT.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
#build a binary file from map order snps
binarymap<-NULL
for(i in 1:length(snplist)){
  snpx<-unlist(c(snplist[i],lglist[i],distlist[i],binarydata[grep(snplist[i],as.matrix(binarydata[,3])),6:ncol(binarydata)]))
  binarymap<-rbind(binarymap,snpx)
}
#finish rqtl formatting
inds<-colnames(binarymap)[4:ncol(binarymap)]
indlist<-t(t(inds))
write.table(indlist,file="indlist.txt",quote=F,sep="\t",row.names=F,col.names=F,eol="\n") #ordered list of individuals to get traits
tbinarymap<-t(binarymap)
#replace "0" with "A", "1" with "H", "NA" with "-"
tbinarymapnet<-tbinarymap[4:nrow(tbinarymap),]
tbinarymapnet[is.na(tbinarymapnet)]<-"-"
tbinarymapnet[tbinarymapnet==0]<-"A"
tbinarymapnet[tbinarymapnet==1]<-"H"
tbinarymap<-rbind(tbinarymap[1:3,],tbinarymapnet)
write.table(tbinarymap,file="mapgenos.csv",quote=F,sep=",",row.names=F,col.names=F,eol="\n")
#add trait data before using in rqtl