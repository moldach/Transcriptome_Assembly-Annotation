# Transcriptome Assembly and Annotation Pipeline

### Publication
***
This repo contains a collection of scripts that were used for the _de novo_ assembly of _Acropora gemmifera_ transcriptome.

> Oldach, M.J. and Vize, P.D., 2018. De novo assembly and annotation of the Acropora gemmifera transcriptome. Marine Genomics, 40, pp.9-12. https://doi.org/10.1016/j.margen.2017.12.007 

Please cite the manuscript if you use it.

### Contact information
***
Matthew J. Oldach 

+ E-mail: moldach686@gmail.com
+ Twitter: [@MattOldach](https://twitter.com/MattOldach)
+ Website: [https://moldach.github.io/](https://moldach.github.io/)

## Assembly
***
Use the `runall` script adapted from [Matt MacManes](https://twitter.com/macmanes)'s [Oyster River Protocol](https://github.com/macmanes-lab/Oyster_River_Protocol) which combines scripts for the optimization of (eukaryotic) transcriptome assembly, using a multi-kmer multi-assembler approach, then merges those assemblies into 1 final assembly.

*Note: ammendements to the Oyster River Protocol may have happened since this pipeline was created/run. If your intent is reproducing the results of the paper then use the `runall` script as is. If you are using this repo for your own _de novo_ eukaryotic assembly it is prudent to check the official repo and make any necessary changes to the `runall` script.*

## Annotation
***
+ gene names
+ KOG
+ KAAS
+ GO terms

> [dammit](https://github.com/dib-lab/dammit) is a simple de novo transcriptome annotator built by [Camille Scott](https://twitter.com/camille_codon). It was born out of the observation that: annotation is mundane and annoying; all the individual pieces of the process exist already; and, the existing solutions are overly complicated or rely on crappy non-free software

**cough** **cough** (meaning) `BLAST2GO`!

dammit runs a relatively standard annotation protocol for transcriptomes: it begins by building gene models with [Transdecoder](http://transdecoder.github.io/), and then uses the following protein databases as evidence for annotation: 

+ [Pfam-A](https://pfam.xfam.org/) a large collection of protein families, represented by multiple sequence alignments and hidden Markov models (HMMs)
+ [Rfam](http://rfam.xfam.org/) a collection of RNA families, each represented by multiple sequence 
+ [OrthoDB](https://www.orthodb.org/) a catalog of orthologous protein-coding genes across vertebrates, arthropods, fungi, plants, and bacteria.
+ [uniref90](https://www.uniprot.org/help/uniref) UniRef90 is built by clustering UniRef100 sequences with 11 or more residues using the CD-HIT algorithm

Follow along with the docs for `dammit` for this step: https://angus.readthedocs.io/en/2018/dammit_annotation.html or [the workshop](https://angus.readthedocs.io/en/2017/dammit_annotation.html#annotation)

You will now have a number of files. Most importantly is the `<filename>.dammit.fasta` file which will be used in the next steps:

Feed your transcriptome from `dammit!` into:

1) WebMGA for KOG (http://weizhong-lab.ucsd.edu/webMGA/server/kog/)
2) KAAS for KEGG (http://www.genome.jp/tools/kaas/)
3) Sma3s for GO terms (http://www.bioinfocabd.upo.es/node/11#output)

Append the information for KOG, KEGG, and GO terms onto the fasta file produced by dammit for the assembled and annotated final product.

## Caveats of Transcriptome Assembly and Annotation
***
+ Impacted by the quality of the sequence
+ Iterative, never perfect, can always be improved with new evidence and improved algorthms

# Licence
***
This code is released under the [MIT License](https://lmullen.mit-license.org/). The code from runall script is from macmanes-lab/Oyster_River_Protocol which is used under the terms of its own [license](https://github.com/macmanes-lab/Oyster_River_Protocol).
