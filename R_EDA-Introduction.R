# R_EDA-Introduction.R
#
# Purpose:
#
# Version: 1.0
#
# Date:    2016  06  01
# Author:  Boris Steipe (boris.steipe@utoronto.ca)
#          Some prior contributions by:
#            Raphael Gottardo, FHCRC
#            Sohrab Shah, UBC
# V 1.0    First code
#
# TODO:
#
#
# == HOW TO WORK WITH THIS FILE ======================================
#
#  Go through this script line by line to read and understand the
#  code. Execute code by typing <cmd><enter>. When nothing is
#  selected, that will execute the current line and move the cursor to
#  the next line. You can also select more than one line, e.g. to
#  execute a block of code, or less than one line, e.g. to execute
#  only the core of a nested expression.
#
#  Edit code, as required, experiment with options, or just play.
#  Especially play.
#
#  DO NOT simply source() this whole file!
#
#  If there are portions you don't understand, use R's help system,
#  Google for an answer, or ask me. Don't continue if you don't
#  understand what's going on. That's not how it works ...
#
#  This is YOUR file. Write your notes in here and add as many
#  comments as you need to understand what's going on here when you
#  come back to it in a year. That's the right way: keep code, data
#  and notes all in one place.
#
# ====================================================================
#
# Module 1: EDA (Exploratory Data Analysis)
#
# ====================================================================


# ==================================================
# As we begin ...
# ==================================================

# 1 - What's in the box - overview of files in this project:
#     .gitignore
#     .Rprofile
#     R_refcards
#     Plotting reference
#     Utilities:
#        readS3.R
#        typeInfo.R
#     Templates:
#        scriptTemplate.R
#        functionTemplate.R
#     Data:
#        table_S3.csv
#        GvHD.txt
#     Papers:
#       Jaitin 2014
#       Weissgerber 2015
#
# 2 - Confirm:
#           Confirm that the right files are present.
getwd()   # Confirm the correct directory


# ==================================================
# Load Data
# ==================================================

# Task:
# In yesterday's workshop we have worked with a
# a supplementary datafile from a 2014 publication
# on single-cell RNAseq for the automatic definition
# of tissue types. The data consists of gene-names,
# Expression values of clustered cells in the
# presence and absence of LPS stimulation, and
# cluster assignment labels. The corresponding
# paper is on the Wiki.

# We have experimented with loading the data and
# identified a number of issues. The commands
# to load the data are in the script readS3.R.
# Source this script to load the data.

# TASK:
#     source() the script "readS3.R"
#     inspect the object "LPSdat".



# ==== CHECKPOINT =========================
# Place a green PostIt on the lid of your
# laptop when done, place a pink PostIt
# if this didn't work or if you have
# questions.
# =========================================
#
# (Whenever you find a "Checkpoint" in this script, the
#  green/pink PostIt instructions are implied.)


# Optional tasks:
# While you are waiting for others to finish a "Checkpoint"
# here are two suggestions:
#
# - Study how RUnit can be used to write tests for
#   code correctness as you develop code:
#     1 - Install/load the "RUnit" package.
#     2 - Explore the vignettes it contains.
#     3 - Explore the functions it contains.
#
# - Learn about regular expressions at
#    http://steipe.biochemistry.utoronto.ca/abc/index.php/Regular_Expressions



# ==================================================
# Subsetting
# ==================================================

# Here is a quiz on subsetting as a recap. Write R expressions
# that get the following data from LPSdat:


# rows 1:10 of the first two columns in reverse order


# gene names and the expression values for Mo.LPS
# for the top ten expression values.
# hint: use order()


# All genes for which B-cells are stimulated by LPS by
# more than 2 log units.




# ==================================================
# Descriptive statistics
# ==================================================

set.seed(100)
x <- rnorm(100, mean=0, sd=1)
mean(x)
median(x)
IQR(x)
var(x)
sd(x)
summary(x)

