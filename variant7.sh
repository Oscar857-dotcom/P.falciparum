#variant calling
 gatk --java-options "-Xmx4g" HaplotypeCaller  \
    -R Pfalciparum.genome.fasta \
    -I PA0007-C.bam \
    -O v7.g.vcf.gz \
    -ERC GVCF

