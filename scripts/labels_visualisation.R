# save comp. of the evolution of discovered labels.

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

y_limit <- 100

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
#~   print(strsplit(files[n], split = "_"))
  print(paste("Name:", tmp))
  if (tmp == "absolute") tmp <- "omniscient"
  gtrace$Id <- n
  gtrace$Name <- str_wrap(tmp, width=var_width)
  megadata <- rbind(megadata, gtrace)
}

if (dataName == "BCR-ABL") {
  y_limit <- 35
}

megadata <- megadata %>% drop_na()

megadata$Name <- factor(megadata$Name,      # Reordering group factor levels
                         levels = c("omniscient", "biased", "local", "probabilistic", "surprised", "neighbor", "entropy"))

# print(megadata)

megadataLift <- megadata[megadata$Type=="Lift", ]
megadataOracleLift <- megadata[megadata$Type=="OracleLift", ]
# megadataRappel <- megadata[megadata$Type=="Rappel", ]
megadataSampleDistribution <- megadata[megadata$Type=="SampleDistribution", ]
megadataOracleDistribution <- megadata[megadata$Type=="OracleDistribution", ]
megadataRecall <- megadata[megadata$Type=="Recall", ]
megadataDiscoveredLabels <- megadata[megadata$Type=="DiscoveredLabels", ]


megadataDiscoveredLabels <- megadataDiscoveredLabels  %>%
  group_by(Time, Name) %>%
  summarise(mean_accept=mean(Accepted),
            mean_interest=mean(Interested),
            mean_unsure=mean(Unsure),
            mean_uninterested=mean(Uninterested),
            mean_reject=mean(Rejected),
            .groups = "keep")

#~ print(megadataRecall)
ggplot2::ggplot(megadataRecall, aes(x=Time)) +
  geom_line(aes(y=Rejected, color="Rejected")) +
  geom_line(aes(y=Uninterested, color="Uninterested")) +
  geom_line(aes(y=Unsure, color="Unsure")) +
  geom_line(aes(y=Interested, color="Interested")) +
  geom_line(aes(y=Accepted, color="Accepted")) +
  scale_color_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple")) +
#~   scale_color_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple"), guide="none") +
#~   scale_fill_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple"), guide="none") +
  facet_grid(cols=vars(Name)) +
  labs(x="Number of questions asked", y="Mean Recall",
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
  scale_y_continuous(limits = c(0, y_limit)) #+
#~   scale_y_continuous(limits = c(0, 35)) #+
#~   scale_x_continuous(limits = c(0, 300))
ggsave(width=300, height=150, units="mm", dpi=320,  paste(output_preffix, "recall_comp.png", sep="_"))


ggplot2::ggplot(megadataDiscoveredLabels, aes(x=Time)) +
  geom_line(aes(y=mean_reject, color="Rejected")) +
  geom_line(aes(y=mean_uninterested, color="Uninterested")) +
  geom_line(aes(y=mean_unsure, color="Unsure")) +
  geom_line(aes(y=mean_interest, color="Interested")) +
  geom_line(aes(y=mean_accept, color="Accepted")) +
  scale_color_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple")) +
#~   scale_fill_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple"), guide="none") +
  facet_grid(rows=vars(Name)) +
  labs(x="Number of questions asked", y="Distribution in discovered labels",
       caption=paste("Dataset: ", dataName), text = element_text(size=15)) +
  theme(text = element_text(size=15),
        axis.title.x = element_text(size=18),
        axis.title.y = element_text(size=18),
        axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5,
                                   size = 18),
        axis.text.y = element_text(size = 18),
        strip.text.y = element_text(size = 18))
ggsave(width=300, height=150, units="mm", dpi=320, paste(output_preffix, "discovered_distrib_comp.png", sep="_"))


ggplot2::ggplot(megadataLift, aes(x=Time)) +
  geom_line(aes(y=Rejected, color="Rejected")) +
  geom_line(aes(y=Uninterested, color="Uninterested")) +
  geom_line(aes(y=Unsure, color="Unsure")) +
  geom_line(aes(y=Interested, color="Interested")) +
  geom_line(aes(y=Accepted, color="Accepted")) +
  scale_color_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple")) +
#~   scale_fill_manual(values = c("darkgreen", "steelblue", "darkred", "orange", "purple"), guide="none") +
  facet_grid(rows=vars(Layer), cols=vars(Name), scale="free_y") +
  labs(x="Number of questions asked", y="Mean Ground Truth Lift", 
       caption=paste("Dataset: ", dataName), text = element_text(size=15)) +
  theme(text = element_text(size=15),
        axis.title.x = element_text(size=18),
        axis.title.y = element_text(size=18),
        axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust = 0.5,
                                   size = 18),
        axis.text.y = element_text(size = 18),
        strip.text.x=element_text(size = 18),
        strip.text.y=element_text(size = 18))
ggsave(width=300, height=150, units="mm", dpi=320,  paste(output_preffix, "layered_groundtruth_lift.png", sep="_"))

