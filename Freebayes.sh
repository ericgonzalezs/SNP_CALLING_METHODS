export PATH="/something/freebayes/bin:$PATH"
export PATH="/something/freebayes/scripts:$PATH"

freebayes-parallel  <(fasta_generate_regions.py file.fasta.fai 100000 ) 15 -f file.fasta -L bam.list --min-coverage 5 -m 10 -q 20 --genotype-qualities --use-best-n-alleles 3 > file.vcf #this line is to run freebayes, maybe just remove the --min-coverage 5 flag and use the default (0)
vcffilter -f "QUAL > 20" file.vcf > File_Q20.vcf #this line is to filter genotypes for a genotype quality above 20
vcffilter -f "TYPE = snp" File_Q20.vcf > File_Q20_SNPs.vcf #this line is to keep only snps
