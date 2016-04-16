all: hw2.pdf hw2_code.pdf

hw2.pdf: hw2_code.pdf

%.pdf: %.tex clean
	pdflatex $<
	pdflatex $<

clean:
	rm *.pdf || true
	rm *.aux || true
	rm *.out || true
	rm matlab/*.pdf || true

.PHONY: clean all
