#!/bin/bash

if [ $# -eq 0 ]
then
    echo "usage: "$0" <path/error-code>"
    exit -1
fi

if [ ! $# -eq 1 ]
then
    echo "Error: Incorrect number of parameters (exactly 1 parameter required)."
    exit -1
fi

ERROR_FOLDER=$1
ERROR_CODE=`basename $ERROR_FOLDER`
ERROR_DATA_FILE=$ERROR_FOLDER/data.yml

echo "---"
echo "title: "`echo $ERROR_CODE | sed 's/_/_\&shy;/g'`
echo "error-code: "$ERROR_CODE
echo -n "slug: "
echo $ERROR_CODE | sed 's/[A-Z]/\L&/g' | sed 's/_/-/g'

if [ -f $ERROR_DATA_FILE ]
then
    cat $ERROR_DATA_FILE
fi
echo

if [ -f $ERROR_FOLDER/Makefile ]
then
    echo "verify-openssl: |"
    make --silent --directory=$ERROR_FOLDER --just-print --always-make verify-openssl | sed 's/^/    /' | sed 's|_certs/||g'
fi

echo "---"