#!/bin/bash

# copy pdfs and name correctly
# rm docs/ms_kleptomove_*.pdf

cp figures/fig_0*.png ms-pathomove/figures

cd overleaf-kleptomove
pdflatex ms-plain.tex
bibtex ms-plain.aux
bibtex ms-plain.aux
pdflatex ms-plain.tex

cd ..

cp -p ms-pathomove/ms-plain.pdf docs/ms_pathomove_`date -I`.pdf

# render docx
# pandoc overleaf-kleptomove/manuscript.tex --reference-doc=docs/template.docx --bibliography=overleaf-kleptomove/kleptomove.bib -o docs/ms_kleptomove_`date -I`.docx

# no refs
# pandoc overleaf-kleptomove/manuscript.tex --reference-doc=docs/template.docx -o docs/ms_kleptomove_`date -I`_no_refs.docx
