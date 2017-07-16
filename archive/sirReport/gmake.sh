#!/usr/bin/env bash
#rm $2
numbering=false
number=0
IFS=''
while read -r line; do
    if [ "${line:0:11}" == "\end{minted" ]; then
        numbering=false
        number=0
    fi


    if $numbering; then
        if [ ! "$line" == "" ]; then

            i=0
            spaces=""
            while [ "${line:$i:1}" == " " ]; do
                i=$(($i + 1))
                spaces="$spaces "
            done
            number=$(($number + 10))

            echo $line | sed "s/\s*/${spaces}N$number /" #>> $2
        else
            echo $line #>> $2
        fi
    else
        echo $line #>> $2
    fi

    if [ "${line:0:13}" == "\begin{minted" ]; then
        numbering=true
    fi
done < $1
