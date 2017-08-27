#Proteomic challenge
setwd("D:/Users/Marti/Downloads/elasticnet-master/Data")

CNA= read.table("retrospective_breast_CNA_median_sort_common_gene_16884.txt",header=T,row.names=1,sep="\t")
PROT= read.table("retrospective_breast_proteome_all_gene.txt",header=T,row.names=1,sep="\t")
PROTF= read.table("retrospective_breast_proteome_filtered.txt",header=T,row.names=1,sep="\t")
RNA= read.table("retrospective_breast_rna_seq_sort_common_gene_15115.txt",header=T,row.names=1,sep="\t")


colnames(RNA)= substr(colnames(RNA),1,7)
colnames(PROTF)= substr(colnames(PROTF),6,12)


L= arrange(RNA,PROTF,by="col")

X=L[[1]]
Y=L[[2]]
