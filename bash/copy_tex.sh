#!/bin/bash

# copy pdfs and name correctly
rm docs/ms_pathomove_*.pdf

cp figures/fig_0*.png ms-pathomove/figures

cd ms-pathomove
pdflatex ms-plain.tex
bibtex ms-plain.aux
bibtex ms-plain.aux
pdflatex ms-plain.tex

cd ..

cp -p ms-pathomove/ms-plain.pdf docs/ms_pathomove_`date -I`.pdf
