#!/bin/bash

ListFile()
{
	for file in `ls $1`;
        do
                if [ -d "$1/$file" ]; then
                    #echo "$file"
                    ListFile "$1/$file"
                else
                    echo "$1/$file"
                fi
        done
}


ListFile $1 > ./index.html
