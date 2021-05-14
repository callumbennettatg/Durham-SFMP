setwd("C:/Users/Forxb/Documents/Masters/QTL analysis/blob/")
blob <- read.delim("oldans.txt")
#split markers greater than 50 cM distance
LG<-1
LGs<-1
for(i in 1:(nrow(blob)-1)){
  if(blob$consensus[i+1]-blob$consensus[i]<49){
    LGs<-c(LGs,LG)
  } else {
    LG<-LG+1
    LGs<-c(LGs,LG)
  }
}
LGblob<-cbind(LGs,blob[,1:2])

#find eight largest LG groups
library(data.table)
LGssort<-sort(table(rleid(LGs)),decreasing=T)
LGssort

#extract markers in largest LG groups
LGnew<-NULL
LGout<-NULL
for(i in 1:8){
  LGout<-rbind(LGout,subset(LGblob,LGblob$LGs==as.numeric(names(LGssort)[i])))
  LGnew<-c(LGnew,rep(i,nrow(subset(LGblob,LGblob$LGs==as.numeric(names(LGssort)[i])))))
}
LGout<-cbind(LGnew,LGout)

#restart each LG at position zero
position<-0
for(i in 1:(nrow(LGout)-1)){
  if(LGout$LGnew[i+1]-LGout$LGnew[i]>0){
    position<-c(position,0)
  } else {
    position<-c(position,position[i]+(LGout$consensus[i+1]-LGout$consensus[i]))
  }
}
LGoutzero<-cbind(LGout, position)
LGoutzero
write.table(LGoutzero,file="unfilteredLGS.txt",quote=F,sep="\t",row.names=F,eol="\n")

#filter markers by same position first
filterblob<-blob[1,]
for(i in 1:(nrow(blob)-1)){
  if(blob$consensus[i+1]-blob$consensus[i]>0){
    filterblob<-rbind(filterblob,blob[i+1,])
  }
}

#repeat earlier steps with filterblob instead of blob
#split markers greater than 50 cM distance
filterLG<-1
filterLGs<-1
for(i in 1:(nrow(filterblob)-1)){
  if(filterblob$consensus[i+1]-filterblob$consensus[i]<49){
    filterLGs<-c(filterLGs,filterLG)
  } else {
    filterLG<-filterLG+1
    filterLGs<-c(filterLGs,filterLG)
  }
}
LGfilterblob<-cbind(filterLGs,filterblob[,1:2])

#find eight largest LG groups
library(data.table)
filterLGssort<-sort(table(rleid(filterLGs)),decreasing=T)
filterLGssort

#extract markers in largest LG groups
filterLGnew<-NULL
filterLGout<-NULL
for(i in 1:8){
  filterLGout<-rbind(filterLGout,subset(LGfilterblob,LGfilterblob$filterLGs==as.numeric(names(filterLGssort)[i])))
  filterLGnew<-c(filterLGnew,rep(i,nrow(subset(LGfilterblob,LGfilterblob$filterLGs==as.numeric(names(filterLGssort)[i])))))
}
filterLGout<-cbind(filterLGnew,filterLGout)
filterLGout

#restart each LG at position zero
filterposition<-0
for(i in 1:(nrow(filterLGout)-1)){
  if(filterLGout$filterLGnew[i+1]-filterLGout$filterLGnew[i]>0){
    filterposition<-c(filterposition,0)
  } else {
    filterposition<-c(filterposition,filterposition[i]+(filterLGout$consensus[i+1]-filterLGout$consensus[i]))
  }
}
filterLGoutzero<-cbind(filterLGout, filterposition)
filterLGoutzero
write.table(filterLGoutzero,file="filteredLGs.txt",quote=F,sep="\t",row.names=F,eol="\n")


#filter version with 48 instead of 50
#repeat earlier steps with filterblob instead of blob
#split markers greater than 50 cM distance
filterLG<-1
filterLGs<-1
for(i in 1:(nrow(filterblob)-1)){
  if(filterblob$consensus[i+1]-filterblob$consensus[i]<49){
    filterLGs<-c(filterLGs,filterLG)
  } else {
    filterLG<-filterLG+1
    filterLGs<-c(filterLGs,filterLG)
  }
}
LGfilterblob<-cbind(filterLGs,filterblob[,1:2])

#find eight largest LG groups
library(data.table)
filterLGssort<-sort(table(rleid(filterLGs)),decreasing=T)
filterLGssort

#extract markers in largest LG groups
filterLGnew<-NULL
filterLGout<-NULL
for(i in 1:8){
  filterLGout<-rbind(filterLGout,subset(LGfilterblob,LGfilterblob$filterLGs==as.numeric(names(filterLGssort)[i])))
  filterLGnew<-c(filterLGnew,rep(i,nrow(subset(LGfilterblob,LGfilterblob$filterLGs==as.numeric(names(filterLGssort)[i])))))
}
filterLGout<-cbind(filterLGnew,filterLGout)
filterLGout

#restart each LG at position zero
filterposition<-0
for(i in 1:(nrow(filterLGout)-1)){
  if(filterLGout$filterLGnew[i+1]-filterLGout$filterLGnew[i]>0){
    filterposition<-c(filterposition,0)
  } else {
    filterposition<-c(filterposition,filterposition[i]+(filterLGout$consensus[i+1]-filterLGout$consensus[i]))
  }
}
filterLGoutzero<-cbind(filterLGout, filterposition)
filterLGoutzero


