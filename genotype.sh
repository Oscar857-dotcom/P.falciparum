#genotyping variants
gatk --java-options "-Xmx96g -Xms96g" GenotypeGVCFs \
    -R Pfalciparum.genome.fasta \
    -V combined.g.vcf.gz   \
    -O genotyped.vcf.gz
