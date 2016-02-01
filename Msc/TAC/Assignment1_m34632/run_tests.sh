 #!/bin/bash

for file in $(ls inputs/*.pl)
do
        file_name=$(basename $file)
        swipl TAC.pl < $file > outputs/${file_name%.pl}.ir
done