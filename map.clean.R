map.clean<-function(map, geno, blast, r2.thresh = 0.7){
  out<-sapply(map[,1], function(x){
    
    #calculate cor and pull chromosome of markers over thresh
    cor.matrix<-cor(geno[,which(colnames(geno)==x)],
                    geno[,- which(colnames(geno)==x)], 
                    use = "pairwise.complete.obs")
    cor.matrix<-round(cor.matrix ^ 2,6)
    guides <- colnames(cor.matrix)[cor.matrix[1,] > r2.thresh]
    
    #if guides are found...
    #ignore guides of length 1 (no way of knowing which are correct)
    if(length(guides) > 1){
      #pull chromosomes of guides
      guides <- sapply(guides, function(y){ 
        map[,2][which(map[,1] == y)] })
      
      #if there are multiple guides but all on different chromosome
      #we need to take one with the highest R2  
      if(length(guides)==length(unique(guides))){
        #find signpost that is most correlated marker
        sign.post<-colnames(cor.matrix)[which.max(cor.matrix)]
        #pull the chromosome of that marker has the chosen guide
        c <- map[,2][which(map[,1] == sign.post)] 
        
        # if guides are on multiple chromosomes (overlap present) take the most common 
      }else{
        #take most common chromosome in guides
        c <- names(sort(table(guides),decreasing = T))[1]
      }
      
      #check to see if marker is already on most common chromosome in map
      #TRUE if different chromosome
      if(!map[,2][which(map[,1]== x )] == c ){
        #pull blast hits
        b.hits <- blast[which(blast[,1]==x),]
        
        #check if there is a single hit with new chromosome 
        if(any(b.hits[,2] %in% c) &
           sum(b.hits[,2] == c) ==1){
          b.hits[b.hits[,2] %in% c,]#out
          
          #if there is multiple hits on new chromosome...
        }else if( any(b.hits[,2] %in% c) &
                  sum(b.hits[,2] == c) > 1 ){
          #subset hits down to new chromosome
          b.hits<-b.hits[b.hits[,2] %in% c,]
          #find most correlated marker and call this signpost
          sign.post<-colnames(cor.matrix)[cor.matrix[1,] > r2.thresh]
          #subset sign posts down to those on new chromosome
          sign.post<- sign.post[which(sapply(sign.post, 
                                             function(y){map[,2][which(map[,1] == y)] }) == c)]
          #find sign.post with max cor
          sign.post<-names(which.max(cor.matrix[,colnames(cor.matrix) %in% sign.post]))
          #find sign post position
          sign.post<-map[,3][which(map[,1]== sign.post)]
          #take position closest to signpost 
          b.hits[ which.min(abs(b.hits[,3]- sign.post)),]#out
        }
      }
    }
  }      )
  
  #remove null parts
  out<-out[lengths(out) != 0]
  #convert to df and clean names
  out<-do.call(rbind.data.frame, out)
  names(out)<-c("Marker", "Chrom", "Pos")
  out
}