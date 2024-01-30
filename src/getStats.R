#
# Prototype R script for Kerblam!
#
# It takes in a data frame of 14 multivariate observations and returns the
# correlation matrix as a TSV and a pair-plot. In addition, it prints (just
# on-screen) the summary statistics of a MLR fitting some explanatory variables.
# [adapted from: 'the Biomec Project']
#
# // FeAR // - 30-01-24
#

# Extract CLI arguments --------------------------------------------------------

input_file <- commandArgs(trailingOnly = TRUE)[1]
output_dir <- commandArgs(trailingOnly = TRUE)[2]
color <- commandArgs(trailingOnly = TRUE)[3]

# Package Loading --------------------------------------------------------------

library(magrittr) # load some packages

# Function Definition ----------------------------------------------------------

# R-equivalent to the MATLAB `repmat` function
# Just specify the matrix X and how many times you want it replicated row (m)
# and column (n) wise.
repmat <- function(X, m, n) {
  
  X <- as.matrix(X) # In order to be transposed
  cName_save <- colnames(X)
  rName_save <- rownames(X)
  
  mx <- dim(X)[1]
  nx <- dim(X)[2]
  
  mat <- matrix(t(matrix(X, mx, nx*n)), mx*m, nx*n, byrow = TRUE)
  colnames(mat) <- rep(cName_save, n)
  rownames(mat) <- rep(rName_save, m)
  
  return(mat)
}

# Data Loading -----------------------------------------------------------------

full_dataset <- read.table(input_file, header = TRUE, row.names = 1)

# Define batches ("EP" = EnvyPark, "GF" = Biomec) and subset data
batch <- c(rep("EP", 6), rep("GF", 8))
dataset <- full_dataset[grep("GF", batch),] # keep GF batch only

# Rearrange data
ISO_surf <- dataset[,4:dim(dataset)[2]] # explanatory vars
adhesion <- dataset[,1:3]               # response var (in triplicate)

ISO_surf <- as.data.frame(repmat(ISO_surf,3,1))
adhesion <- c(adhesion[,1], adhesion[,2], adhesion[,3])

# Data Analysis -----------------------------------------------------------------

# Correlation Matrix
corrMat <- round(cor(ISO_surf),3) %>%
  write.table(.,
              file.path(output_dir, 'correlation_matrix.tsv'),
              quote = FALSE,
              sep = "\t")

# Correlation ScatterPlot Matrix
pdf(file.path(output_dir, 'correlation_plot.pdf'),
    width = 14,
    height= 7)
pairs(ISO_surf,
      pch = 19, cex = 1,
      col = color,
      lower.panel = NULL,
      cex.labels = 3)
dev.off()

# Fit a multiple linear regression (MLR) model
attach(ISO_surf) # to have easy access to variable names (colnames)
  reduced_model <- lm(adhesion ~ Sp + Ssk + Sdr + Str)
detach(ISO_surf)
# Show Regression Coefficients and stats
summary(reduced_model)
