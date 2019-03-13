# This is a script used for functional annotation (KOG) of transcriptome (FASTA) file.
# After inputing your FASTA to WebMGA (http://weizhong-lab.ucsd.edu/metagenomic-analysis/server/kog/) you will append information from output.2 onto your transcriptome
# Create a script called KOG.py with below code and run like 'python3 KOG.py output.2 Agemmifera.fasta > Agemmifera.annot.fasta'
######################################################################################################################################

#! /usr/bin/python

from Bio import SeqIO
import sys
from collections import defaultdict

try:
  kog_fh = open(sys.argv[1])
except IndexError:
  sys.stderr.write('Usage: name_of_script kog_file fasta_file\n')
  sys.exit(0)

fasta_f = SeqIO.parse(sys.argv[2], 'fasta') # won't crash if file doesn't exist, not nice

kogs_dict = defaultdict(list)# key: gene name, value: kog result

for line in kog_fh:
  linelist = line.rstrip().split('\t')
  gene_name = linelist[0] # ASSUMPTION: gene is in first column
  kog_result = linelist[10] # counts from zero so column 11 has index 10
  kogs_dict[gene_name].append(kog_result) # we can have several kogs per gene

for s in fasta_f:
  # we want to add the KOG information to the sequence's description, which is everything after the space in the > header
  # this assumes that the gene's ID (everything before the space) is in the kogs output, not the entire name
  kog = kogs_dict[s.id] # with a defaultdict, the default entry is an empty list
  if not kog: # empty lists are 'falsy'
      kog = 'NA'
  else:
      kog = ';'.join(kog)
  s.description = '%s KOG=%s'%(s.description, kog)
  print(s.format('fasta'), end='') # python 3
  # if python2: print(s.format('fasta')), with a comma at the end, else you'll get an extra linebreak

# Credit goes to Philipp Bayer
