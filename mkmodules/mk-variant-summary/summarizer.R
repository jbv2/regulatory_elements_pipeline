## Load libraries
library("ggplot2")
library("dplyr")

#starting args object to recieve arguments from command line
#solution taken from https://www.r-bloggers.com/passing-arguments-to-an-r-script-from-command-lines/
args = commandArgs(trailingOnly = TRUE)
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
GH_variants.df <- read.table(file = input_file, header = TRUE, sep = "\t")

# Data handling
output.df <- GH_variants.df

# Save output
write.table(x = output.df, file = output_file, append = FALSE, quote = FALSE, sep = "\t", row.names = FALSE, col.names = T)