library(data.table)
library(ggplot2)

setwd("~/projects/safe_harbor")
ery_peaks = data.table(fread("~/projects/SeqDemote/data/ATAC/corces_heme/peaks/Ery/Ery_normalized_summit_heights.bed", sep="\t", header=FALSE))
colnames(ery_peaks) = c("chrom", "start", "end", "normalized_peak_height")

ery_summits = ggplot(ery_peaks, aes(x=normalized_peak_height)) + geom_histogram(binwidth=0.25) + ggtitle("Density plot of library size factor normalized peak heights") + 
  geom_vline(xintercept=1.5728, colour="red", lty="dashed", size=0.5) + 
  geom_vline(xintercept=1.4911, colour="red", lty="dashed", size=0.5) + 
  geom_vline(xintercept=8.1437, colour="red", lty="dashed", size=0.5) 
  geom_text(x = 8.2, y = 2000, label = "chr7:149321212-149322403") 
  #geom_text(x = 1.6, y = 2000, label = "chr3:115502747-115503708") +
  #geom_text(x = 1.6, y = 1900, label = "chr13:45491718-45492970")