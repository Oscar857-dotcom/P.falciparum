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
