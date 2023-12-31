% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/input_seq.R
\name{input_seq}
\alias{input_seq}
\alias{input_seq,character-method}
\alias{input_seq,DNAStringSet-method}
\alias{input_seq,DNAString-method}
\title{Import region / constructing regioned_dna object}
\usage{
input_seq(object, region = NA, ...)

\S4method{input_seq}{character}(object, region)

\S4method{input_seq}{DNAStringSet}(object, region)

\S4method{input_seq}{DNAString}(object, region)
}
\arguments{
\item{object}{Filepath or DNAstringSet. The input sequences is suggested to
be in open reading frame(ORF).}

\item{region}{\code{NA}. A data.frame specifying paticular regions (positions
in amino acid sequence) that is allowed to be mutated in the sequences.
Both \code{1 / 0} or \code{TRUE / FALSE} encoding is OK. Please refer to
Examples below for reference.}

\item{...}{...}
}
\value{
A regioned_dna-class object
}
\description{
Constructing \code{regioned_dna} from DNAStringSet. Optionally input a
\code{region} data.frame to define restricted amino-acid region for mutation.
}
\examples{
# Creating a input_seq class directly from system file
filepath <- system.file("extdata", "example.fasta", package = "SynMut")
rgd.seq <- input_seq(filepath)

# Optionally input with region dataframe
filepath.fasta <- system.file("extdata", "example.fasta", package = "SynMut")
fp.csv <- system.file("extdata", "target_regions.csv", package = "SynMut")
region <- read.csv(fp.csv)
rgd.seq <- input_seq(filepath.fasta, region)

# Creating from exsisting DNAStringSet object
seq <- Biostrings::DNAStringSet("ATCGATCGA")
rgd.seq <- input_seq(seq)

}
\seealso{
\code{\link{get_cu}}, \code{\link{get_du}},
  \code{\link{get_region}}, \code{\link{get_dna}}
}
