#!/bin/bash
for i in "$@"
do
# echo "$i"
    touch newfile.md
    echo "# $i\n" >> newfile.md
    cat "$i" >> newfile.md
    echo '\n'>> newfile.md
done
