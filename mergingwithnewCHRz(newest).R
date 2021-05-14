#combine chrom,pos,id,ref,alt to make unique identifiers
library(readr)
X20108 <- read_delim("201x306.PTmergedrows.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
X20706 <- read_delim("207X309.PTmergedrows.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
X20804 <- read_delim("208x307.PTmergedrows.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
X30311 <- read_delim("303x204.PTmergedrows.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
X30508 <- read_delim("305x208.PTmergedrows.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
# make a list of the files
filelist<-list(as.matrix(X20108),as.matrix(X20706),as.matrix(X20804),as.matrix(X30311),as.matrix(X30508))
#prepare some initial items from the first file
file1<-filelist[[1]]
CHROM<-file1[,1]
ids<-paste(file1[,1],file1[,2],file1[,3],file1[,4],file1[,5],sep="_")
allids<-data.frame(CHROM,ids)#this item will store the merged ids from each file
allinds<-file1[,c(1,7:ncol(file1))]#this item will store the merged genotypes from each file
#add to these items from the rest of the files in the list
for (i in filelist[2:length(filelist)]){
  CHROM<-i[,1]
  ids<-paste(i[,1],i[,2],i[,3],i[,4],i[,5],sep="_")
  chromids<-data.frame(CHROM,ids)
  allids<-merge(allids,chromids,by="CHROM",all=T)
  allinds<-merge(allinds,i[,c(1,7:ncol(i))],by="CHROM",all=T)
}
#combine the allids file into one column, the last id column with a value will be kept
lastids<-NULL
id<-NULL
for (j in 1:nrow(allids)){
  for (k in 2:ncol(allids[j,])){
    if(!is.na(allids[j,k])){
      id<-as.character(allids[j,k])
    }
  }
  lastids<-rbind(lastids,id)
  id<-NULL
}
finalinds<-data.frame(lastids,allinds[2:ncol(allinds)])
#replace id columns
library(tidyr)
finalinds<-separate(data=finalinds,col=lastids,into=c("CHROM","POS","ID","REF","ALT"),sep="_")

#write file
write.table(finalinds,file="mergerowcolsPT.binary",quote=F,sep="\t",row.names=F,eol="\n")



#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text

#optional give values to the ID column
finalinds$ID<-rownames(finalinds)

#optional, keep a record of the ids per file
write.table(allids,file="mergerowcolsPT.ids",quote=F,sep="\t",row.names=F,eol="\n")