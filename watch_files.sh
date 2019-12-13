#!/bin/bash

function del {
	rm -rf auto/
	find . -name '*.aux' -delete
	find . -name '*.log' -delete
	find . -name '*.lof' -delete
	find . -name '*.nav' -delete
	find . -name '*.out' -delete
	find . -name '*.snm' -delete
	find . -name '*.synctex.gz' -delete
	find . -name '*.toc' -delete
	find . -name '*.blg' -delete
	find . -name '*.fdb_latexmk' -delete
	find . -name '*.fls' -delete
	find . -name '*.bcf' -delete
	find . -name '*.bbl' -delete
	find . -name '*.run.xml' -delete
}

latexmk -C
if [ "$WITHOUT_BIBER"  = "false" ]; then
    biber main
fi
latexmk -cd -interaction=nonstopmode -pdf main.tex
del

if [ "$RUN_ONCE"  = "true" ]; then
	exit 0
fi

inotifywait -m -r -e close_write --format '%w%f' "." | while read MODIFIED
do
    if [[ $MODIFIED == *.tex ]] ;
    then
	latexmk -c
    if [ "$WITHOUT_BIBER"  = "false" ]; then
        biber main
    fi
    latexmk -cd -interaction=nonstopmode -pdf main.tex
	latexmk -c
	del
    fi
done
