library(readr)
binary0 <- read_delim("30508.CHR.merged.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
parents0 <- read_delim("30508x20801.PT.parents.GQ10.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
#make a chrom plus pos column
binary0<-as.matrix(binary0)
binaryids<-paste(binary0[,1],binary0[,2],sep="_")
binary0<-data.frame(binaryids,binary0)
parents0<-as.matrix(parents0)
parentsids<-paste(parents0[,1],parents0[,2],sep="_")
parents0<-data.frame(parentsids,parents0)
#keep only shared rows
shared<-intersect(parentsids,binaryids)
shareparents<-subset(parents0,parents0[,1]%in%shared)
sharebinary<-subset(binary0,binary0[,1]%in%shared)
#write files
write.table(shareparents[,2:ncol(shareparents)],file="30311.PT.parents.GQ10.shared.binary",quote=F,sep="\t",row.names=F,eol="\n")
#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text
write.table(allids,file="20804.PTmergedrows.shared.binary",quote=F,sep="\t",row.names=F,eol="\n")
