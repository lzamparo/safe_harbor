#!/bin/bash

### Safe harbor site calculations; find SH sites which overlap with 
### some ATAC-seq peak in each of the celltypes

harbor_base=/Users/zamparol/projects/SeqDemote/data/safe_harbor
peaks_base=/Users/zamparol/projects/SeqDemote/data/ATAC/corces_heme/peaks

outfile=sites_p_included.bed
outdir=$harbor_base/overlap_beds/p_included

# count and write out
bedtools intersect -filenames -a sf_p_included.bed -b $(find $peaks_base -name "*reproducible_peaks.bed") -wa -wb | cut -d$'\t' -f1-3,7 | bedtools groupby -g 1,2,3 -c 4 -o count_distinct | sort -k4,4nr > $outdir/$outfile

# sort by counts

# make output file name for comparison with sf_p_excluded.bed
outfile=sites_p_excluded.bed
outdir=$harbor_base/overlap_beds/p_excluded

# count and write out
bedtools intersect -filenames -a sf_p_excluded.bed -b $(find $peaks_base -name "*reproducible_peaks.bed") -wa -wb | cut -d$'\t' -f1-3,7 | bedtools groupby -g 1,2,3 -c 4 -o count_distinct | sort -k4,4nr > $outdir/$outfile


