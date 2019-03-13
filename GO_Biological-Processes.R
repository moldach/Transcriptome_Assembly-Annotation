dat <- data.frame(
	  dat <- data.frame(
  FunctionClass = factor(c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"), levels=c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")),
  legend = c("A: Transport", "B: Transcription", "C: Cell cycle", "D: Differentiation", "E: Ubl conjugation pathway", "F: mRNA processing", "G: Stress response", "H: Apoptosis", "I: Neurogenesis", "J: DNA damage", "K: Lipid metabolism", "L: Protein biosynthesis", "M: Immunity", "N: Cillium biogenesis/degradation", "O: Meiosis", "P: Host-virus interaction", "Q: Cell adhesion", "R: Ribosome biogenesis", "S: Amino-acid biosynthesis", "T: Sensory transduction", "U: rRNA processing", "V: Biological rhythms", "W: Wnt signaling pathway", "X: Translation regulation", "Y: Angiogensis", "Z: Plant defense"),
  Frequency=c(1649,957,746,735,643,565,508,478,474,406,399,383,307,304,302,301,261,256,255,255,254,246,245,203,200,190))
)

library(ggplot2)

pdf('GO-Bio_Proc-Freq.pdf')
p <- ggplot(data=dat, aes(x=FunctionClass, y=Frequency, fill=legend))+
geom_bar(stat="identity", position=position_dodge(), colour="seashell")
p + guides (fill = guide_legend(ncol = 1))+
xlab("Factor Class")+
ggtitle("Biological Processes")
dev.off()
