 gatk SelectVariants \
     -R Pfalciparum.genome.fasta \
     -V filtered.vcf \
     --select 'vc.isNotFiltered()' \
     -O selected.vcf
