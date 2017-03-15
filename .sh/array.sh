#!/bin/bash

# Function: calc
# Purpose : Calculate mathematical expression
# Usage   : calc <expr> <scale>
# Default : <scale> default to 2
function calc () {
    if [ -z $1 ] 
    then
        echo "Usage: calc <expr> <scale>"
    else
        if [ -z $2 ] 
        then
            scale=2
        else
            scale=$2
        fi
        echo "scale=$scale; $1" | bc;
    fi
}

