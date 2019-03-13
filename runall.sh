# How to set up an Amazon Web Service (AWS) Elastic Compute Cloud (EC2) machine for assembly
# Requirements: RAM = 0.5 * million read pairs (i.e. - 40 million PE reads using Trinity requires minimum of 20Gb of RAM

#####################################################################################################################################
# Setting up the directory structure for the project (store all of the files relevant to one project under a common root directory)
# Make common root directory for project
mkdir Agemmifera
cd Agemmifera
# Create a data directory for storing fixed data sets
mkdir data
# Create a results directory for tracking computational experiments performed on that data
mkdir results
# Create a document directory with one subdirectory per manuscript
mkdir doc
# Create a src for source code
mkdir src
# Create a bin for complied binaries and scripts
mkdir bin
#####################################################################################################################################


#####################################################################################################################################
# Updating software and installing dependencies via apt-get

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get -y install cmake sparsehash valgrind libboost-atomic1.55-dev libibnetdisc-dev ruby-full gsl-bin \
      libgsl0-dev libgsl0ldbl libboost1.55-all-dev libboost1.55-dbg subversion tmux git curl bowtie \
      libncurses5-dev samtools gcc make g++ python-dev unzip dh-autoreconf default-jre python-pip zlib1g-dev \
      hmmer libhdf5-dev r-base pkg-config libpng12-dev libfreetype6-dev python-sklearn build-essential \
      libsm6 libxrender1 libfontconfig1 liburi-escape-xs-perl emboss liburi-perl infernal python-numpy geomview
      
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
PATH="/home/ubuntu/.linuxbrew/bin:$PATH"
brew install parallel
	  
# Install SolexaQA    
curl -LO https://sourceforge.net/projects/solexaqa/files/src/SolexaQA%2B%2B_v3.1.7.1.zip
unzip SolexaQA%2B%2B_v3.1.7.1.zip
cd Linux_x64
PATH=$PATH:$(pwd)

# Install Transdecoder
cd
curl -LO https://github.com/TransDecoder/TransDecoder/archive/v3.0.1.tar.gz
tar -xvzf v3.0.1.tar.gz
cd TransDecoder-3.0.1
make -j6
export PATH=$PATH:$HOME/TransDecoder-3.0.1

# Install LAST
cd
curl -LO http://last.cbrc.jp/last-852.zip
unzip last-852.zip
cd last-852
make
export PATH=$PATH:$HOME/last-852/src

# Install dammit!
cd
sudo gem install crb-blast
sudo pip install -U setuptools
sudo pip install numpy --upgrade
sudo pip install matplotlib --upgrade
sudo pip install dammit

# Install Perl Module
sudo cpan URI::Escape

# Install seqtk
cd $HOME
git clone https://github.com/lh3/seqtk.git
cd seqtk
make -j4
PATH=$PATH:$(pwd)

# Install BWA
cd $HOME
git clone https://github.com/lh3/bwa.git
cd bwa
make -j4
PATH=$PATH:$(pwd)

# Install khmer
cd
sudo easy_install -U setuptools
sudo pip install khmer

# Install Kallisto
cd
git clone https://github.com/pachterlab/kallisto.git
cd kallisto
mkdir build
cd build
cmake ..
make
sudo make install

# Install Salmon
cd
curl -LO https://github.com/COMBINE-lab/salmon/archive/v0.8.2.tar.gz
tar -zxf v0.8.2.tar.gz
cd salmon-0.8.2/
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=$(which gcc-4.9) -DCMAKE_CXX_COMPILER=$(which g++-4.9) ..
make -j6
sudo make all install
export LD_LIBRARY_PATH=/home/ubuntu/salmon-0.8.2/lib

# Install Transrate
cd
curl -LO https://bintray.com/artifact/download/blahah/generic/transrate-1.0.3-linux-x86_64.tar.gz
tar -zxf transrate-1.0.3-linux-x86_64.tar.gz
PATH=$PATH:/home/ubuntu/transrate-1.0.3-linux-x86_64

# Install BUSCO and the metazoan database (alternatively you could compare to another other databases, like eukaryota etc. - see BUSCO website)
cd
git clone https://gitlab.com/ezlab/busco.git
cd busco
sudo python3 setup.py install
PATH=$PATH:$(pwd)
cd
wget http://busco.ezlab.org/datasets/metazoa_odb9.tar.gz
tar -xf metazoa_odb9.tar.gz

# Install BLAST
cd
curl -LO ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.6.0+-x64-linux.tar.gz
tar -zxf ncbi-blast-2.6.0+-x64-linux.tar.gz
PATH=$PATH:/home/ubuntu/ncbi-blast-2.6.0+/bin

# Install Trinity
cd
git clone https://github.com/trinityrnaseq/trinityrnaseq.git
cd trinityrnaseq
make -j6
PATH=$PATH:$(pwd)

# Install bfc
cd $HOME
git clone https://github.com/lh3/bfc.git
cd bfc
make
PATH=$PATH:$(pwd)

