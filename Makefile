# Utility to automatically build LaTeX files
compile=latexmk -pdf -pv -halt-on-error
error=2>&1 | pcregrep --color=always -A200 -B2 '^!(?!  ==> Fatal).*' || true

# Utility to automatically remove all intermediate files (e.g. ".aux", ".log")
cleanup=latexmk -C -bibtex -silent

main=thesis
sources:=$(shell find chapters frontbackmatter -name '*.tex')
bibs:=$(shell find chapters frontbackmatter -name '*.bib')

all: $(main).pdf

$(main).pdf: $(main).tex $(sources) $(bibs)
	$(compile) $< $(error)

clean:
	$(cleanup) $(main)

.PHONY: clean
