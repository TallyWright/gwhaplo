# gwhaplo - Tools for genome-wide haplotype characterisation with R^2^

*Work in progress*

# Functions: 

## LDplot

### Description 
A wrapper for the LDheatmap function (Shin et al. 2006) where R^2^ is calculated on each chromosome and plotted as a heatmap.  

### Usage 

`LDplot(geno, map, chrom = "all", save.png=F)`

### Arguments

`geno` Numeric SNP dataframe with genotype names as column headers and marker names as row names. 

`map`  A genetic or physical map stored in a dataframe with three columns in the following order: marker names, chromosome and position. 

`chrom` "all" will plot all chromosomes. Alternatively, individual chromosomes can be specified.

`save.png` If `F` plots will be plotted within R, if `T` they will be saved individually as png files. 
