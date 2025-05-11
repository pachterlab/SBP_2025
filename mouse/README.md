## Mouse analysis

Download mouse genome assemblies:

<pre>./download_assemblies.sh</pre>

Obtain set combinations of distinguishing k-mers and count them for the raw assembly files


<pre>path="PRJNA923323"
klue distinguish -t 18 --pipe -k 31 --combinations $path/Mus_musculus_c57bl6j.fa.gz $path/Mus_musculus_casteij.fa.gz $path/Mus_musculus_aj.fa.gz $path/Mus_musculus_129s1svimj.fa.gz $path/Mus_musculus_nodshiltj.fa.gz $path/Mus_musculus_nzohlltj.fa.gz $path/Mus_musculus_pwkphj.fa.gz $path/Mus_musculus_wsbeij.fa.gz > out.fa
</pre>

<pre>python count_kmers.py out.fa 31 > out.counts.txt</pre>

For the demultiplexing of mouse strains:

<pre># Run klue
klue distinguish -t 18 --pipe -g distinguish.Mus_musculus.Mus_musculus_aj_Mus_musculus_pwkphj.t2g $path/Mus_musculus_aj.fa.gz $path/Mus_musculus_pwkphj.fa.gz > distinguish.Mus_musculus.Mus_musculus_aj_Mus_musculus_pwkphj.fa
# Index result with kallisto
kb ref --workflow=custom --distinguish -t 18 -i distinguish.Mus_musculus_aj_Mus_musculus_pwkphj.idx distinguish.Mus_musculus.Mus_musculus_aj_Mus_musculus_pwkphj.fa
# Run kallisto on dataset (FASTQ file paths should be supplied in batch.txt; a sample batch.txt is provided)
kb count --h5ad --overwrite -w r1r2r3.txt --verbose --workflow=standard -g distinguish.Mus_musculus.Mus_musculus_aj_Mus_musculus_pwkphj.t2g -x 1,10,18,1,48,56,1,78,86:1,0,10:0,0,0 -i distinguish.Mus_musculus_aj_Mus_musculus_pwkphj.idx -t 24 -o out_demultiplex_Mus_musculus_aj_Mus_musculus_pwkphj/ --batch-barcodes batch.txt</pre>

