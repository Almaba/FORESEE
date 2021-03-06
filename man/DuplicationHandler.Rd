% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DuplicationHandler.R
\name{DuplicationHandler}
\alias{DuplicationHandler}
\title{Remove Duplicated Gene Names from a FORESEE Object}
\usage{
DuplicationHandler(Object, DuplicationHandling)
}
\arguments{
\item{Object}{FORESEE Object (ForeseeCell or ForeseeTrain) that contains all data needed to train a model, including molecular data (such as gene expression, mutation, copy number variation, methylation, cancer type, etc. ) and drug response data}

\item{DuplicationHandling}{Method for handling duplicates of gene names.
The function 'mean' calculates the mean of all rows that have the same gene name,
The function 'first' chooses the first hit of duplicated genes and discards the rest of genes with the same name,
The function 'none' removes all gene names that occur more than once.
The function 'listInputOptions("DuplicationHandler")' returns a list of the possible options.
Instead of chosing one of the implemented options, a user-defined function can be used as an input.}
}
\value{
\item{Object}{The object with unique gene names}
}
\description{
DuplicationHandler finds duplicates in the gene names (features) from the FORESEE Object and summarizes or deletes them according to the user's preferences.
}
\examples{
DuplicationHandler(GDSC,"first")
}
