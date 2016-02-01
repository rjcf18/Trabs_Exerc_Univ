 #!/bin/bash

for file in $(ls inputs/*.pl)
do
        file_name=$(basename $file)
        swipl main.pl < $file > outputs/${file_name%.pl}.asm
done