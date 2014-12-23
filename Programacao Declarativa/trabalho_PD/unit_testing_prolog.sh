#!/bin/bash

for file in $(ls inputs/*.in)
do
        file_name=$(basename $file)
        swipl -s linetris -g menu < $file > outputs/${file_name%.in}.out
done
