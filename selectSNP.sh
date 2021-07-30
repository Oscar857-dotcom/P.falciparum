gatk SelectVariants \
    -V genotyped.vcf.gz \
    -select-type SNP \
    -O snps.vcf.gz
