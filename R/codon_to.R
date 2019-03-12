#' Maximize or minimize the usage of certain codon.
#'
#' Input string of a codon to either the "max.codon = " or "min.codon = "
#' parameter to maximize or minimize the usage of certain codon in the sequence.
#'
#' @param object A regioned_dna object.
#' @param max.codon A string of a codon.
#' @param min.codon A string of a codon.
#' @param ...
#'
#' @return A regioned_dna object.
#' @export
#' @seealso \code{\link{input_seq}}, \code{\link{dinu_to}},
#'   \code{\link{codon_random}}, \code{\link{codon_mimic}},
#'   \code{\link{codon_mimic_dinu_to}}
#' @examples
#' get_cu(codon_to(rgd.seq, max.codon = "AAC")) - get_cu(rgd.seq)
#' get_cu(codon_to(rgd.seq, min.codon = "AAC")) - get_cu(rgd.seq)
#'
#' @name codon_to
#' @rdname codon_to-method
#' @include regioned_dna_Class.R
setGeneric(name = "codon_to",
  def = function(object, max.codon = NA, min.codon = NA, ...){
    standardGeneric(f = "codon_to")})

#' @name codon_to
#' @rdname codon_to-method
setMethod(f = "codon_to", signature = "regioned_dna",
  definition = function(object, max.codon, min.codon){
    max.codon <- toupper(max.codon)
    min.codon <- toupper(min.codon)
    codon.input <- c(max.codon, min.codon)
    codon.input <- codon.input[!sapply(codon.input, is.na)]
    if(length(codon.input) == 0){
      stop("please specify at least one parameter of 'max.codon' or 'min.codon'")
    }
    if(all(!is.na(c(max.codon, min.codon)))){
      stop("Only one parameter is supported between 'max.codon' and 'min.codon'")
    }
    if(length(codon.input) > 2){
      stop("Only one codon is allowed for input in 'max.codon' or 'min.codon'")
    }
    check.valid.codon <- toupper(codon.input) %in% names(Biostrings::GENETIC_CODE)
    if(!check.valid.codon){
      stop("Please input valid DNA codon")
    }

    # extract region ----------------------------------------------------------

    check.region <- all(is.na(object@region))
    if(!check.region){
      seq <- sapply(as.character(object@dnaseq), function(x){splitseq(s2c(x))})
      seq.region <- mapply(function(x, y){
        return(x[y])
      }, seq, object@region)
    } else {
      seq.region <- sapply(as.character(object@dnaseq),
        function(x){splitseq(s2c(x))})
    }

    # do mutation -------------------------------------------------------------

    if(!is.na(max.codon)){
      max.aa <- seqinr::translate(s2c(max.codon))
      seq.region.aa <- sapply(seq.region, function(x){
        seqinr::translate(s2c(c2s(x)))
      })
      id <- sapply(seq.region.aa, function(x){
        which(x == max.aa)
      })
      seq.mut <- mapply(function(x, y){
        if(length(y)>0){
          x[y] <- toupper(max.codon)
        }
        return(x)
      }, seq.region, id)
    } else {
      min.aa <-  seqinr::translate(s2c(min.codon))
      seq.region.aa <- sapply(seq.region, function(x){
        seqinr::translate(s2c(c2s(x)))
      })
      id <- sapply(seq.region.aa, function(x){
        which(x == min.aa)
      })
      alt.codon <- toupper(seqinr::syncodons(min.codon)[[1]])
      alt.codon <- alt.codon[!(alt.codon == min.codon)]
      seq.mut <- mapply(function(x, y){
        if(length(y)>0){
          x[y] <- toupper(sample(alt.codon, length(y), replace = T))
        }
        return(x)
      }, seq.region, id)
    }

    # merge region ------------------------------------------------------------

    if(!check.region){
      seq.mut <- mapply(function(x, y, z){
        x[y] <- z
        return(x)
      }, seq, object@region, seq.mut)
    }
    seq.mut <- Biostrings::DNAStringSet(sapply(seq.mut, c2s))

    return(new(
      "regioned_dna",
      dnaseq = seq.mut,
      region = object@region
    ))
  })