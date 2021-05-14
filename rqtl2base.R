setwd("C:/Users/Forxb/Documents/Masters/QTL analysis/1a_cali51109_50916/")

#all traits in RQTL2
#loading in file from rqtl format
library(qtl)
file <- read.cross("csv", file="alltraits.csv")
#conversion to rqtl2 format
library(qtl2)
file1 <- convert2cross2(file)
#mapping
map <- insert_pseudomarkers(file1$gmap, step=1)
pr <- calc_genoprob(file1, map, error_prob=0.0001)
pr2 <- calc_genoprob(file1, file1$gmap, error_prob=0.0001)
out <- scan1(pr, file1$pheno)
#Segregation distortion test-what value should be chosen?
gt <- geno.table(file)
gtlist <- gt[ gt$P.value < 0.15, ]
#Summary stats and graph of LOD scores
summary(out)
par(mar=c(5.1, 4.1, 1.1, 1.1))
ymx <- maxlod(out) # overall maximum LOD score
plot(out, map, lodcolumn=1, col="dodgerblue", ylim=c(0, ymx*1.02))
plot(out, map, lodcolumn=2, col="darkgreen", add=TRUE)
plot(out, map, lodcolumn=3, col="green", add=TRUE)
plot(out, map, lodcolumn=4, col="black", add=TRUE)
plot(out, map, lodcolumn=5, col="orange", add=TRUE)
plot(out, map, lodcolumn=6, col="darkmagenta", add=TRUE)
plot(out, map, lodcolumn=7, col="yellow", add=TRUE)
plot(out, map, lodcolumn=8, col="deeppink1", add=TRUE)
legend("topleft", "Legend", cex=0.5, pch=1, pt.cex = 1, lwd=2, col=c("dodgerblue", "darkgreen", "green", "black", "orange", "darkmagenta", "yellow", "deeppink1"), colnames(out), bg="gray90")
#finding stronger peaks-drop is amount within a nearby QTL can be to be included
find_peaks(out, file1$gmap, threshold=1.9, drop=0.5)
peaks <- find_peaks(out, file1$gmap, threshold=1.5, drop=0.5)
#permutation testing
operm <- scan1perm(pr, file1$pheno, n_perm=1000)
pvalues <- summary(operm, alpha=c(0.2, 0.15, 0.1, 0.05))
summary(operm, alpha=c(0.2, 0.15, 0.1, 0.05))

#estimating QTL effect size- needs to be done for each sig SNP and trait
c2eff <- scan1coef(pr2[,"8"], file1$pheno[,"RosetteDiameter1"])
plot_coef(c2eff, file1$gmap["8"], columns = 1:3, scan1_output = out, 
          main = "Chromosome 8 QTL effects and LOD scores",
          legend = "topleft")

c2eff2 <- scan1coef(pr2[,"8"], file1$pheno[,"LengthLargestSpineCm"])
plot_coef(c2eff2, file1$gmap["8"], columns = 1:3, scan1_output = out, 
          main = "Chromosome 8 QTL effects and LOD scores",
          legend = "topleft")


#plotting the raw phenotypes against the genotypes at a single putative QTL position- works but not for pseudopositions
g <- maxmarg(pr, map, chr=5, pos=184.308, return_char=TRUE)
par(mar=c(4.1, 4.1, 0.6, 0.6))
plot_pxg(g, file1$pheno[,"RD2"], ylab="RD2 phenotype", SEmult=1)






#Additive/dominance-first command won't work due to contrast
c2effB <- scan1coef(pr[,"2"], file1$pheno[,"RD2"],
                    contrasts=cbind(mu=c(1,1,1), a=c(-1, 0, 1), d=c(0, 1, 0)))
par(mar=c(4.1, 4.1, 1.1, 2.6), las=1)
plot(c2effB, map["2"], columns=2:3, col=col)
last_coef <- unclass(c2effB)[nrow(c2effB),2:3] # last two coefficients
for(i in seq(along=last_coef))
  axis(side=4, at=last_coef[i], names(last_coef)[i], tick=FALSE, col.axis=col[i])