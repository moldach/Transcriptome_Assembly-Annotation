# Transcriptome_Assembly-Annotation

This is a collection of scripts that were used for de novo assembly of Acropora gemmifera (adapted from Matt MacManes Oyster River Protocol), as well as functional annotation and pathway analysis.

Use the script runall to do the assembly and gene symbol annotation using dammit!

Feed your transcriptome from dammit! into:
1) WebMGA for KOG (http://weizhong-lab.ucsd.edu/metagenomic-analysis/server/kog/)
2) KAAS for KEGG (http://www.genome.jp/tools/kaas/)
3) Sma3s for GO terms (http://www.bioinfocabd.upo.es/node/11#output)

Append the information for KOG, KEGG, and GO terms onto the fasta file produced by dammit!
