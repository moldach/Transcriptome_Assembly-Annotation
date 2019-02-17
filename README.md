# Transcriptome Assembly and Functional Annotation Pipeline

### Background 
This repo contains a collection of scripts that were used for the _de novo_ assembly of _Acropora gemmifera_ transcriptome.

> Oldach, M.J. and Vize, P.D., 2018. De novo assembly and annotation of the Acropora gemmifera transcriptome. Marine Genomics, 40, pp.9-12. https://doi.org/10.1016/j.margen.2017.12.007 

### Contact information

Matthew J. Oldach 
E-mail: moldach686@gmail.com
[Twitter: @MattOldach](https://twitter.com/MattOldach)
[Website: https://moldach.github.io/](https://moldach.github.io/)

***
## Assembly

Use the `runall` script (adapted from Matt MacManes [Oyster River Protocol](https://github.com/macmanes-lab/Oyster_River_Protocol) which combines scripts for the optimization of (eukaryotic) transcriptome assembly, using a multi-kmer multi-assembler approach, then merges those assemblies into 1 final assembly.

## Annotation

### dammit. https://github.com/dib-lab/dammit

> dammit is a simple de novo transcriptome annotator. It was born out of the observation that: annotation is mundane and annoying; all the individual pieces of the process exist already; and, the existing solutions are overly complicated or rely on crappy non-free software

**cough** **cough** (meaning) `BLAST2GO`!

dammit runs a relatively standard annotation protocol for transcriptomes: it begins by building gene models with Transdecoder, and then uses the following protein databases as evidence for annotation: 

+ [Pfam-A](https://pfam.xfam.org/) a large collection of protein families, represented by multiple sequence alignments and hidden Markov models (HMMs)
+ [Rfam](http://rfam.xfam.org/) a collection of RNA families, each represented by multiple sequence 
+ [OrthoDB](https://www.orthodb.org/) a catalog of orthologous protein-coding genes across vertebrates, arthropods, fungi, plants, and bacteria.
+ [uniref90](https://www.uniprot.org/help/uniref) UniRef90 is built by clustering UniRef100 sequences with 11 or more residues using the CD-HIT algorithm

You will now have a number of files. Most importantly is the `<filename>.dammit.fasta` file which will be used in the next steps.

Feed your transcriptome from dammit! into:

1) WebMGA for KOG (http://weizhong-lab.ucsd.edu/webMGA/server/kog/)
2) KAAS for KEGG (http://www.genome.jp/tools/kaas/)
3) Sma3s for GO terms (http://www.bioinfocabd.upo.es/node/11#output)

Append the information for KOG, KEGG, and GO terms onto the fasta file produced by dammit for the assembled and annotated final product.

## Caveats of Transcriptome Assembly and Annotation

+ Impacted by the quality of the sequence
+ Iterative, never perfect, can always be improved with new evidence and improved algorthms

# Licence
This code is released under the [MIT License](https://lmullen.mit-license.org/). The code from runall script is from macmanes-lab/Oyster_River_Protocol which is used under the terms of its own [license](https://github.com/macmanes-lab/Oyster_River_Protocol).
