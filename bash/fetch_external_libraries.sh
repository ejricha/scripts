#!/bin/bash
#
# fetch_external_libraries.sh
#
# Fetch external libraries as submodules

TOPDIR=`dirname $0`
EXTERNAL=".external"

# Initialize submodules like this:
#mkdir $EXTERNAL
#cd $EXTERAL
#git submodule add https://github.com/ejricha/scripts
#cd -

# Update all the external dependencies
for F in $TOPDIR/.external/*
do
	git submodule update --init $M
done
