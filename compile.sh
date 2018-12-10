#!/usr/bin/env bash

validate () {
	xmllint --noout $1 --schema $2
	if (( $? != 0 ))
	then
		echo
		echo "Failed to validate" $1 "data."
		exit 1
	fi
}

compile_maquette () {
	xsltproc templates/compile.xsl $1 -o $2 && validate $1 schemas/compile.xsd
}

if (( $# != 2 ))
then
	echo "Usage :" $0 "<maquette data file> <compiled output file>"
	exit 1
fi

# Validate data files
validate xml/departements.xml schemas/departements.xsd
validate xml/grandsDomaines.xml schemas/grandsDomaines.xsd
validate xml/personnels.xml schemas/personnels.xsd
validate xml/promos.xml	schemas/promos.xsd

# Validate input maquette file
validate $1 schemas/maquette.xsd

# Compile input maquette file
compile_maquette $1 $2


