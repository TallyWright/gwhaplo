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

## map.clean

### Description 

A method for improving chromosome positioning for physical anchoring of markers using $R^{2}$. $R^{2}$ is calculated for each mapped marker vs. all other markers. All markers above a defined $R^{2}$ threshold are found and the most common chromosome of the markers in that bin is taken. If this chromosome is different to the one currently in the map, blast hits are used to re-position the marker to the new chromosome, if at least one blast hit is present for that chromosome. If multiple BLAST hits are available for the new chromosome, the BLAST hit closest to whichever marker in the bin with the highest $R^{2}$ to the target marker is taken as the position. If all markers used as guides are found on different chromosomes, the chromosome of the marker with the highest $R^{2}$ to the target marker is used as the guide.   

### Usage 

`map.clean(map, geno, blast, r2.thresh = 0.7)`

### Arguments

`map`  A physical map to be improved, stored in a dataframe with three columns in the following order: marker names, chromosome and position.

`geno` Numeric SNP dataframe with marker names as column headers and genotype names as row names. 

`blast` blast hits for a marker probe, stored in a dataframe with three columns: marker names, chromosome and position. Multiple hits are expected for each marker, typically generated using BLAST+.

`r2.thresh` the cut off for defining the bin of correlated markers to use as a guide. The default is 0.7.   