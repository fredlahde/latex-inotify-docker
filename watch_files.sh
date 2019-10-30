#!/bin/bash
latexmk -C
biber main
latexmk -cd -interaction=nonstopmode -pdf main.tex
inotifywait -m -r -e close_write --format '%w%f' "." | while read MODIFIED
do
    if [[ $MODIFIED == *.tex ]] ;
    then
	latexmk -c
	biber main
        latexmk -cd -interaction=nonstopmode -pdf main.tex
    fi
done
