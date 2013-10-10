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
CONVPLOTS = ${TEMP}/plots
CONVIMG   = ${TEMP}/img

export TEXINPUTS := ${TEXINPUTS}:${INPUT}:${CONVIMG}:${CONVPLOTS}:${IMG}:${PLOTS}



##################################################
##                                     image rules
##################################################

PLOTS_EPS     := $(wildcard ${PLOTS}/*.eps)
PLOTS_EPS2PDF := $(patsubst ${PLOTS}/%.eps,${CONVPLOTS}/%.pdf,$(PLOTS_EPS))

${CONVPLOTS}/%.pdf: ${PLOTS}/%.eps
	inkscape --without-gui --file=$< --export-pdf=${CONVPLOTS}/$*.pdf 

IMG_EPS     := $(wildcard ${IMG}/*.eps)
IMG_EPS2PDF := $(patsubst ${IMG}/%.eps,${CONVIMG}/%.pdf,$(IMG_EPS))

${CONVIMG}/%.pdf: ${IMG}/%.eps
	inkscape --without-gui --file=$< --export-pdf=${CONVIMG}/$*.pdf 


##################################################
##                              build instructions
##################################################

all: ${INPUT}/${PROJECT}.tex ${PLOTS_EPS2PDF} ${IMG_EPS2PDF}
	pdflatex -output-directory ${OUT} $<
	pdflatex -output-directory ${OUT} $<
	cp ${OUT}/${PROJECT}.pdf ${PWD}

clean:
	rm -rf ${OUT}/*
	if [ -a ${PROJECT}.pdf ] ; then rm ${PROJECT}.pdf ; fi;

reset: clean
	rm -rf ${CONVPLOTS}/*
	rm -rf ${CONVIMG}/*
