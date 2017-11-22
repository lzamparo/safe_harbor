How to interpret the safe harbor data:

The archive contains the following output directories:
- overlap_beds/p_included 
- overlap_beds/p_excluded

Each bedfile is named for one of the celltyes in the Corces et al data set, and
contains the overlaps of the accessible sites for that celltype with the safe
harbor regions (p_included/ directory for included, p_excluded/ for excluded)

Here's a sample of the output for the common myeloid progenitor celltype:

==> overlap_beds/p_included/CMP_p_included.bed <==
chr1    4100697    4192617    .    0    .    .    -1    -1    0
chr1    4194185    4235588    .    0    .    chr1    4233365    4233522    157
chr1    4235959    4422086    .    0    .    chr1    4388407    4388836    429
chr1    4235959    4422086    .    0    .    chr1    4404255    4404373    118
chr1    4522087    4562204    .    0    .    .    -1    -1    0
chr1    4852596    5058057    .    0    .    chr1    4897498    4898247    749
chr1    5080898    5100958    .    0    .    .    -1    -1    0
chr1    5200959    5324130    .    0    .    .    -1    -1    0
chr1    18153558    18328349    .    0    .    chr1    18208400    18208506    106
chr1    18335092    18335986    .    0    .    .    -1    -1    0

Here's how to interpret this output:

The first six fields indentfy a potential safe horbour site.  
e.g chr1    4194185    4235588    .    0    .

The last four fields specify how much the safe harbor site overlaps with an ATAC-seq peak
in that celltype (last field specifies by how much).  
e.g chr1    4233365    4233522    157


If no peaks overlap the safe harbour site, the site will appear with but with
the last four fields containing '. -1 -1 0', as in the first line of the example.

Otherwise, the site will appear once per number of peaks which overlap the site.
e.g the site 'chr1    4235959    4422086' overlaps with two peaks

chr1    4235959    4422086    .    0    .    chr1    4388407    4388836    429
chr1    4235959    4422086    .    0    .    chr1    4404255    4404373    118


Collected safe harbor counts:

The files 'overlap_beds/p_excluded/all_harbors_p_excluded_counts.bed' and 
'overlap_beds/p_included/all_harbors_p_included_counts.bed' are different, 
they contain each safe harbor site, and for each site a count of in how many
celltypes is that site accessible. 
e.g chr1    232747304    232785949    13

^^ this site shares some overlap with at least one ATAC-seq peak in all 13 cell types.
