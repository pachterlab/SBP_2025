## Mouse analysis

Download mouse genome assemblies:

<pre>./download_assemblies.sh</pre>

Obtain set combinations of distinguishing k-mers and count them for the raw assembly files


<pre>path="PRJNA923323"
klue distinguish -t 18 --pipe -k 31 --combinations $path/Mus_musculus_c57bl6j.fa.gz $path/Mus_musculus_casteij.fa.gz $path/Mus_musculus_aj.fa.gz $path/Mus_musculus_129s1svimj.fa.gz $path/Mus_musculus_nodshiltj.fa.gz $path/Mus_musculus_nzohlltj.fa.gz $path/Mus_musculus_pwkphj.fa.gz $path/Mus_musculus_wsbeij.fa.gz > out.fa
</pre>

<pre>python count_kmers.py out.fa 31 > out.counts.txt</pre>
