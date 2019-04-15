## SynMut: Tools for designing Synonymous Mutants in Virus Research for DNA sequences

#### Intro

*SynMut* designs synonymous mutants for DNA sequences. 
There are increasing demands on designing virus mutants with specific dinucleotide or codon composition. This tool can take both dinucleotide preference and/or codon usage bias into account while designing mutants. It also works well for desinging mutants with extremely over-/under- represented dinucleotides. 
This tool was originally designed for generating recombinant virus sequences in influenza A virus to study the effects of different dinucleotide usage and codon usage, yet these functions provided in this package can be generic to a variety of other biological researches.

#### Components of the package

![image](https://raw.githubusercontent.com/Koohoko/SynMut/master/docs/component.png)

#### Installation 

```
if (!requireNamespace("SynMut", quietly = TRUE))
    devtools::install_github("Koohoko/SynMut")

library(SynMut)
```

#### Example

Details please refer to the [vignette](https://koohoko.github.io/SynMut/).