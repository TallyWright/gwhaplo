LDplot <- function(geno, map, chrom = "all", save.png= F ){
  require('LDheatmap')
  
  #prepare by merging map with geno
  d <- merge(map, geno, by.x = 1 , by.y = 0)
  d <- d[order(d[,2], d[,3]), ]
  c <- unique(d[,2])
  
  if(chrom == "all"){
    
    #calculate R2
    
    sapply(c, function(x){
      i <- d[d[,2]==x,]
      r2<-as.data.frame(t(i[,-c(1:3)]))
      names(r2) <- i[,1]
      r2 <- round(cor(r2, use="pairwise.complete.obs")^2 , 6)
      
      #plot to R
      
      if(!save.png == T){
        rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space = "rgb")
        LDheatmap(r2,color=rgb.palette(18), add.map=F, title=paste("Pairwise LD on",x))
        #plot to png
      }else{
        png(paste("Pairwise.LD.",x,".png",sep=""),width = 5,height = 5,units = "in", res=300)
        rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space = "rgb")
        LDheatmap(r2,color=rgb.palette(18), add.map=F, title=paste("Pairwise LD on",x))
        dev.off()
      }
      
    })
    #for only only chromosome
  }else{
    #calculate R2
    
    i <- d[d[,2]==chrom,]
    r2<-as.data.frame(t(i[,-c(1:3)]))
    names(r2) <- i[,1]
    r2 <- round(cor( r2, use="pairwise.complete.obs") ^ 2,6)
    
    #plot to R
    if(!save.png == T){
      rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space = "rgb")
      LDheatmap(r2,color=rgb.palette(18), add.map=F, title=paste("Pairwise LD on",chrom))
      #plot to png
    }else{
      png(paste("Pairwise.LD.",chrom,".png",sep=""),width = 5,height = 5,units = "in", res=300)
      rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space = "rgb")
      LDheatmap(r2,color=rgb.palette(18), add.map=F, title=paste("Pairwise LD on",chrom))
      dev.off()
    }
  }
}