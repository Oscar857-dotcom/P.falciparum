#variant calling 
gatk --java-options "-Xmx4g" HaplotypeCaller \
    -R Pfalciparum.genome.fasta \
    -I PA0008-C.bam \
    -O v8.g.vcf.gz \
    -ERC GVCF
