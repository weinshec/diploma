##################################################
##                           general path settings
##################################################

PROJECT   = diploma

PWD       = ${shell pwd}
INPUT     = ${PWD}/tex
PLOTS     = ${PWD}/plots
IMG       = ${PWD}/img

TEMP      = ${PWD}/temp
OUT       = ${TEMP}/out

export TEXINPUTS := ${TEXINPUTS}:${INPUT}



##################################################
##                              build instructions
##################################################

all: ${INPUT}/${PROJECT}.tex
	pdflatex -output-directory ${OUT} $<
	bibtex ${OUT}/${PROJECT}.aux
	pdflatex -output-directory ${OUT} $<
	pdflatex -output-directory ${OUT} $<
	cp ${OUT}/${PROJECT}.pdf ${PWD}

clean:
	rm -rf ${OUT}/*
	if [ -f ${PROJECT}.pdf ] ; then rm ${PROJECT}.pdf ; fi;

