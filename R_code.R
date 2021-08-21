##The code presented below could assist you in making correlations between  
##Biological feature (Leaf area index, Biomass, Leaf water potential) and Normalized Difference spectral indices.
library(tidyverse)
library(reshape2)
spectra_pearson_r<-function(spectra,feature) {
  ndsi_matrix<-matrix(data=NA,nrow=ncol(spectra),ncol=ncol(spectra))
  for (row in 1:nrow(ndsi_matrix)) {
    for (col in 1:ncol(ndsi_matrix)) {
      if (col>row) {
        ndsi<-(spectra[,row]-spectra[,col])/(spectra[,row]+spectra[,col])
        cor_ndsi<-cor(ndsi,feature,method = "pearson")
        ndsi_matrix[row,col]<-cor_ndsi
      }
    }
  }
  colnames(ndsi_matrix)<-colnames(spectra)%>%str_remove("X")
  rownames(ndsi_matrix)<-colnames(spectra)%>%str_remove("X")
  pl<-ndsi_matrix%>%melt()%>%filter(!is.na(value))%>%ggplot(aes(x=Var1,y=Var2,fill=value))+geom_tile()+xlab("Wavelength(nm)")+ylab("Wavelength(nm)")+theme_classic()+labs(fill="R")
  melt_df<-ndsi_matrix%>%melt()%>%filter(!is.na(value))
  return(list(pl,melt_df))
}

##same function but for P value
spectra_pearson_p<-function(spectra,feature) {
  ndsi_matrix<-matrix(data=NA,nrow=ncol(spectra),ncol=ncol(spectra))
  for (row in 1:nrow(ndsi_matrix)) {
    for (col in 1:ncol(ndsi_matrix)) {
      if (col>row) {
        ndsi<-(spectra[,row]-spectra[,col])/(spectra[,row]+spectra[,col])
        cor_ndsi<-cor.test(ndsi,feature,method = "pearson")
        if (cor_ndsi[[3]]<0.05) {ndsi_matrix[row,col]<-cor_ndsi[[3]]} else {ndsi_matrix[row,col]<-NA}
      }
    }
  }
  colnames(ndsi_matrix)<-colnames(spectra)%>%str_remove("X")
  rownames(ndsi_matrix)<-colnames(spectra)%>%str_remove("X")
  pl<-ndsi_matrix%>%melt()%>%filter(!is.na(value))%>%ggplot(aes(x=Var1,y=Var2,fill=value))+geom_tile()+xlab("Wavelength(nm)")+ylab("Wavelength(nm)")+theme_classic()+labs(fill="P Value")
  melt_df<-ndsi_matrix%>%melt(na.rm = F)%>%filter(!is.na(value))
  return(list(pl,melt_df))
}