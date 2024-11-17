slides.pdf : slides.md examples/*.dsp Makefile
	make -C examples
	pandoc -t beamer --template=custom-template.tex -o slides.pdf slides.md

clean:
	rm -f slides.pdf
	make -C examples clean
