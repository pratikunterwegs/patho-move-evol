#!/bin/bash

# copy pdfs and name correctly
rm docs/ms_pathomove_*.pdf

cp figures/fig_0*.png ms-pathomove/figures

cd ms-pathomove
pdflatex manuscript.tex
bibtex manuscript.aux
bibtex manuscript.aux
pdflatex manuscript.tex

cd ..

cp -p ms-pathomove/manuscript.pdf docs/ms_pathomove_`date -I`.pdf
