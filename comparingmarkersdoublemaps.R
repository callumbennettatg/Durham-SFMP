#first in linux use 
#mkdir newdirname
#to make new directories and 
#cp pathto/sourcedir/*.0.ordered.mstmap pathto/newdirname/
#to make maps to new directories
library(readr)
setwd("C:/Users/Forxb/My Documents/Masters/map comparison/")
#import first family phase 1 files
readx<-function(x) {
  read_tsv(x,col_names=c("snp","lg","dist"))
}
setwd("C:/Users/Forxb/My Documents/Masters/map comparison/spain/1/")
temp = list.files(pattern="*.mstmap")
fam1p1 = lapply(temp, readx)
#reorder by numerical lg name
names(fam1p1)<-c("A","J","K","L","M","N","O","P")
fam1p1<-fam1p1[sort(names(fam1p1))]
#second family smae steps
setwd("C:/Users/Forxb/My Documents/Masters/map comparison/spain/2/")
temp = list.files(pattern="*.mstmap")
fam2p1 = lapply(temp, readx)
#reorder by numerical lg name
names(fam2p1)<-c("A","J","K","L","M","N","O","P")
fam2p1<-fam2p1[sort(names(fam2p1))]
#compare fam1evens as rows, fam2evens as columns
pairlist<-NULL
alllist<-NULL
for(i in 1:length(fam1p1)){
  for (j in 1:length(fam2p1)){
    test1<-data.frame(fam1p1[[i]])
    test2<-data.frame(fam2p1[[j]])
    pairlist<-c(pairlist,length(intersect(test1[,1],test2[,1])))
  }
  alllist<-rbind(alllist,pairlist)
  pairlist<-NULL
}
rownames(alllist)<-1:nrow(alllist)
colnames(alllist)<-1:ncol(alllist)
compareevens<-alllist
compareevens
heatmap(compareevens,Rowv=NA,Colv=NA,scale="none")
#find highest matching lgs and compare with second highest matching
matchevens<-rep(NA,6)
for(i in 1:nrow(compareevens)){
  lg<-rownames(compareevens)[i]
  match<-names(sort(compareevens[i,],decreasing=T))[1]
  matchno<-max(compareevens[i,])
  match2<-names(sort(compareevens[i,],decreasing=T))[2]
  matchno2<-sort(compareevens[i,],decreasing=T)[2]
  matchdiff<-matchno-sort(compareevens[i,],decreasing=T)[2]
  matchevens<-rbind(matchevens,c(lg,match,matchno,match2,matchno2,matchdiff))
}
colnames(matchevens)<-c("lg","match","matchno","match2","matchno2","matchdiff")
rownames(matchevens)<-NULL
matchevens<-data.frame(matchevens[2:nrow(matchevens),])
matchevens

#compare fam1odds as rows, fam2odds as columns
pairlist<-NULL
alllist<-NULL
for(i in 1:length(fam1odds)){
  for (j in 1:length(fam2odds)){
    test1<-data.frame(fam1odds[[i]])
    test2<-data.frame(fam2odds[[j]])
    pairlist<-c(pairlist,length(intersect(test1[,1],test2[,1])))
  }
  alllist<-rbind(alllist,pairlist)
  pairlist<-NULL
}
rownames(alllist)<-1:nrow(alllist)
colnames(alllist)<-1:ncol(alllist)
compareodds<-alllist
compareodds
heatmap(compareodds,Rowv=NA,Colv=NA,scale="none")
#find highest matching lgs and compare with second highest matching
matchodds<-rep(NA,6)
for(i in 1:nrow(compareodds)){
  lg<-rownames(compareodds)[i]
  match<-names(sort(compareodds[i,],decreasing=T))[1]
  matchno<-max(compareodds[i,])
  match2<-names(sort(compareodds[i,],decreasing=T))[2]
  matchno2<-sort(compareodds[i,],decreasing=T)[2]
  matchdiff<-matchno-sort(compareodds[i,],decreasing=T)[2]
  matchodds<-rbind(matchodds,c(lg,match,matchno,match2,matchno2,matchdiff))
}
colnames(matchodds)<-c("lg","match","matchno","match2","matchno2","matchdiff")
rownames(matchodds)<-NULL
matchodds<-data.frame(matchodds[2:nrow(matchodds),])
matchodds
