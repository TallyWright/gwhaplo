HAPselect<-function(data,sampling.no,starting.genotype){
  
  #make temp form of data
  temp<-data
  
  
  #count total haplotypes across whole dataset
  total_hap<-sum(apply(temp, 2, function(x) length(unique(x))))
  print(paste("Total haplotypes in this data =",total_hap))
  
  
  
  #selects the starting genotype
  selected_haps<-temp[which(row.names(temp)==starting.genotype), ]
  #starting genotype then removed
  temp<-temp[!row.names(temp) %in% row.names(selected_haps),]
  
  
  
  #run sampling via loop selection
  for (i in 1:(sampling.no-1)){
    #find line that offers most unique haplotypes to already selected
    sel<-names(which.max(
      sapply(
        #bind selected haplotypes to each possible candidate
        apply(temp,1,function(x){rbind(selected_haps,x)}),
        #work through each bin and count number of haplotypes per block
        function(y){
          sum(apply(y, 2, function(z) length(unique(z))))
        })))
    #add sel to selected haplotypes 
    selected_haps<-rbind(selected_haps,temp[which(row.names(temp)==sel),])
    #new selection is then removed
    temp<-temp[!row.names(temp) %in% row.names(selected_haps),]
    #prints proportion of haps captured in haps_captured object at each run
    print(paste("Proportion of haplotypes captured with",
                i+1,
                "genotypes in selection =",
                sum(sapply(selected_haps, function(x) length(unique(x))))/total_hap))
    #cut process if all haplotypes are captured
    if ((sum(sapply(selected_haps, function(x) length(unique(x))))/total_hap)==1) break
  }
  selected_haps
}