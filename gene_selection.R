##############
#
# Function to select genes for tree dating
#
##############
# Packages
require(phangorn)
library(adephylo)
require(ips)
#
setwd("")
#
######### input data
# individual alignments
files <- list.files("./", pattern = ".FNA$")
#
alignments <- list()
for (i in 1:length(files)) alignments[[i]] <- read.phyDat(files[i], format = "fasta", type = "DNA")
#
names(alignments) <- gsub(".FNA", "", files)
#
x <- unlist(lapply(alignments, function(x) length(x)))
#
alignments <- alignments[which(x == max(x))]
#
# trees
#
tree <- read.tree("")
#
trees <- read.tree("")
#
trees <- trees[which(x == max(x))] # select the trees with all tips
#
trees <- root(trees, "")
#
#
######### function
gene.selection <- function(alignments, trees, tree, prop = 1, genes, weight = c(1,1,1)) 
# alignments = gene alignments individually; trees = gene trees; genes = number of genes to be selected; var = type of selection to be done; weight = weighting scheme for the four variables (i.e, PIS, length, branch lengths, and topology distance)
		{
			#
			missing_codes <- c("-", "?", "n", "N", "X", "x")
			MD <- unlist(lapply(lapply(alignments, as.character), function(x) mean(x %in% missing_codes)))
			BL <- unlist(lapply(trees, function(x) IQR(node.depth.edgelength(x)[1:Ntip(tree)])))
			TOPO <- unlist(lapply(trees, RF.dist, tree))
			#
			{
					x <- log((MD/min(MD)))*weight[1] + log((BL/min(BL)))*weight[2] + log((TOPO/min(TOPO)))*weight[3]
					selected <- sort(x, decreasing = FALSE)[1:genes]
					result <- names(alignments[which(x %in% selected)])
			}
			return(result)
		}
#
#
#
selection <- gene.selection(alignments = alignments, trees = trees, tree = tree, genes = 30, weight = c(1,1,1))
#
#
#
#########