gatk SelectVariants \
    -V genotyped.vcf.gz \
    -select-type INDEL \
    -O indels.vcf.gz
