## Load libraries
library("ggplot2")
library("dplyr")
library ("tidyr")

#starting args object to recieve arguments from command line
#solution taken from https://www.r-bloggers.com/passing-arguments-to-an-r-script-from-command-lines/
args = commandArgs(trailingOnly = T )
message("Voy a imprimir los archivos recibidos por R")
print(args)

# For Debbuging only
# Comentar estas líneas cuando el script pase a producción
#args[1] is the prerq file
#args[1] <- "test/data/sample_GH_variants.filtered.tsv"
#args[2] is the target file
#args[2] <- "test/data/sample_GH_variants.filtered.summary.tsv"

# Define input and outputs
input_file <- args[1]
output_file <- args[2]

# Load data frame
GH_variants.df <- read.table(file = input_file, 
                             header = T, sep = "\t")

# Data handling
# select only useful columns
genehancer_data.df <- GH_variants.df %>% 
  select(ID,
         GeneHancer_type_and_Genes)
# separate genehancer column 
split_cols_genehancer_data.df <- genehancer_data.df %>% 
  separate(col = GeneHancer_type_and_Genes, 
           into = c("GeneHancerID", "Type", "Gene"), 
           sep = "_", 
           remove = T)

# count the number of variants per GeneHancerID
variants_per_GeneHancerID.df <- split_cols_genehancer_data.df %>% 
  group_by(GeneHancerID) %>% 
  summarise( number_of_variants = n() 
             )

# Save output
write.table(x = variants_per_GeneHancerID.df, 
            file = output_file, 
            append = F, 
            quote = F, 
            sep = "\t", 
            row.names = F, 
            col.names = T)

# Make lolliplot plot
lolliplot.p <- ggplot(data = variants_per_GeneHancerID.df, 
       aes(x = GeneHancerID, 
           y = number_of_variants) 
       ) +
  geom_bar(stat = "identity", 
           width = 0.2, 
           color = "royalblue") +
  geom_point(size = 5, 
             color = "gray") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, 
                                   size = 5) 
        )

# Save lollipop plot
# Create dynamic name for output plot
output_lollipop_plot <- output_file %>% gsub(pattern = ".tsv.build", 
                     replacement = "_lollipop_plot.png")

#Save plot
ggsave(filename = output_lollipop_plot, 
       plot = lolliplot.p, 
       device = "png",
       width = 10.8,
       height = 7.2,
       units = "cm",
       dpi = 300)
