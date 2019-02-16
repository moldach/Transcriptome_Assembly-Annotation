# Transcriptome Assembly and Annotation

## Background 
This repo contains a collection of scripts that were used for the _de novo_ assembly of _Acropora gemmifera_ (Oldach & Vize 2018, Marine Genomics) https://doi.org/10.1016/j.margen.2017.12.007 

## Transcriptome Assembly

Use the `runall` script (adapted from Matt MacManes Oyster River Protocol)

## Transcriptome Annotation

Gene symbol annotation using dammit. https://github.com/dib-lab/dammit
dammit runs a relatively standard annotation protocol for transcriptomes: it begins by building gene models with Transdecoder, and then uses the following protein databases as evidence for annotation: Pfam-A, Rfam, OrthoDB, uniref90.

Feed your transcriptome from dammit! into:
1) WebMGA for KOG (http://weizhong-lab.ucsd.edu/metagenomic-analysis/server/kog/)
2) KAAS for KEGG (http://www.genome.jp/tools/kaas/)
3) Sma3s for GO terms (http://www.bioinfocabd.upo.es/node/11#output)

Append the information for KOG, KEGG, and GO terms onto the fasta file produced by dammit for finished product.

# Licence
This code is released under the [MIT License](https://lmullen.mit-license.org/). The code from runall script is from macmanes-lab/Oyster_River_Protocol which is used under the terms of its own [license](https://github.com/macmanes-lab/Oyster_River_Protocol).
