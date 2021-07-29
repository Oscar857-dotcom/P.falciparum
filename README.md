# P.falciparum
Reproducing data from a research paper
## Downloading raw data
$ wget ftp://ngs.sanger.ac.uk/production/pf3k/release_5/BAM/*.bam
## Creating index files 
# for reference

$gatk CreateSequenceDictionary -R Pfalciparum.genome.fasta
$samtools faidx Pfalciparum.genome.fasta

# for samples
$#indexing of bam files
for file in *bam;
    do
    samtools index -b $file
done

## HaplotypeCalling
#variant calling
 gatk --java-options "-Xmx4g" HaplotypeCaller  \
    -R Pfalciparum.genome.fasta \
    -I PA0007-C.bam \
    -O v7.g.vcf.gz \
    -ERC GVCF
##Combining vcf samples
#combining the variants
gatk CombineGVCFs \
    -R Pfalciparum.genome.fasta \
     --variant v7.g.vcf.gz \
     --variant v8.g.vcf.gz \
    -O combined.g.vcf.gz
##Genotyping
#genotyping variants
gatk --java-options "-Xmx96g -Xms96g" GenotypeGVCFs \
    -R Pfalciparum.genome.fasta \
    -V combined.g.vcf.gz   \
    -O genotyped.vcf.gz

##Hard filtering
#variant to table
gatk VariantsToTable -V genotyped.vcf -F QD -F FS -F SOR -F MQ -F DP -O QD.table
#visulisition of tables in R.
library(ggplot2)
QD.plot <- ggplot(data = QD, aes(x=QD)) + geom_density(alpha=0.2)
QD.plot
generating MQ  PLOT
MQ.plot <- ggplot(data = QD, aes(x=MQ)) + geom_density(alpha=0.2)
MQ.plot
SOR.plot <- ggplot(data = QD, aes(x=SOR)) + geom_density(alpha=0.2)
SOR.plot
DP.plot <- ggplot(data = QD, aes(x=DP)) + geom_density(alpha=0.2)
DP.plot + scale_x_log10()
#filtering
 gatk VariantFiltration \
   -R Pfalciparum.genome.fasta \
   -V genotyped.vcf.gz \
   -O filtered.vcf.gz\
   --filter-name "QD3"\
   --filter-expression "QD < 3.0" \
   --filter-name "DP10"\
   --filter-expression "DP < 10.0" \
   --filter-name "SOR5"\
   --filter-expression "SOR > 5.0" \
   --filter-name "MQ32"\
   --filter-expression "MQ < 32.0"\
   # selecting pass
 gatk SelectVariants \
     -R Pfalciparum.genome.fasta \
     -V filtered.vcf \
     --select 'vc.isNotFiltered()' \
     -O selected.vcf

# 1.selecting snps and indels
 #snps
gatk SelectVariants \
    -V genotyped.vcf.gz \
    -select-type SNP \
    -O snps.vcf.gz
  #indels
gatk SelectVariants \
    -V genotyped.vcf.gz \
    -select-type INDEL \
    -O indels.vcf.gz
 ##variants to table
 #snps
 gatk VariantsToTable -V snps.vcf.gz -F QD -F FS -F SOR -F MQ -F DP  -O SNPS.table
 #indels
 gatk VariantsToTable -V indels.vcf.gz -F QD -F FS -F SOR -F MQ -F DP  -O indels.table

##filtering

gatk VariantFiltration \
   -R Pfalciparum.genome.fasta \
   -V snps.vcf.gz\
   -O SNPfiltered.vcf.gz\
   --filter-name "QD3"\
   --filter-expression "QD < 3.0" \
   --filter-name "DP10"\
   --filter-expression "DP < 10.0" \
   --filter-name "SOR5"\
   --filter-expression "SOR > 5.0" \
   --filter-name "MQ32"\
   --filter-expression "MQ < 32.0"\
   --filter-name "FS1"\
   --filter-expression "FS < 1.0"\
   ## annotation
   
java -Xmx8g -jar snpEff.jar GRCh37.75 /opt/data/bole/variant/filtered.vcf > Pf.ann.vcf

# snps
java -Xmx8g -jar snpEff.jar GRCh37.75 /opt/data/bole/variant/SNPfiltered.vcf.gz  > snp.ann.vcf






