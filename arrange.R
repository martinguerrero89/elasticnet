#Function to arrange datasets


arrange= function (x,y, by="both") {
  if(by=="row"){
    l= rownames(x) %in% rownames(y)
    r= rownames(y) %in% rownames(x)
    x=x[l,]
    y=y[r,]
    i= match(rownames(x), rownames(y))
    L=list(x[i,],y)
  }
  if(by=="col"){
    l= colnames(x) %in% colnames(y)
    r= colnames(y) %in% colnames(x)
    x=x[,l]
    y=y[,r]
    i= match(colnames(x), colnames(y))
    L=list(x[,i],y)
  }
  if(by=="both"){
    lc= colnames(x) %in% colnames(y)
    rc= colnames(y) %in% colnames(x)
    x=x[,lc]
    y=y[,rc]
    ic= match(colnames(x), colnames(y))
    x=x[,ic]
    
    lr= rownames(x) %in% rownames(y)
    rr= rownames(y) %in% rownames(x)
    x=x[lr,]
    y=y[rr,]
    ir= match(rownames(x), rownames(y))
    L=list(x[ir,],y)
    
  }
  return(L)
}
