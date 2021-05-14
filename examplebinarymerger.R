#combine chrom,pos,id,ref,alt to make unique identifiers
X20108<-as.matrix(X20108)
X20706<-as.matrix(X20706)
X20804<-as.matrix(X20804)
X30311<-as.matrix(X30311)
X30508<-as.matrix(X30508)


ids<-paste(X20108[,1],X20108[,2],X20108[,3],X20108[,4],X20108[,5],sep="_")
X20108<-data.frame(ids,X20108)
ids<-paste(X20706[,1],X20706[,2],X20706[,3],X20706[,4],X20706[,5],sep="_")
X20706<-data.frame(ids,X20706)
ids<-paste(X20804[,1],X20804[,2],X20804[,3],X20804[,4],X20804[,5],sep="_")
X20804<-data.frame(ids,X20804)
ids<-paste(X30311[,1],X30311[,2],X30311[,3],X30311[,4],X30311[,5],sep="_")
X30311<-data.frame(ids,X30311)
ids<-paste(X30508[,1],X30508[,2],X30508[,3],X30508[,4],X30508[,5],sep="_")
X30508<-data.frame(ids,X30508)
#merge pairs of files by ids, drop separate id columns 2 to 6, replace missing inds with NA
merged<-merge(X20108[,c(1,7:ncol(X20108))],X20706[,c(1,7:ncol(X20706))],by="ids",all=T)
merged<-merge(merged,X20804[,c(1,7:ncol(X20804))],by="ids",all=T)
merged<-merge(merged,X30311[,c(1,7:ncol(X30311))],by="ids",all=T)
merged<-merge(merged,X30508[,c(1,7:ncol(X30508))],by="ids",all=T)


#replace id columns
library(tidyr)
merged<-separate(data=merged,col=ids,into=c("CHROM","POS","ID","REF","ALT"),sep="_")
#write file
write.table(merged,file="2x3.new.binary",quote=F,sep="\t",row.names=F,eol="\n")

#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text

