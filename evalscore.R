#Function to evaluate score


evalscore= function(X,Y,compare="RNA",by="gene"){
  
  if(compare=="RNA" & by=="gene"){
          C=as.numeric()
          for(i in rownames(Y)){
                ind=match(i,rownames(X))
                if(is.na(ind)){C[i]=NA
                }else{
                        C[i]=cor(as.numeric(X[ind,]),as.numeric(Y[i,]),use="pairwise.complete.obs")        
                }
                
          }}
          
   
  if(compare=="RNA" & by=="sample"){
    C=as.numeric()
    L=arrange(X,Y,by="row")
    X=L[[1]]
    Y=L[[2]]
    for(i in 1:ncol(X)){C[i]=cor(as.numeric(X[,i]),as.numeric(Y[,i]),use="pairwise.complete.obs")}
  }
  
  if(compare=="pred" & by=="gene"){
    C=as.numeric()
    for(i in 1:ncol(X)){C[i]=cor(as.numeric(X[,i]),as.numeric(Y[i,]),use="pairwise.complete.obs")}
  }
  if(compare=="pred" & by=="sample"){
    C=as.numeric()
    index= match(colnames(X),rownames(Y))
    for(i in 1:nrow(X)){C[i]=cor(as.numeric(X[i,]),as.numeric(Y[index,i]),use="pairwise.complete.obs")}
  }
  
  return(C)
}
