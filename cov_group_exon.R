library(tools)
library(data.table)

args <- commandArgs(TRUE)

N <- 8

bed <- read.table(args[1]) # bed <- read.table('/haplox/users/hy/Data/930.bed')

pos <- read.table(args[2]) # pos <- read.table('lung_gene_target_points.txt')

genes <- unique(pos[, 1])

genes_target <- read.table(args[3]) # genes_target <- read.table('gene_target_list.txt')

genes_all <- unique(union(genes, genes_target[, 1]))

filenames <- list.files(path = args[4], pattern = "_mark.txt$")

data_lst <- NULL

for (filename in filenames) {
  fname <- file_path_sans_ext(filename)
  data_lst[[fname]] <- as.data.frame(fread(paste(args[4], filename, sep = "/")))
}

for (gene in genes_all) {
  if (!gene %in% data_lst[[1]][, 4]) 
    next
  data <- sapply(data_lst, function(x) x[, 6][x[, 4] == gene])
  gene_filter <- subset(data_lst[[1]], V4 == gene)
  rownames(data) <- gene_filter[, 2] + gene_filter[, 5] - 1
  cov_max <- max(data)
  bed_sep <- bed[, 2][bed[, 4] == gene]
  offset <- match(bed_sep, rownames(data))[-1]
  col_len <- ncol(data)
  pic_num <- ifelse(col_len%%N, col_len%/%N + 1, col_len%/%N)
  for (n in 1:pic_num) {
    col_num <- ifelse(n * N <= col_len, N, col_len%%N)
    start <- (n - 1) * N + 1
    end <- start + col_num - 1
    plot_name <- paste("coverage_of_",gene, ".png", sep = "")
    png(file = paste(args[4], plot_name, sep = "/"), width = 1280, height = 480*col_num, units = "px")
    par(mfrow = c(col_num, 1))
    for (sample_name in colnames(data)[start:end]) {
      plot(data[, sample_name], col = "black", type = "h", lwd = 2, main = sample_name, xlab = paste(gene, "exons"), ylim = c(0, cov_max), ylab = "depth", cex.lab = 1, cex.axis = 1, xaxt = "n")
      sapply(offset, function(x) abline(v = x, col = "black", lwd = 0.5, lty = 2))
      lines(x = 1:nrow(data), y = rep(100, nrow(data)), col = "grey", lwd = 2)
      if (gene %in% genes) {
        pos_all <- unique(pos[, 2][pos[, 1] == gene])
        offset1 <- match(pos_all, rownames(data))
        cov_lst <- data[offset1, sample_name]
        cols <- rainbow(length(pos_all))
        for (i in 1:length(pos_all)) {
          abline(v = offset1[i], col = cols[i], lwd = 1)
        }
        legend(x = "topright", paste(pos_all, cov_lst, sep = ": "), col = cols, cex = 0.8, pch = 19, horiz = TRUE)
      }
    }
    dev.off()
  }
}
