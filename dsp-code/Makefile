all : mixer1.pdf mixer2.pdf mixer3.pdf

mixer1.pdf : mixer1.dsp
	faust2svg mixer1.dsp
	inkscape -o mixer1.pdf mixer1-svg/process.svg

mixer2.pdf : mixer2.dsp
	faust2svg mixer2.dsp
	inkscape -o mixer2.pdf mixer2-svg/process.svg

mixer3.pdf : mixer3.dsp
	faust2svg mixer3.dsp
	inkscape -o mixer3.pdf mixer3-svg/process.svg