# Install RCorrector
cd
git clone https://github.com/mourisl/Rcorrector.git
cd Rcorrector
make
PATH=$PATH:$(pwd)

# Add all of these things to the permanent path
cd
echo PATH=$PATH >> ~/.profile
echo export LD_LIBRARY_PATH=/home/ubuntu/salmon-0.8.2/lib >> ~/.profile
source ~/.profile

# Remove all of the install files (they are no longer required)
rm v3.0.1.tar.gz SolexaQA%2B%2B_v3.1.7.1.zip last-852.zip transrate-1.0.3-linux-x86_64.tar.gz ncbi-blast-2.6.0+-x64-linux.tar.gz v0.8.2.tar.gz

#####################################################################################################################################
# Transcriptome assembly and annotation 

# Initial Quality Check
SolexaQA++ analysis H1D1Q_1.fq H1D1Q_2.fq
SolexaQA++ analysis H1NNM_1.fq H1NNM_2.fq
# Plot Results using R
R # This opens R on your AWS EC2 machine
qual1 <- read.delim("H1D1Q_1.fq.quality")
qual2 <- read.delim("H1D1Q_2.fq.quality")
jpeg('qualplot.jpg')
par(mfrow=c(2,1))
boxplot(t(qual1), col='light blue', ylim=c(0,.4), frame.plot=F, outline=F, xaxt = "n", ylab='Probability of nucleotide error', xlab='Nucleotide Position', main='Read1')
axis(1, at=c(0,10,20,30,40,50,60,70,80,90,100), labels=c(0,10,20,30,40,50,60,70,80,90,100))
boxplot(t(qual2), col='light blue', ylim=c(0,.4), frame.plot=F, outline=F, xaxt = "n", ylab='Probability of nucleotide error', xlab='Nucleotide Position', main='Read2')
axis(1, at=c(0,10,20,30,40,50,60,70,80,90,100), labels=c(0,10,20,30,40,50,60,70,80,90,100))
dev.off()
quit()
n

qual3 <- read.delim("H1NNM_1.fq.quality")
qual4 <- read.delim("H1NNM_2.fq.quality")
jpeg('qualplot.jpg')
par(mfrow=c(2,1))
boxplot(t(qual3), col='light blue', ylim=c(0,.4), frame.plot=F, outline=F, xaxt = "n", ylab='Probability of nucleotide error', xlab='Nucleotide Position', main='Read1')
axis(1, at=c(0,10,20,30,40,50,60,70,80,90,100), labels=c(0,10,20,30,40,50,60,70,80,90,100))
boxplot(t(qual4), col='light blue', ylim=c(0,.4), frame.plot=F, outline=F, xaxt = "n", ylab='Probability of nucleotide error', xlab='Nucleotide Position', main='Read2')
axis(1, at=c(0,10,20,30,40,50,60,70,80,90,100), labels=c(0,10,20,30,40,50,60,70,80,90,100))
dev.off()
quit()
n

# Error correcting reads (I have less than 20 million paired-end reads so I'm using BFC correction)
seqtk mergepe H1D1Q_1.fq H1D1Q_2.fq > H1D1Q_inter.fq
bfc -s 50m -k31 -t 16 H1D1Q_inter.fq > H1D1Q.bfc.corr.fq
split-paired-reads.py H1D1Q.bfc.corr.fq
mv H1D1Q.bfc.corr.fq.1 H1D1Q.bfc.corr.1.fq
mv H1D1Q.bfc.corr.fq.2 H1D1Q.bfc.corr.2.fq

seqtk mergepe H1NNM_1.fq H1NNM_2.fq > H1NNM_inter.fq
bfc -s 50m -k31 -t 16 H1NNM_inter.fq > H1NNM.bfc.corr.fq
split-paired-reads.py H1NNM.bfc.corr.fq
mv H1NNM.bfc.corr.fq.1 H1NNM.bfc.corr.1.fq
mv H1NNM.bfc.corr.fq.2 H1NNM.bfc.corr.2.fq


# Merging two Paired-end librarires
cat H1D1Q.bfc.corr.1.fq H1NNM.bfc.corr.1.fq > left.fq
cat H1D1Q.bfc.corr.2.fq H1NNM.bfc.corr.2.fq > right.fq

# De novo assembly with non-strand specific data (if you have stranded data you need to include the `--SS_lib_type RF` tag
# You may want to adjust the --CPU and --max_memory settings top optimize performance
############################## Run Trinity in the background #########
screen
Trinity --seqType fq --max_memory 20G --trimmomatic --CPU 20 --full_cleanup --output trinity-assembly --left left.fq --right right.fq --bypass_java_version_check --quality_trimming_params "ILLUMINACLIP:/home/ubuntu/trinityrnaseq/trinity-plugins/Trimmomatic/adapters/TruSeq3-PE-2.fa:2:40:15 LEADING:2 TRAILING:2 MINLEN:25" &
Ctrl + A
d
#############################

