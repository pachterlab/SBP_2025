# Code

## Download tools and genome references

<pre>wget https://github.com/10XGenomics/bamtofastq/releases/download/v1.4.1/bamtofastq_linux
chmod +x bamtofastq_linux
mv bamtofastq_linux bamtofastq
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/914/755/GCF_009914755.1_T2T-CHM13v2.0/GCF_009914755.1_T2T-CHM13v2.0_genomic.fna.gz
# Also get human_cdna.fa.gz from kb ref (252301 transcripts)
wget https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-108/gtf/homo_sapiens/Homo_sapiens.GRCh38.108.gtf.gz
kb ref -i human_index_standard.idx -g human_index_t2g.txt -f1 human_cdna.fa Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz Homo_sapiens.GRCh38.108.gtf.gz
kb ref -i human_index_standard.29.idx -g human_index_t2g.29.txt -f1 human_cdna.29.fa Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz Homo_sapiens.GRCh38.108.gtf.gz
gzip human_cdna.fa
cat GCF_009914755.1_T2T-CHM13v2.0_genomic.fna.gz human_cdna.fa.gz > human_final.fa.gz
# Mouse:
wget https://ftp.ensembl.org/pub/release-108/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-108/gtf/mus_musculus/Mus_musculus.GRCm39.108.gtf.gz
kb ref -i mouse_index_standard.idx -g mouse_index_t2g.txt -f1 mouse_cdna.fa Mus_musculus.GRCm39.dna.primary_assembly.fa.gz Mus_musculus.GRCm39.108.gtf.gz
gzip mouse_cdna.fa
cat Mus_musculus.GRCm39.dna.primary_assembly.fa.gz mouse_cdna.fa.gz > mouse_final.fa.gz
kb ref -k 29 -i mouse_index_standard.29.idx -g mouse_index_t2g.29.txt -f1 mouse_cdna.29.fa Mus_musculus.GRCm39.dna.primary_assembly.fa.gz Mus_musculus.GRCm39.108.gtf.gz
kb ref --workflow=nac -i mouse_index_nac.idx -g mouse_index_nac_t2g.txt -c1 mouse_nac.c1 -c2 mouse_nac.c2 -f1 mouse_nac_1.fa -f2 mouse_nac_2.fa Mus_musculus.GRCm39.dna.primary_assembly.fa.gz Mus_musculus.GRCm39.108.gtf.gz
kb ref --workflow=nac -k 29 -i mouse_index_nac.29.idx -g mouse_index_nac_t2g.29.txt -c1 mouse_nac.29.c1 -c2 mouse_nac.29.c2 -f1 mouse_nac_1.29.fa -f2 mouse_nac_2.29.fa Mus_musculus.GRCm39.dna.primary_assembly.fa.gz Mus_musculus.GRCm39.108.gtf.gz
</pre>

SRA toolkit

<pre>
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.2.0/sratoolkit.3.2.0-centos_linux64.tar.gz
tar -xzvf sratoolkit.3.2.0-centos_linux64.tar.gz
mv sratoolkit.3.2.0-centos_linux64 sratoolkit
</pre>

## Download datasets

The following (RFP: mouse McSC-derived melanoma; Ctrl: McSC) is bulk RNA-seq from https://www.nature.com/articles/s41467-019-12733-1

<pre>curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/000/SRR5368670/SRR5368670.fastq.gz -o SRR5368670_GSM2546910_Ctrl_T7d.3_Mus_musculus_RNA-Seq.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/009/SRR5368669/SRR5368669.fastq.gz -o SRR5368669_GSM2546909_Ctrl_T7d.2_Mus_musculus_RNA-Seq.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/001/SRR5368671/SRR5368671_1.fastq.gz -o SRR5368671_GSM2546911_RFP_1_Mus_musculus_RNA-Seq_1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/001/SRR5368671/SRR5368671_2.fastq.gz -o SRR5368671_GSM2546911_RFP_1_Mus_musculus_RNA-Seq_2.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/002/SRR5368672/SRR5368672_1.fastq.gz -o SRR5368672_GSM2546912_RFP_2_Mus_musculus_RNA-Seq_1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/002/SRR5368672/SRR5368672_2.fastq.gz -o SRR5368672_GSM2546912_RFP_2_Mus_musculus_RNA-Seq_2.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR536/008/SRR5368668/SRR5368668.fastq.gz -o SRR5368668_GSM2546908_Ctrl_T7d.1_Mus_musculus_RNA-Seq.fastq.gz
</pre>

The following is 10xv2 single-cell RNA-seq of McSC-derived melanoma and McSC from https://www.nature.com/articles/s41467-019-12733-1

<pre>
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR705/002/SRR7054532/SRR7054532.fastq.gz -o SRR7054532_GSM3108125_McSC_TyrTom_Mus_musculus_RNA-Seq.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR705/003/SRR7054533/SRR7054533.fastq.gz -o SRR7054533_GSM3108126_Melanoma_Tbpt_Mus_musculus_RNA-Seq.fastq.gz
wget https://sra-pub-src-2.s3.amazonaws.com/SRR7054533/Melanoma_Tbpt_possorted_genome_bam.bam.1
./bamtofastq Melanoma_Tbpt_possorted_genome_bam.bam.1 Melanoma_Tbpt/
wget https://sra-pub-src-2.s3.amazonaws.com/SRR7054532/McSC_TyrTom_possorted_genome_bam.bam.1
./bamtofastq McSC_TyrTom_possorted_genome_bam.bam.1 McSC_Tbpt/
</pre>

## Run analysis code

<pre>./prep.sh mcsc_melanoma 18 mouse_cdna.fa.gz mouse_index_t2g.txt 10xv2 None 1,2,2,2 mouse_final.fa.gz,SRR5368668_GSM2546908_Ctrl_T7d.1_Mus_musculus_RNA-Seq.fastq.gz,SRR7054532_GSM3108125_McSC_TyrTom_Mus_musculus_RNA-Seq.fastq.gz,SRR7054533_GSM3108126_Melanoma_Tbpt_Mus_musculus_RNA-Seq.fastq.gz Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R1_001.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R2_001.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R1_002.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R2_002.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R1_003.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R2_003.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R1_004.fastq.gz,Melanoma_Tbpt/count-Tbpt_MissingLibrary_1_HMN5YBBXX/bamtofastq_S1_L002_R2_004.fastq.gz</pre>

