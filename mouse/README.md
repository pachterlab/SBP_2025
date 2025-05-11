## Mouse analysis

To extract k-mers shared/unique across assemblies do:

<pre>name="default"
path="shared_kmers"
klue distinguish -t 18 --pipe -k 31 --combinations $path/${name}_Mus_musculus_c57bl6j.fa $path/${name}_Mus_musculus_casteij.fa $path/${name}_Mus_musculus_aj.fa $path/${name}_Mus_musculus_129s1svimj.fa $path/${name}_Mus_musculus_nodshiltj.fa $path/${name}_Mus_musculus_nzohlltj.fa $path/${name}_Mus_musculus_pwkphj.fa $path/${name}_Mus_musculus_wsbeij.fa > out_${name}.fa
</pre>