# Task:
# 1 - What would be interesting characterizations
#     of LPSdat? Explore them.

# Example: mean baseline expression of gene in row 5
a <- LPSdat[5, 2:15]
a
b <- as.numeric(a)
mean(b)
mean(as.numeric(LPSdat[5, seq(2, 14, by = 2)]))

# Example: What are the most responsive genes for two
# cell types?

# ==== CHECKPOINT ... =========================



# =============================================
# Quantiles: what is the threshold that has a
# given fraction of values above/below it?

x <- seq(-4, 4, 0.1)
f <- dnorm(x, mean=0, sd=1)
q90 <- qnorm(0.90, mean = 0, sd = 1)
plot(x, f, xlab="x", ylab="density", type="l", lwd=5)
abline(v=q90, col=2, lwd=5)

# =============================================
# empirical quantiles

set.seed(100)
x <- rnorm(100, mean=0, sd=1)
quantile(x)
quantile(x, probs=c(0.1, 0.2, 0.9))
abline(v=quantile(x, probs=c(0.9)), col="green", lwd=3)

# =============================================

set.seed(100)
x <- rnorm(1000, mean=5, sd=2.5)
boxplot(x)
boxplot(x*x)


# Careful - a boxplot per se can obscure
# important structure in your data. Consider
# for example this bimodal distribution
x <- rnorm(100, mean=-2, sd=1)
x <- c(x, rnorm(100, mean=2, sd=1))
hist(x)
boxplot(x)

# Violin plot
if (!require(ggplot2, quietly=TRUE)) {
    install.packages("ggplot2")
    library(ggplot2)
}
X <- as.data.frame(x)

p <- ggplot(X, aes(1,x))
p + geom_violin()
# See ggplot2 introductory tutorial at
#     http://www.r-bloggers.com/basic-introduction-to-ggplot2/
# and violin plot documentation at
#     http://docs.ggplot2.org/current/geom_violin.html


# Plotting more than one column with a boxplot
# places the plots side by side.
colnames(LPSdat)
boxplot(LPSdat[ ,c("MF.ctrl", "MF.LPS")])
boxplot(LPSdat[ , c(seq(2, 14, by = 2), seq(3, 15, by = 2))])
abline(v=7.5)

# Task:
# 1 - What would be interesting quantiles
#     and boxplots in LPSdat?
#     Imagine, explore and share.
#
#     Interpret the result.


# ==== CHECKPOINT ... =========================


# ==================================================
# Explore plot types
# (Section 1 of PlottingReference.R)
# ==================================================

# ==================================================
# Probability distributions
# ==================================================

# The binomial distribution
?dbinom
x <- 0:1
f <- dbinom(x, size=1, 0.1)
plot(x, f, xlab="x", ylab="density", type="h", lwd=5)

set.seed(100)
x <- rbinom(100, size=1, prob=.1)
hist(x)


# ==================================================
# The Normal distribution
# ==================================================
?dnorm
x <- seq(-4, 4, 0.1)
f <- dnorm(x, mean=0, sd=1)
plot(x, f, xlab="x", ylab="density", lwd=5, type="l")


# ==================================================
# Explore lines (Section 3 of PlottingReference.R)
# ==================================================

x <- seq(-4, 4, 0.1)
f <- dnorm(x, mean=0, sd=1)
plot(x, f, xlab="x", ylab="density", lwd=5, lty=3, type="l")

# =============================================
# Overlay a histogram with a line
set.seed(100)
x <- rnorm(100, mean=0, sd=1)
hist(x)
lines(seq(-3,3,0.1),54*dnorm(seq(-3,3,0.1)), col="red")



# ==== QQ PLOTS ====================================

set.seed(100)
x <- rnorm(100, mean=0, sd=1)
qqnorm(x)
qqline(x, col=2)

