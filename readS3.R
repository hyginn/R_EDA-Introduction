# readS3.R
#
# Purpose: read supplementary table S3 from .csv into a dataframe
#
#
# ==============================================================================

# I have included a dataset with this project, a .csv file taken from
# suplementary data of a paper on tissue definition by single cell RNA seq, by
# Jaitin et al. (2014).

# http://www.ncbi.nlm.nih.gov/pubmed/24531970

# This data set contains log2 fold changes of gene expression enrichment in
# different cd11c+ cell populations, and their response to lipopolysaccharide
# stimulation. It was posted as an Excel file on the Science Website.  I have
# simply opened that file, and saved it as .csv, unchanged.

# First we open the file and have a look what it contains. Then we will properly
# read it into an R object.

rawDat <- read.csv("table_S3.csv",
                   header = FALSE)

# The object "rawDat" should appear in the Data section of the Environment tab
# in the top-right pane. It has a spreadsheet symbol next to it. Click that - or
# type View(rawDat), and study the object. You should find:
#
# - all columns are named Vsomething
# - rows 1 to 6 do not contain data
# - there is not a single row that could be used for column names
# - type str(rawDat): all columns are factors

# This all needs to be fixed.
rm(rawDat)

# - We do _not_ read one of the lines as a header (there is noo useable header
#     row in the datafile.)
# - We skip the six rows of comments. They do not contain data and including
#     them changes the typ of the data columns to "character". We need
#     "numeric" instead.
# - We make sure to use "stringsAsFactors = FALSE" - when we first read the
#      data, the character columns had been converted to factors!

LPSdat <- read.csv("table_S3.csv",
                   header = FALSE,
                   skip = 6,
                   stringsAsFactors = FALSE)

colnames(LPSdat) <- c("genes",      # gene names
                      "B.ctrl",     # Cell types are taken from
                      "B.LPS",      # Figure 4 of Jaitin et al.
                      "MF.ctrl",    # .ctrl and .LPS refer to control
                      "MF.LPS",     #   and LPS challenge
                      "NK.ctrl",    # The cell types are:
                      "NK.LPS",     #   B:    B-cell
                      "Mo.ctrl",    #   MF:   Macrophage
                      "Mo.LPS",     #   NK:   Natural killer cell
                      "pDC.ctrl",   #   Mo:   Monocyte
                      "pDC.LPS",    #   pDC:  plasmacytoid dendritic cell
                      "DC1.ctrl",   #   DC1:  dendritic cell subtype 1
                      "DC1.LPS",    #   DC2:  dendritic cell subtype 2
                      "DC2.ctrl",   #
                      "DC2.LPS",    #
                      "cluster")    # Gene assigned to cluster by authors

# confirm
head(LPSdat)
str(LPSdat)

typeInfo(LPSdat)

# Now, if everything is as it should be, let's save the object so we can
# easily reload it later.

save(LPSdat, file = "LPSdat.RData")

# rm(LPSdat)
# head(LPSdat)

# load("LPSdat.RData")    # <- this is how you can reload the data!
# head(LPSdat)


# [END]
