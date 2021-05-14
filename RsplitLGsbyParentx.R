library(readr)
binary0 <- read_delim("50916x30727.PT.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
binarypt <- read_delim("50916x30727.PT.parents.GQ10.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
lglist <- read_delim("509.txt", "\t", escape_double = FALSE, trim_ws = TRUE)
#format input file
#lglist<-data.frame(lglist)
lglist[,4]<-lglist[,4]*2
#replace lg by parent type, odd numbers means first parent het, even numbers means second parent het
lglistx<-lglist
for(i in 1:nrow(binarypt)){
  if((lglistx[i,4]>0 & !is.na(binarypt[i,6]) & binarypt[i,6]==1) & (binarypt[i,7]==0 | is.na(binarypt[i,7]))){
    lglist[i,4]<-lglistx[i,4]-1
  } else if((lglistx[i,4]>0 & !is.na(binarypt[i,6]) & binarypt[i,6]==0) & (binarypt[i,7]==1 | is.na(binarypt[i,7]))){
    lglist[i,4]<-lglistx[i,4]
  } else if((lglistx[i,4]>0 & !is.na(binarypt[i,7]) & binarypt[i,7]==1) & (binarypt[i,6]==0 | is.na(binarypt[i,6]))){
    lglist[i,4]<-lglistx[i,4]
  } else if((lglistx[i,4]>0 & !is.na(binarypt[i,7]) & binarypt[i,7]==0) & (binarypt[i,6]==1 | is.na(binarypt[i,6]))){
    lglist[i,4]<-lglistx[i,4]-1
  } else {
    lglist[i,4]<-0
  }
}
write.table(lglist,file="LGs.parent.txt",quote=F,sep="\t",row.names=F,eol="\n")
#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text

