#!/usr/bin/env Rscript
library(tidyverse)
library(knitr)
library(rmarkdown)
library(optparse)

# Script command line options ---------------------------------------------

option_list <- list(
  make_option(c("-b", "--basedir"), type="character", default=NULL,
              help="Main workflow folder path", metavar="character"),
  make_option(c("-r", "--outdir"), type="character", default=NULL,
              help="Result folder path", metavar="character"),
  make_option(c("-i", "--input"), type="character", default=NULL,
              help="Workflow input data path", metavar="character"),
  make_option(c("-w", "--wf_report"), type="character", default=NULL,
              help="Workflow ireport .Rmd file", metavar="character"),
  make_option(c("-o", "--output"), type="character", default=1,
              help="Workflow report output path", metavar="character")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if (is.null(opt$basedir) | is.null(opt$outdir) | is.null(opt$wf_report) |
    is.null(opt$input) | is.null(opt$output)){
  print_help(opt_parser)
  stop("You need to provide the path to the main input and output folders\n", call.=FALSE)
}


rmarkdown::render(opt$wf_report,
                  params = list(directory = opt$basedir, input_data=opt$input),
                  output_file = opt$output,
                  output_dir = opt$outdir
                  )
