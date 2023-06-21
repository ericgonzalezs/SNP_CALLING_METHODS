java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
       I=Sequel.RunS142_S2.002.ANN826-3.ccs_NGMLR_bq_RG.bam \
       O=Sequel.RunS142_S2.002.ANN826-3.ccs_NGMLR_bq_RG_FB.bam \
       RGID=5 \
       RGLB=lib1 \
       RGPL=HiFi \
       RGPU=unit1 \
       RGSM=ANN826
