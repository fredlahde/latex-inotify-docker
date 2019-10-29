#!/bin/bash
latexmk -C
latexmk -cd -interaction=nonstopmode -pdf main.tex
inotifywait -m -r -e close_write --format '%w%f' "." | while read MODIFIED
do
    if [[ $MODIFIED == *.tex ]] ;
    then
	latexmk -c
        latexmk -cd -interaction=nonstopmode -pdf main.tex
    fi
done
