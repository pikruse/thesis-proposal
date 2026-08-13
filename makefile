
all:
	pdflatex my-dissertation
	makeindex my-dissertation.nlo -s nomencl.ist -o my-dissertation.nls
	biber my-dissertation
	pdflatex my-dissertation
	pdflatex my-dissertation

clean:
	rm -f back-matter/*.aux
	rm -f front-matter/*.aux
	rm -f chapters/*.aux
	rm -f my-dissertation.aux
	rm -f my-dissertation.bbl
	rm -f my-dissertation.bcf
	rm -f my-dissertation.blg
	rm -f my-dissertation.brf
	rm -f my-dissertation.fdb_latexmk
	rm -f my-dissertation.fls
	rm -f my-dissertation.lof
	rm -f my-dissertation.log
	rm -f my-dissertation.lot
	rm -f my-dissertation.nlo
	rm -f my-dissertation.nls
	rm -f my-dissertation.ilg
	rm -f my-dissertation.out
	rm -f my-dissertation.run.xml
	rm -f my-dissertation.toc
