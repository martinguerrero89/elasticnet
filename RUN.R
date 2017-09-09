
#Baseline correlation

geneC= evalscore(X,Y,compare="RNA",by="gene")
sampleC= evalscore(X,Y,compare="RNA",by="sample")

print(paste("baseline correlation is", mean(geneC,na.rm=T),sep=" "))

#xx=apply(X,1,function(x) sum(is.na(x)))
#out= which(xx==ncol(X))
#Xc=replaceNA(X[-out,])
Xc=replaceNA(X)
Yc=replaceNA(Y)

#Baseline correlation with NA input
geneCc= evalscore(Xc,Yc,compare="RNA",by="gene")
sampleCc= evalscore(Xc,Yc,compare="RNA",by="sample")

print(paste("baseline correlation without NAs is", mean(geneCc,na.rm=TRUE),sep=" "))

#Create training and test set
wheel= sample(1:ncol(X),ncol(X)*0.8)
trainX= Xc[,wheel]
testX= Xc[,-wheel]
trainY= Yc[,wheel]
testY= Yc[,-wheel]


Xtrain=t(as.matrix(trainX))
Xtest=t(as.matrix(testX))

Ytrain=t(as.matrix(trainY))
Ytest=t(as.matrix(testY))

library(parallel)
library(doParallel)
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)
require(glmnet)

COEF= list()
for (i in 1:20){#nrow(trainY)
  
  cvfit = cv.glmnet(Xtrain,as.numeric(trainY[i,]), parallel = TRUE,type.measure = "mse",alpha=0.5,nfold=ncol(trainY),
                    standardize=TRUE,type.gaussian="naive")
  Cof= coef(cvfit, s = "lambda.min")
  colnames(Cof)=rownames(trainY)[i]
  COEF[[i]]=as.matrix(Cof)
  print(i)
}

COEFm= do.call(cbind,COEF)

#Matrix resolution with coeff

intercept=1
Xx=cbind(intercept,Xtest)
pred= Xx%*%COEFm

Xxt=cbind(intercept,Xtrain)
predt= Xxt%*%COEFm

geneCc2= evalscore(pred,testY,compare="pred",by="gene")
sampleCc2= evalscore(pred,testY,compare="pred",by="sample")

print(paste("predicted correlation is", mean(geneCc2,na.rm=TRUE),sep=" "))


COEF2= list()
for (i in 1:20){#nrow(trainY)
  
  cvfit = cv.glmnet(predt,as.numeric(trainY[i,]), parallel = TRUE,type.measure = "mse",nfold=nrow(Xtrain))
  Cof= coef(cvfit, s = "lambda.min")
  colnames(Cof)=rownames(trainY)[i]
  COEF2[[i]]=as.matrix(Cof)
  print(i)
}

COEFm2= do.call(cbind,COEF2)

#Matrix resolution with coeff


intercept=1
Xx=cbind(intercept,Xtest)

pred= Xx%*%COEFm
Xx2=cbind(intercept,pred)
pred2= Xx2%*%COEFm2

geneCc3= evalscore(pred2,testY,compare="pred",by="gene")
sampleCc3= evalscore(pred2,testY,compare="pred",by="sample")

print(paste("predicted post model correlation is", mean(geneCc3),sep=" "))


