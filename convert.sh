#!/usr/bin/env bash

print_red () {
	printf "\033[31m$1\033[0m"
}
print_green () {
	printf "\033[32m$1\033[0m"
}
print_yellow () {
	printf "\033[33m$1\033[0m"
}

validate () {
	xmllint --noout $1 --schema $2
	if (( $? != 0 )); then
		echo
		print_red "Failed to validate $1 data.\n"
		exit 1
	fi
}

apply_template () {
	xsltproc -o $3 $1 $2
}

if (( $# != 2 )); then
	echo "Usage :" $0 "<maquette data file> <compiled output file>"
	exit 1
fi

echo

# Validate data files
print_yellow "** Validating data files **\n"
validate xml/departements.xml schemas/departements.xsd
validate xml/grandsDomaines.xml schemas/grandsDomaines.xsd
validate xml/personnels.xml schemas/personnels.xsd
validate xml/promos.xml	schemas/promos.xsd
echo

# Validate input maquette file
print_yellow "** Validating input maquette file **\n"
validate $1 schemas/maquette.xsd
echo


# Compile input maquette file into a tmp file
tmp=`mktemp`
print_yellow "** Compiling data files and maquette file into $tmp **\n"
apply_template templates/compile.xsl $1 $tmp
validate $tmp schemas/compile.xsd
echo

# Convert compiled file to html in the output file
print_yellow "** Converting compiled file to html format **\n"
apply_template templates/tohtml.xsl $tmp $2
echo

print_green "$1 has successfully been converted to $2\n"
echo
