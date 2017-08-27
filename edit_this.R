#Proteomic challenge

clonedir= "D:/Users/Marti/Downloads/elasticnet-master"
datadir= paste(clonedir,"Data",sep="/")

source(paste(clonedir,"arrange.R",sep="/"))
source(paste(clonedir,"evalscore.R",sep="/"))
source(paste(clonedir,"replaceNA.R",sep="/"))
source(paste(clonedir,"arrange.R",sep="/"))

setwd(datadir)

#CNA= read.table("retrospective_breast_CNA_median_sort_common_gene_16884.txt",header=T,row.names=1,sep="\t")
#PROT= read.table("retrospective_breast_proteome_all_gene.txt",header=T,row.names=1,sep="\t")
PROTF= read.table("retrospective_breast_proteome_filtered.txt",header=T,row.names=1,sep="\t")
RNA= read.table("retrospective_breast_rna_seq_sort_common_gene_15115.txt",header=T,row.names=1,sep="\t")


colnames(RNA)= substr(colnames(RNA),1,7)
colnames(PROTF)= substr(colnames(PROTF),6,12)


L= arrange(RNA,PROTF,by="col")

X=L[[1]]
Y=L[[2]]

source(paste(clonedir,"RUN.R",sep="/"))