# =============================================
# Plotting lines and legends
# Example: compare the normal distribution with
# the t-distribution
x <- seq(-4, 4, 0.1)
f1 <- dnorm(x, mean=0, sd=1)
f2 <- dt(x, df=2)
plot(x, f1, xlab="x", ylab="density", lwd=5, type="l")
lines(x, f2, lwd=5, col=2)
legend(-4, .4, c("Normal", "t2"), col=1:2, lwd=5)

# =============================================
# use qqplot to compare normally distributed samples with
# t-distributed samples

set.seed(100)
t <- rt(100, df=2)
qqnorm(t)
qqline(t, col=2)


# =============================================
# QQ- plot: sample against sample
set.seed(100)
x <- rnorm(100, mean=0, sd=1)
t <- rt(100, df=2)
qqplot(x, t)

# Task:
# 1 - What columns of LPSdat could be compared with
#     a qqplot? Explore this. Interpret the result.

# ==================================================
# Flow cytometry data
# ==================================================

# GvHD flow cytometry data is a sample dataset provided in the project.
gvhd <- read.table("GvHD.txt", header=TRUE)
head(gvhd)

# Only extract the CD3 positive cells

hist(gvhd[,5])

gvhdCD3p <- as.data.frame(gvhd[gvhd[, 5]>280, 3:6])

plot(gvhdCD3p[, 1:2])

# ==================================================
# Explore scatter plots
# Topics:
# Section 6 - Plotting symbols and characters
#         2 - Colors
#         4 - Coordinates
# ... of PlottingReference.R)
# ==================================================
# Scatter plots are extremely useful, but learning
# a bit about R's plotting capabilities will help
# tremendously to create INFORMATIVE plots.


# Some special packages
# The overlap in the GvHD data can obscure
# data relationships. Here are some alternatives
# for dense plots:

# load "hexbin" package from CRAN
if (!require(hexbin, quietly=TRUE)) {
    install.packages("hexbin")
    library(hexbin)
}

# variant one: hexbin
hb <- hexbin(gvhdCD3p[, 1:2], xbins = 20)
plot(hb, colramp = colorRampPalette(c("#FFFFDD",
                                      "#77EE99",
                                      "#3377AA",
                                      "#0033BB")))

# load "prada" package from BioConductor
if (!require(prada, quietly=TRUE)) {
    source("http://www.bioconductor.org/biocLite.R")
    biocLite("prada")
}

# variant two: smoothScatter
smoothScatter(gvhdCD3p[, 1:2], nrpoints=50, pch=20, cex=0.5, col="#6633BB55")

# variant three: colors vary by density
plot (gvhdCD3p[, c(1,2)], col=densCols(gvhdCD3p[, 1], gvhdCD3p[, 2]), pch=16, cex=2)


# Task:
# 1 - Create a scatterplot from differences in
#     LPS activation between a pair of cell types in LPSdat.
# 2 - Add a line that shows the situation if all
#     activations were equal.
# 3 - Redo the plot with density coloring

plot(LPSdat[ ,"Mo.ctrl"] - LPSdat[ ,"Mo.LPS"],
     LPSdat[ ,"MF.ctrl"] - LPSdat[ ,"MF.LPS"])
abline(0,1,col = "red")

# ==== Checkpoint ... =============




# =============================================
# Trellis plots: all against all

plot(gvhdCD3p, pch=".")

# =============================================

boxplot(gvhdCD3p)

# =============================================

oPar <- par(mfrow=c(2, 2))
hist(gvhdCD3p[, 1], 50, main=names(gvhdCD3p)[1], xlab="fluorescent intensity", ylim=c(0, 120))
hist(gvhdCD3p[, 2], 50, main=names(gvhdCD3p)[2], xlab="fluorescent intensity", ylim=c(0, 120))
hist(gvhdCD3p[, 3], 50, main=names(gvhdCD3p)[3], xlab="fluorescent intensity", ylim=c(0, 120))
hist(gvhdCD3p[, 4], 50, main=names(gvhdCD3p)[4], xlab="fluorescent intensity", ylim=c(0, 120))
par(oPar)


# [END]
