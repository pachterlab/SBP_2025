#!/bin/sh

# WSB/EiJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029233295.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029233295.1.zip" -H "Accept: application/zip"
# PWK/PhJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029233695.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029233695.1.zip" -H "Accept: application/zip"
# NZO/HILtJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029233705.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029233705.1.zip" -H "Accept: application/zip"
# NOD/ShiLtJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029234005.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029234005.1.zip" -H "Accept: application/zip"
# CAST/EiJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029237265.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029237265.1.zip" -H "Accept: application/zip"
# A/J
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029255665.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029255665.1.zip" -H "Accept: application/zip"
# 129S1/SvImJ
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_029255695.1/download?include_annotation_type=GENOME_FASTA,GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA,SEQUENCE_REPORT&filename=GCA_029255695.1.zip" -H "Accept: application/zip"

mkdir -p PRJNA923323/
unzip GCA_029233295.1.zip -d PRJNA923323/GCA_029233295/
unzip GCA_029233695.1.zip -d PRJNA923323/GCA_029233695/
unzip GCA_029233705.1.zip -d PRJNA923323/GCA_029233705/
unzip GCA_029234005.1.zip -d PRJNA923323/GCA_029234005/
unzip GCA_029237265.1.zip -d PRJNA923323/GCA_029237265/
unzip GCA_029255665.1.zip -d PRJNA923323/GCA_029255665/
unzip GCA_029255695.1.zip -d PRJNA923323/GCA_029255695/

mv PRJNA923323/GCA_029233295/ncbi_dataset/data/GCA_029233295.1/GCA_029233295.1_ASM2923329v1_genomic.fna PRJNA923323/Mus_musculus_wsbeij.fa
mv PRJNA923323/GCA_029233695/ncbi_dataset/data/GCA_029233695.1/GCA_029233695.1_ASM2923369v1_genomic.fna PRJNA923323/Mus_musculus_pwkphj.fa
mv PRJNA923323/GCA_029233705/ncbi_dataset/data/GCA_029233705.1/GCA_029233705.1_ASM2923370v1_genomic.fna PRJNA923323/Mus_musculus_nzohlltj.fa
mv PRJNA923323/GCA_029234005/ncbi_dataset/data/GCA_029234005.1/GCA_029234005.1_ASM2923400v1_genomic.fna PRJNA923323/Mus_musculus_nodshiltj.fa
mv PRJNA923323/GCA_029237265/ncbi_dataset/data/GCA_029237265.1/GCA_029237265.1_ASM2923726v1_genomic.fna PRJNA923323/Mus_musculus_casteij.fa
mv PRJNA923323/GCA_029255665/ncbi_dataset/data/GCA_029255665.1/GCA_029255665.1_ASM2925566v1_genomic.fna PRJNA923323/Mus_musculus_aj.fa
mv PRJNA923323/GCA_029255695/ncbi_dataset/data/GCA_029255695.1/GCA_029255695.1_ASM2925569v1_genomic.fna PRJNA923323/Mus_musculus_129s1svimj.fa
gzip PRJNA923323/*.fa
