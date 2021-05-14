library(readr)
PT <- read_delim("30508x20801.PT.binary", "\t", escape_double = FALSE, trim_ws = TRUE)
PT<-data.frame(PT)#reformat as a data.frame object
PT<-PT[order(PT$CHROM),]#make sure CHROM column is ordered
#more complex merge, also drop repeated CHROM if out of phase
PTmerge<-PT[1,]
mergeout<-NULL
mergein<-NULL
outphase<-NULL
PT[is.na(PT)]<-2 #replace NAs with 2 for comparing rows later
for(i in 2:nrow(PT)){
  if(PT[i,1]==PT[i-1,1]){
    count<-0
    for(j in 6:ncol(PT)){ #compare rows with same CHROM
      if(PT[i,j]!=PT[i-1,j]){
        count<-count+1
      }
    }
    if((count/(j-5))<0.5){ #if row less then 50% different
      mergeout<-rbind(mergeout,PT[i,1:2])
      mergein<-rbind(mergein,PT[i-1,1:2])
    } else {
      outphase<-c(outphase,PT[i,1])
      #PTmerge<-PTmerge[c(1:nrow(PTmerge)-1),]# drop previous merge for being different phase
    }
  } else {
  PTmerge<-rbind(PTmerge,PT[i,])
  }
}
PTmergenet<-PTmerge
for (k in 1:nrow(PTmerge)){#remove list of out of phase duplicates
  for (l in 1:length(outphase)){
    if(PTmerge[k,1]==outphase[l]){
      PTmergenet<-PTmergenet[-k,]
    }
  }
}
PTmergenet[PTmergenet==2]<-NA
#save the merged file,i'd also suggest saving merge out, and outphase as a record of which rows were removed.
write.table(PTmergenet,file="30508.CHR.merged.binary",quote=F,sep="\t",row.names=F,eol="\n")
write.table(mergeout,file="201x306.PTmergeout.binary",quote=F,sep="\t",row.names=F,eol="\n")
write.table(outphase,file="201x306.PT.outphase.binary",quote=F,sep="\t",row.names=F,eol="\n")
#if run on a windows computer, run these lines to convert the file to linux format after importing to Hamilton
#file nameoffile.ending to view file type dos format is ASCII text, with CRLF line terminators
#sed -i 's/\r$//' nameoffilex.ending to convert file
#file nameoffilex.ending to check file type linux format is ASCII text

#basic merge, keep first of each chrom only
PTmerge<-PT[1,]
mergeout<-NULL
mergein<-NULL
for(i in 2:nrow(PT)){
  if(PT[i,1]!=PT[i-1,1]){
    PTmerge<-rbind(PTmerge,PT[i,])
  } else {
    mergeout<-rbind(mergeout,PT[i,1:2])
    mergein<-rbind(mergein,PT[i-1,1:2])
  }
}  
