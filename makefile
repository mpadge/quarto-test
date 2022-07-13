all: html pdf 

html:
	quarto render index.Rmd -t html

pdf:
	quarto render index.Rmd -t pdf
