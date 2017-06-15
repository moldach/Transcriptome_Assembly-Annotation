# This is an R script for making a KOG frequency plot of KOG classes
# Open the Class output file from WebMGA and change your frequencies to match 
# Your data may have more classes. in that case add to factors to FunctionClass; legend; Frequency

dat <- data.frame(
	  dat <- data.frame(
  FunctionClass = factor(c("A", "B", "G", "I", "K", "M", "O", "R", "S", "T", "U", "V", "W", "Y", "Z"), levels=c("A", "B", "G", "I", "K", "M", "O", "R", "S", "T", "U", "V", "W", "Y", "Z")),
  legend = c("A: RNA processing and modification", "B: Chromatin structure and dynamics", "G: Carbohydrate transport and metabolism", "I: Lipid transport and metabolism", "K: Transcription", "M: Cell wall/membrane/envelope biogenesis", "O: Posttranslational modification, protein turnover, chaperones", "R: General function prediction only", "S: Function unknown", "T: Signal transduction mechanisms", "U: Intracellular trafficking, secretion, and vesicular transport", "V: Defense mechanisms", "W: Extracellular structures", "Y: Nuclear structure", "Z: Cytoskeleton"),
  Frequency=c(260,3,1,1,1753,461,5072,87,14660,17455,152330,1,811,154288,5))
)

library(ggplot2)

jpeg('KOG-Freq.jpg')
p <- ggplot(data=dat, aes(x=FunctionClass, y=Frequency, fill=legend))+
geom_bar(stat="identity", position=position_dodge(), colour="seashell")
p + guides (fill = guide_legend(ncol = 1))+
xlab("Factor Class")+
ggtitle("Acropora gemmifera KOG classes")
dev.off()