# Quality Check your transcriptome
# Assess the quality using the BUSCO eukaryota dataset (For most transcriptomes, something like 60-90% complete BUSCOs should be accepted. This might even be less (even though your transcriptome is complete) if you are assembling a marine invertebrate or some other "weird" non-model organism
python3 ~/BUSCO_v1.22/BUSCO_v1.22.py -m tran --cpu 16 -l ~/eukaryota_odb9 -o V10_BUSCO -i Trinity.fasta

# In addition to BUSCO evaluate your assembly with Transrate. A transrate score >0.22 is generally thought to be acceptable, though higher scores are usually achievalbe. There is a good*fasta assembly in the output directory which you may want to use as the final assembly or for further filtering [e.g., TPM], or for something else
transrate -o transrate-assembly -t 16 -a Trinity.fasta --left left.fq --right right.fq

# Filtering: Maximize the transrate score (assays structural integrity) while preserving the BUSCO score (assays genic completeness) - at some level this is a trade off.- Some people may require a structually accurate assembly and not care so much abot completeness. Others, dare I say most, are interested in completeness - reconstructing everything possible - and care less about structure. 
# In general, for low coverage datasets (less than 20 million reads), filtering based on expression, using TMP=1 as a threshold performs well, with Transrate filtering often being too aggressive. With higher coverage data (more than 60 million reads) Transrate filtering may be worthwhile, as may expression filtering using a threshold of TMP=0.5. Again, these are general recommendations, you’re dataset may perform differently.
# To do the filtering, run BUSCO on the good*fasta file which is a product of Transrate. This assembly may be very good (or maybe not). I typically use this one if the number of BUSCOs does not decrease by more than a few percent, relative to the raw assembly output from Trinity. Use the BUSCO code from above, changing the name of the input and output. In addition to Transrate filtering (of as an alternative), it is often good to filter by gene expression. I typically filter out contigs whose expression is less than TMP=1 or TMP=0.5.

# Estimate expression with Kallisto
kallisto index -i kallisto.idx Trinity.fasta
kallisto quant -t 32 -i kallisto.idx -o kallisto_orig left.fq right.fq

# Estimate expression with Salmon
~/salmon-0.8.2/bin/salmon index -t Trinity.fasta -i salmon.idx --type quasi -k 31
~/salmon-0.8.2/bin/salmon quant -p 32 -i salmon.idx -l IU -1 left.fq -2 right.fq -o salmon_orig

# Pull down transcripts whose TPM > 1
awk '1>$5{next}1' kallisto_orig/abundance.tsv | awk '{print $1}' > kallist
awk '1>$3{next}1' salmon_orig/quant.sf | sed  '1,10d' | awk '{print $1}' > salist
cat kallist salist | sort -u > uniq_list
sed -i ':begin;N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' Trinity.fasta
for i in $(cat uniq_list);
   do grep --no-group-separator --max-count=1 -A1 -w $i Trinity.fasta >> Rcorr_highexp.Trinity.fasta;
done

sed -e '/^>/s/$/@/' -e 's/^>/#/' Rcorr_highexp.Trinity.fasta | tr -d '\n' | tr "#" "\n" | tr "@" "\t" | sort -u -t ' ' -f -k1,1 | sed -e 's/^/>/' -e 's/\t/\n/' > Rcorr_highexp.Trinity.fixed.fasta

# Assess the BUSCO and Transrate scores for the good assembly (from Transrate output)
transrate -o good.Transrate -t 16 -a good.Trinity.fasta --left left.fq --right right.fq
python3 ~/BUSCO_v1.22/BUSCO_v1.22.py -m tran --cpu 16 -l ~/eukaryota_odb9 -o good.BUSCO -i good.Trinity.fasta

# Assess the BUSCO and Transrate scores for the TMP > 1 data
transrate -o Rcorr_highexp_Transrate -t 16 -a Rcorr_highexp.Trinity.fixed.fasta --left left.fq --right right.fq
python3 ~/BUSCO_v1.22/BUSCO_v1.22.py -m tran --cpu 16 -l ~/eukaryota_odb9 -o Rcorr_highexp_BUSCO -i Rcorr_highexp.Trinity.fixed.fasta

##### MAYBE COMMENT ME OUT ##################
### python3 ~/busco/scripts/run_BUSCO.py -m tran --cpu 16 -l ~/eukaryota_odb9 -o good.V10-Rcorr_highexp_BUSCO -i good.V10-Rcorr_highexp.Trinity.fasta

# Annotate the transcriptome using dammit! Choose the optimal assembly based on BUSCO and Transrate results
mkdir dammit && cd dammit
dammit databases --install --database-dir /home/ubuntu/dammit --full --busco-group metazoa
dammit annotate /home/ubuntu/good.Trinity.fasta --busco-group metazoa --n_threads 36 --database-dir /home/ubuntu/dammit/ --full


