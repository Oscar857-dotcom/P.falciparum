gatk SelectVariants \
     -R Pfalciparum.genome.fasta \
     -V /opt/data/bole/variant/snpEff/Pf.ann.vcf \
     --select 'vc.isNotFiltered()' \
     -O anotateselected.vcf

