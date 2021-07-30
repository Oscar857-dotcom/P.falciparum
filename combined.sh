#combining the variants
gatk CombineGVCFs \
    -R Pfalciparum.genome.fasta \
     --variant v7.g.vcf.gz \
     --variant v8.g.vcf.gz \
    -O combined.g.vcf.gz
