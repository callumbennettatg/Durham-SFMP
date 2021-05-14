library(qtl)
file1 <- read.cross("csv", ".", "mapgenos.csv")  #read in file

#Single QTL method
#calculates conditional genotype probabilities given the multipoint marker data
file1 <- read.cross("csv", ".", "mapgenos.csv")  #read in file
file1 <-calc.genoprob(file1, step=0, off.end=0, error.prob=0.0001,  
              map.function=c("kosambi"),
              stepwidth=c("fixed"))
#calculates LOD score
out.em <-scanone(file1)
#plots LOD scores
plot(out.em, col= "red")
#permutation testing to only get significant QTLs
operm.hk <-scanone(file1b,method="hk",n.perm=1000)
summary(out.em,perms=operm.hk,alpha=0.05,pvalues=TRUE)

#multiple QTL method- two-dimensional genome scan with a two-QTL model
file1 <- read.cross("csv", ".", "mapgenos.csv")  #read in file
file1b <-calc.genoprob(file1, step=0, off.end=0, error.prob=0.0001,  
                       map.function=c("kosambi"),
                       stepwidth=c("fixed"))
out.em <-scantwo(file1b)
plot(out.em, col= "redblue")
operm.hk <-scanone(file1b,method="hk",n.perm=1000)
summary(out.em,perms=operm.hk,alpha=0.05,pvalues=TRUE)

redblue/gray/heat/topo