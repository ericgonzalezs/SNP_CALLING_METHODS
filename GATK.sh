#Haplotype caller

#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-17
module load nixpkgs/16.09 gatk/4.0.8.1

Number_ch=`printf %02d $SLURM_ARRAY_TASK_ID`

gatk --java-options "-Xmx8G" HaplotypeCaller -R Ha412HOv2.0-20181130.fasta -I Ha412HOv2.ANN1372-3_aligned_default_s_MQ60.bam -O Ha412HOv2.ANN1372-4_Ha412HOChr$Number_ch.vcf.gz  -G StandardAn
notation -G AS_StandardAnnotation -G StandardHCAnnotation --pcr-indel-model AGGRESSIVE -ERC GVCF --read-filter MappingQualityReadFilter --read-filter NotSecondaryAlignmentReadFilter --read-f
ilter NotSupplementaryAlignmentReadFilter -L Ha412HOChr$Number_ch

#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-17
module load nixpkgs/16.09 gatk/4.0.8.1

Number_ch=`printf %02d $SLURM_ARRAY_TASK_ID`

gatk --java-options "-Xmx8G" HaplotypeCaller -R Ha412HOv2.0-20181130.fasta -I Ha412HOv2.ANN826-3_aligned_MQ60.bam -O Ha412HOv2.ANN826-3_Ha412HOChr$Number_ch.vcf.gz  -G StandardAnnotation -G
AS_StandardAnnotation -G StandardHCAnnotation --pcr-indel-model AGGRESSIVE -ERC GVCF --read-filter MappingQualityReadFilter --read-filter NotSecondaryAlignmentReadFilter --read-filter NotSup
plementaryAlignmentReadFilter -L Ha412HOChr$Number_ch


########################################
##CombineGVCFs

#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-17
module load nixpkgs/16.09 gatk/4.0.8.1

Number_ch=`printf %02d $SLURM_ARRAY_TASK_ID`

gatk --java-options "-Xmx8G" CombineGVCFs  -R Ha412HOv2.0-20181130.fasta -V Ha412HOv2.ANN1372-4_Ha412HOChr$Number_ch.vcf.gz -V  Ha412HOv2.ANN826-3_Ha412HOChr$Number_ch.vcf.gz -O cohort.ANN13
72-3_ANN826-3_CHR$Number_ch.g.vcf.gz --annotation-group StandardAnnotation --annotation-group StandardAnnotation --annotation-group StandardHCAnnotation

##############################################
#GenotypeGVCFs
#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
module load nixpkgs/16.09 gatk/4.0.8.1

gatk --java-options "-Xmx8G" GenotypeGVCFs -R Ha412HOv2.0-20181130.fasta -V cohort.ANN1372-3_ANN826-3_scaffolds.g.vcf.gz -O ANN1372-3_ANN826-3_scaffolds.vcf.gz --annotation-group StandardAnn
otation --annotation-group StandardAnnotation --annotation-group StandardHCAnnotation --standard-min-confidence-threshold-for-calling 2.0

#############################################
#Merge

#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

module load nixpkgs/16.09 gatk/4.0.8.1


gatk --java-options "-Xmx8G" MergeVcfs \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR01.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR02.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR03.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR04.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR05.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR06.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR07.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR08.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR09.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR10.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR11.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR12.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR13.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR14.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR15.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR16.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR17.vcf.gz \
     --INPUT ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_scaffolds.vcf.gz \
     -O ANN1372-3_ANN826-3_Biallelic_SNPs_QD2_CHR_scaffolds_all.vcf.gz

##########################################################################
#Filter

#!/bin/bash
#SBATCH --account=rpp-rieseber
#SBATCH --time=2-10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
module load nixpkgs/16.09 gatk/4.0.8.1

gatk --java-options "-Xmx8G" SelectVariants  -R Ha412HOv2.0-20181130.fasta -V ANN1372-3_ANN826-3_scaffolds.vcf.gz --select-type-to-include SNP --restrict-alleles-to BIALLELIC -O ANN1372-3_AN
N826-3_Biallelic_SNPs_scaffolds.gz

gatk --java-options "-Xmx8G" VariantFiltration -R Ha412HOv2.0-20181130.fasta -V ANN1372-3_ANN826-3_Biallelic_SNPs_scaffolds.gz --filter-name "QDlt2" --filter-expression "QD < 2.0" -O ANN1372
-3_ANN826-3_Biallelic_SNPs_QD2_scaffolds.gz


#######################################################################
#





