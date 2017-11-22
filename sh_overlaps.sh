#!/bin/bash

### Safe harbor site calculations

harbor_base=/Users/zamparol/projects/SeqDemote/data/safe_harbor
peaks_base=/Users/zamparol/projects/SeqDemote/data/ATAC/corces_heme/peaks

for peaks in $(find $peaks_base -name "*reproducible_peaks.bed")
do
	# make output file name for comparison with sf_p_included.bed
	celltype=$(basename $(echo $peaks) | cut -d'_' -f1)
	outfile="$celltype"_p_included.bed
	outdir=$harbor_base/overlap_beds/p_included

	# do intersect, write out
	bedtools intersect -a sf_p_included.bed -b $peaks -wao > $outdir/$outfile

	# make output file name for comparison with sf_p_excluded.bed
	outfile="$celltype"_p_excluded.bed
	outdir=$harbor_base/overlap_beds/p_excluded

	# do intersect, write out
	bedtools intersect -a sf_p_excluded.bed -b $peaks -wao > $outdir/$outfile
done