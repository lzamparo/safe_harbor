#!/bin/bash

set -o nounset -o pipefail -o errexit

N=50

### MEP && HSC && Ery overlap sites
peaks_base=/Users/zamparol/projects/SeqDemote/data/ATAC/corces_heme/peaks
harbor_base=`pwd`
bam_base=/Users/zamparol/projects/SeqDemote/data/ATAC/corces_heme/bam

mep_peaks=$peaks_base/MEP/MEP_normalized_summit_heights.bed
hsc_peaks=$peaks_base/HSC/HSC_normalized_summit_heights.bed
ery_peaks=$peaks_base/Ery/Ery_normalized_summit_heights.bed

### overlap those atlases
bedtools intersect -a $mep_peaks -b $hsc_peaks -wo -f 1.0 -F 1.0 > $harbor_base/MEP_HSC_overlap.bed
bedtools intersect -a $harbor_base/MEP_HSC_overlap.bed -b $ery_peaks -wo -f 1.0 -F 1.0 > $harbor_base/MEP_HSC_Ery_overlap.bed


### take the average size-factor corrected median peak height
cat $harbor_base/MEP_HSC_Ery_overlap.bed | awk '{printf($1"\t"$2"\t"$3"\t"($4+$8+$13)/3"\n")}' > $harbor_base/MEP_HSC_Ery_overlap_averaged_accessibility.bed
rm $harbor_base/MEP_HSC_Ery_overlap.bed
rm $harbor_base/MEP_HSC_overlap.bed

### overlap with safe harbour sites, dump intermediate  
bedtools intersect -b sf_p_included.bed -a $harbor_base/MEP_HSC_Ery_overlap_averaged_accessibility.bed -f 1.0 -wa > $harbor_base/overlap_beds/p_included/MEP_HSC_Ery_overlap.bed
bedtools intersect -b sf_p_excluded.bed -a $harbor_base/MEP_HSC_Ery_overlap_averaged_accessibility.bed -f 1.0 -wa > $harbor_base/overlap_beds/p_excluded/MEP_HSC_Ery_overlap.bed
rm $harbor_base/MEP_HSC_Ery_overlap_averaged_accessibility.bed

### sort and write out overlaps by bp, take the top N
cat $harbor_base/overlap_beds/p_excluded/MEP_HSC_Ery_overlap.bed | sort -k 4,4rn | head -n $N | sort -k1,1 -k2,2n > $harbor_base/overlap_beds/p_excluded/MEP_HSC_Ery_overlap_sorted.bed
cat $harbor_base/overlap_beds/p_included/MEP_HSC_Ery_overlap.bed | sort -k 4,4rn | head -n $N | sort -k1,1 -k2,2n > $harbor_base/overlap_beds/p_included/MEP_HSC_Ery_overlap_sorted.bed
rm $harbor_base/overlap_beds/p_included/MEP_HSC_Ery_overlap.bed
rm $harbor_base/overlap_beds/p_excluded/MEP_HSC_Ery_overlap.bed

### calculate normalized BW tracks, save to overlap_tracks
#for bam in $(find /Users/zamparol/projects/SeqDemote/data/ATAC/corces_heme/bam -name *.bam)
#do
#	repname=$(basename $bam | cut -d'_' -f 1)
#	outfile=$(echo $repname"_RPM_normalized.bw")
#	echo "turning $bam into $harbor_base/overlap_tracks/$outfile..."
#	bamCoverage -b $bam --normalizeUsingRPKM -p 8 -o $harbor_base/overlap_tracks/$outfile
#done
#echo "ready to be loaded into IGV"


