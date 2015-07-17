#!/bin/bash

for file in $(ls inputs/*.in)
do
        file_name=$(basename $file)
        swipl -s linetris -g go < $file > outputs/${file_name%.in}.out
done
