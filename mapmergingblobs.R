library(LPmerge)
library(readr)
mapI <- read.delim("201.1.0.ordered.mstmap", header=FALSE, row.names=NULL)
mapII <- read.delim("207.1.0.ordered.mstmap", header=FALSE, row.names=NULL)
mapIII <- read.delim("208.1.0.ordered.mstmap", header=FALSE, row.names=NULL)
maps <- list(I=mapI,II=mapII,III=mapIII)
ans <- LPmerge(maps, max.interval = 200, weights = NULL)
write.table(ans[[1]][,1:ncol(ans[[1]])],file=paste("ans",sep=""),quote=F,sep="\t",row.names=F)



install.packages("LPmerge")

mapI <- data.frame(marker=c("A","B","C","D","E","F","G"),position=0:6)
mapII <- data.frame(marker=c("A","C","B","D","E","F","G"),position=0:6)
mapIII <- data.frame(marker=c("A","B","C","D","E","G","F"),position=0:6)
mapIV <- data.frame(marker=c("A","B","C","D","E","F","G"),position=0:6)
maps <- list(I=mapI,II=mapII,III=mapIII,IV=mapIV)
ans <- LPmerge(maps, max.interval = 2, weights = NULL)
