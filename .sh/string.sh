#!/bin/bash

# Function: repeatChars
# Purpose : Create a string that repeats $chars $x times
# Usage   : repeatChar <char> <x>
# Default : <chars> default to ''; <x> default to 0
function repeatChars () {
    chars=''
    x=0
    string=''
    if [ ! -z $1 ]
    then
        chars="$1"
    fi
    if [ ! -z $2 ]
    then
        x=$2
    fi
    for i in $(seq 1 $x);
    do
        string="$chars$string"
    done
    echo $string
}

# Function: lpad
# Purpose : Left pad to a string
# Usage   : lpad <string> <char> <x>
# Default : <chars> default to ''; <x> default to 0
function lpad() {
    padding=$(repeatChars "$2" $3)
    echo "$padding$1"
}

string=" Only!"
pad=' '
string=$(lpad "$string" "${pad}" 3)
echo "$string"
