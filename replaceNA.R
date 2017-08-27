#Since NA are "Non expressed"
replaceNA= function(data,factor=1){
  count= sum(is.na(data))
  for(i in 1:nrow(data)){
    m=min(data[i,],na.rm=T)
    data[i,is.na(data[i,])]<-m-factor
  }
  cat(paste(count," NAs replaced"))
  return(data)
}

