# save comp. of the evolution heuristics.

library(readr)
library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)

args <- commandArgs(trailingOnly = TRUE)

print(paste("--- Trace file: ", args[1:length(args)-1]," ---"))
print(paste("--- Output file: ", args[length(args)]," ---"))

files <- args[1:length(args)-1]
output_preffix <- args[length(args)]
var_width <- 12
dataName <- ""

megadata <- data.frame(matrix(
  vector(), 0, 8, dimnames=list(c(), c("Time", "Layer", "Type", "Rejecteded", 
                                       "Uninterested", "Unsure", "Interested", "
                                       Accepteded"))), stringsAsFactors=F)

n<-0
for (file in files) {
  gtrace <- read_delim(file, delim=',')
  n <- n + 1
  tmpvec <- strsplit(files[n], split = "/")
  print(tmpvec)
  tmp <- tmpvec[[1]][length(tmpvec[[1]])]
  print(tmp)
  tmpvec <- strsplit(tmp, split = "_")
  tmp <- tmpvec[[1]][3]
  if (dataName=="") dataName <- tmpvec[[1]][1]
  tmp <- gsub(".csv", "", tmp)
  # print(strsplit(files[n], split = "_"))
  print(paste("Name:", tmp))
  if (tmp == "absolute") tmp <- "omniscient"
  gtrace$Id <- n
  gtrace$Name <- str_wrap(tmp, width=var_width)
  megadata <- rbind(megadata, gtrace)
}

megadata <- megadata %>% drop_na()


megadata$Name <- factor(megadata$Name,      # Reordering group factor levels
                        levels = c("omniscient", "biased", "local", "probabilistic", "surprised", "neighbor"))


ggplot2::ggplot(megadata, aes(x=Time)) +
  # geom_violin(aes(y=Exploitation, color="Exploitation", alpha=0.4)) +
  # geom_point(aes(y=Exploitation, color="Exploitation", alpha=0.4)) +
  geom_smooth(aes(y=Exploitation, color="Exploitation")) +
  # geom_violin(aes(y=Exploration, color="Exploration", alpha=0.4)) +
  # geom_point(aes(y=Exploitation, color="Exploitation", alpha=0.4)) +
  geom_smooth(aes(y=Exploration, color="Exploration")) +
  # geom_violin(aes(y=Ambiguity, color="Ambiguity", alpha=0.4)) +
  # geom_point(aes(y=Exploitation, color="Exploitation", alpha=0.4)) +
  geom_smooth(aes(y=Ambiguity, color="Ambiguity")) +
  scale_color_manual(values = c("darkgreen", "steelblue", "darkred")) +
  facet_grid(cols=vars(Name)) +
  labs(x="Number of questions asked", y="Heuristic value",
       caption=paste("Dataset: ", dataName), text = element_text(size=15)) +
  theme(text = element_text(size=15),
        axis.title.x = element_text(size=18),
        axis.title.y = element_text(size=18),
        axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5,
                                   size = 18),
        axis.text.y = element_text(size = 18),
        strip.text.x=element_text(size = 18)) +
  guides(alpha = "none")
ggsave(width=300, height=150, units="mm", dpi=320,  paste(output_preffix, "heuristic_comp.png", sep="_"))

