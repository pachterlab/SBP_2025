#!/bin/bash


set -e

# First argument: output_prefix
prefix=$1

# Second argument: threads
threads=$2

# Third argument: target (i.e. transcriptome) FASTA file
target=$3

# Fourth: target t2g file
t2g=$4

# Fifth: technology

tech=$5
filter="--filter=bustools"
bulk=""
if [[ $tech == bulk* ]]; then
  filter=""
  bulk="--matrix-to-directories"
fi
if [[ $tech == smartseq2* ]]; then
  filter=""
  bulk="--matrix-to-directories"
fi

# Sixth: onlist (or None)

onlist=$6

# Seventh argument: 1,2,2,2
numbers=$7
num_count=$(( $(echo "$numbers" | awk -F',' '{print NF-2}') + 1 ))

# Eight argument: a.fa,b.fq,c.fq,d.fq
strings=$8

# Ninth argument: reads (e.g. 1.fq,2.fq,3.fq)
strings2=$9


# Convert comma-separated strings to space-separated strings
IFS=',' read -r -a string_array <<< "$strings"
IFS=',' read -r -a string_array2 <<< "$strings2"

echo "START"

# Run command to extract contigs present uniquely in only in the final file
if [ ! -f "${prefix}_klue_out/distinguish_1.output.fa" ]; then
  echo "BEGIN KLUE"
  mkdir -p ${prefix}_klue_out
  klue distinguish -o ${prefix}_klue_out/distinguish_1.fa -t $threads -M "$numbers" "${string_array[@]}"
  awk -v num="$num_count" '/^>/{p=($0==">"num)} p' ${prefix}_klue_out/distinguish_1.fa | awk '/^>/{print ">" i++; next} 1' > ${prefix}_klue_out/distinguish_1.output.fa_
  # Only keep things at least X bp (here, we'll just set it to 0 but can adjust)
  min_length=0
  awk -v min_len="$min_length" '/^>/ {if (seq && length(seq) >= min_len) {print header; print seq} header=$0; seq=""; next} {seq = seq $0} END {if (seq && length(seq) >= min_len) {print header; print seq}}' ${prefix}_klue_out/distinguish_1.output.fa_ > ${prefix}_klue_out/distinguish_1.output.fa
  echo "END KLUE"
fi

# Make the shades FASTA file from the pseudoassembly
if [ ! -f "${prefix}_klue_out/shades.fa" ]; then
  echo "BEGIN SHADES"
  mkdir -p ${prefix}_klue_out/kb_distinguish
  /usr/bin/time -v kb ref --tmp=${prefix}_klue_out/temporary/ --overwrite --workflow=custom --verbose -i ${prefix}_klue_out/kb_distinguish/distinguish_1.idx -t $threads -k 29 --distinguish ${prefix}_klue_out/distinguish_1.output.fa
  echo "SHADES: kallisto bus"
  kallisto bus -x BULK --union --num -i ${prefix}_klue_out/kb_distinguish/distinguish_1.idx -t $threads -o ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/ ${target}
  bustools sort -o ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/output.s.bus ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/output.bus
  bustools text -pf ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/output.s.bus > ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/output.s.txt
  cut -f1 $t2g > ${prefix}_klue_out/mouse.txnames.txt
  echo "SHADES: Making shades"
  /usr/bin/time -v python make_shades.py ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/matrix.ec ${prefix}_klue_out/kb_distinguish/txome_k29_mapping/output.s.txt ${prefix}_klue_out/distinguish_1.output.fa ${prefix}_klue_out/mouse.txnames.txt ${prefix}_klue_out/shades.fa
  echo "END SHADES"
fi


# Index the shades

if [ ! -f "${prefix}_klue_out/shades/distinguish_1.shaded.idx" ]; then
  echo "BEGIN INDEXING SHADES"
  mkdir -p ${prefix}_klue_out/shades
  /usr/bin/time -v kallisto index -t $threads -i ${prefix}_klue_out/shades/distinguish_1.shaded.idx ${target} ${prefix}_klue_out/shades.fa
  echo "END INDEXING SHADES"
fi

awk 'NR==FNR{a[$1]=$0; next} {print ($1 in a) ? a[$1] : $1}' <(cat $t2g) <(cat ${prefix}_klue_out/shades.fa|awk 'NR % 2 == 1 {print}'|cut -c2-|cut -d'_' -f1) > ${prefix}_klue_out/tmp.txt
awk 'NR==FNR{a[NR]=$1; next} {$1=a[FNR]; print}' OFS='\t' <(cat ${prefix}_klue_out/shades.fa|awk 'NR % 2 == 1 {print}'|cut -c2-) ${prefix}_klue_out/tmp.txt > ${prefix}_klue_out/tmp2.txt
cat $t2g ${prefix}_klue_out/tmp2.txt > ${prefix}_klue_out/index_t2g.with_distinguish.txt
mv ${prefix}_klue_out/tmp2.txt ${prefix}_klue_out/index_t2g.with_distinguish_shade_only.txt

# Pseudoalignment
if [ ! -f "${prefix}_klue_out/kb_out_gene/run_info.json" ]; then
  echo "BEGIN PSEUDOALIGNMENT GENE"
  rm -rf ${prefix}_klue_out/temp2/
  rm -rf ${prefix}_klue_out/kb_out_gene/
  kallisto index -t $threads -i ${prefix}_klue_out/standard.idx ${target}
  /usr/bin/time -v kb count --tmp=${prefix}_klue_out/temp2/ --strand=unstranded --overwrite -t $threads -i ${prefix}_klue_out/standard.idx -g ${t2g} \
  -x $tech -o ${prefix}_klue_out/kb_out_gene/ $filter \
  "${string_array2[@]}"
  echo "END PSEUDOALIGNMENT GENE"
fi
if [ ! -f "${prefix}_klue_out/kb_out/run_info.json" ]; then
  echo "BEGIN PSEUDOALIGNMENT TCC"
  rm -rf ${prefix}_klue_out/temp/
  rm -rf ${prefix}_klue_out/kb_out/
  /usr/bin/time -v kb count --tmp=${prefix}_klue_out/temp/ --strand=unstranded --overwrite -t $threads -i ${prefix}_klue_out/shades/distinguish_1.shaded.idx -g ${prefix}_klue_out/index_t2g.with_distinguish.txt \
  -x $tech -o ${prefix}_klue_out/kb_out/ --tcc $bulk \
  "${string_array2[@]}"
  echo "END PSEUDOALIGNMENT TCC"
fi
