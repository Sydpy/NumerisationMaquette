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
		if [[ VERBOSEMODE == 1 ]]; then
			echo
			print_red "Failed to validate $1 data.\n"
		fi
		exit 1
	fi
}

apply_template () {
	xsltproc -o $3 $1 $2
	if (( $? != 0 )); then
		if [[ VERBOSEMODE == 1 ]]; then
			echo
			print_red "Failed to apply template $1 to $2.\n"
		fi
		exit 1
	fi
}

if (( $# != 3 )); then
	echo "Usage :" $0 "<maquette data file> <compiled output file>"
	exit 1
fi


VERBOSEMODE=1

if [[ $1 == "-q" ]]; then
	VERBOSEMODE=0
fi
if [[ $1 == "-v" ]]; then
	VERBOSEMODE=1
fi

# Validate data files
if [[ VERBOSEMODE == 1 ]]; then
	echo
	print_yellow "** Validating data files **\n"
fi

validate xml/departements.xml schemas/departements.xsd
validate xml/grandsDomaines.xml schemas/grandsDomaines.xsd
validate xml/personnels.xml schemas/personnels.xsd
validate xml/promos.xml	schemas/promos.xsd

# Validate input maquette file
if [[ VERBOSEMODE == 1 ]]; then
	echo
	print_yellow "** Validating input maquette file **\n"
fi

validate $2 schemas/maquette.xsd

if [[ VERBOSEMODE == 1 ]]; then
	echo
fi


# Compile input maquette file into a tmp file
tmp=`mktemp`
if [[ VERBOSEMODE == 1 ]]; then
	print_yellow "** Compiling data files and maquette file into $tmp **\n"
fi
apply_template templates/compile.xsl $2 $tmp
validate $tmp schemas/compile.xsd

if [[ VERBOSEMODE == 1 ]]; then
	echo
fi

# Convert compiled file to html in the output file
if [[ VERBOSEMODE == 1 ]]; then
	print_yellow "** Converting compiled file to html format **\n"
fi
apply_template templates/tohtml.xsl $tmp $3

if [[ VERBOSEMODE == 1 ]]; then
	echo
fi

# Remove temp file
if [[ VERBOSEMODE == 1 ]]; then
	print_yellow "** Cleaning **\n"
fi
rm $tmp

if [[ VERBOSEMODE == 1 ]]; then
	echo
fi

print_green "$2 has successfully been converted to $3\n"
echo
