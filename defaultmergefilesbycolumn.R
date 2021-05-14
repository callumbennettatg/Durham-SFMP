setwd("C:/Users/acebr/OneDrive - Durham University/Protocols/R")
#example files
file1<-data.frame(c(1,2,3,4,5),c(6,7,8,9,10),rep(".",5),rep("A",5),rep("C",5),c(1,NA,1,NA,1),c(1,NA,1,NA,1))
colnames(file1)<-c("chrom","pos","id","ref","alt","ind1","ind2")
file2<-data.frame(c(4,5,11,12,13,14,15),c(9,10,16,17,18,19,20),rep(".",7),rep("A",7),rep("C",7),c(NA,1,1,NA,1,NA,1),c(1,NA,1,NA,1,NA,1))
colnames(file2)<-c("chrom","pos","id","ref","alt","ind3","ind4")
file3<-data.frame(c(4,14,15),c(9,19,20),rep(".",3),rep("A",3),rep("C",3),c(NA,1,1),c(1,NA,NA))
colnames(file3)<-c("chrom","pos","id","ref","alt","ind5","ind6")
#combine chrom,pos,id,ref,alt to make unique identifiers
idz<-paste(file1[,1],file1[,2],file1[,3],file1[,4],file1[,5],sep="_")
file1<-data.frame(idz,file1)
idz<-paste(file2[,1],file2[,2],file2[,3],file2[,4],file2[,5],sep="_")
file2<-data.frame(idz,file2)
idz<-paste(file3[,1],file3[,2],file3[,3],file3[,4],file3[,5],sep="_")
file3<-data.frame(idz,file3)
#merge pairs of files by ids, drop separate id columns 2 to 6, replace missing inds with NA
files<-merge(file1[,c(1,7:ncol(file1))],file2[,c(1,7:ncol(file2))],by="idz",all=T)
files<-merge(files,file3[,c(1,7:ncol(file3))],by="idz",all=T)
#replace id columns
library(tidyr)
files<-separate(data=files,col=ids,into=c("CHROM","POS","ID","REF","ALT"),sep="_")
#output tab delimited file
write.table(files,file="fileout.binary",quote=F,sep="\t",row.names=F,eol="\n")
#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text
