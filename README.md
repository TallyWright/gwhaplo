# gwhaplo - Tools for genome-wide haplotype characterisation with $R^{2}$

*Work in progress*

# Functions: 

## LDplot

### Description 
A wrapper for the LDheatmap function (Shin et al. 2006) where $R^{2}$ is calculated on each chromosome and plotted as a heatmap.  

### Usage 

`LDplot(geno, map, chrom = "all", save.png=F)`

### Arguments

`geno` Numeric SNP dataframe with genotype names as column headers and marker names as row names. 

`map`  A genetic or physical map stored in a dataframe with three columns in the following order: marker names, chromosome and position. 

`chrom` "all" will plot all chromosomes. Alternatively, individual chromosomes can be specified.

`save.png` If `F` plots will be plotted within R, if `T` they will be saved individually as png files. 

 

## HAPselect


### Description 

A haplotype selection algorithm that works by adding individuals into a core selection. The selection starts with a user specified individual and further individuals are added to the selection that offer the most unique haplotypes. The selection stops when the desired core individual number is reached or all haplotypes are captured already. 


### Usage 

`HAPselect(data,sampling.no,starting.genotype)`

### Arguments

`data` a haplotype matrix with block(haplotype) name in column headers and individual name in row names. Not tested with missing data present. 

`sampling.no` specify the number of individuals to take in the selection

`starting.genotype` specify starting genotype (should match row name). 
