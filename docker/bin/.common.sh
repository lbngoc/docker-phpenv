#!/bin/bash



##### COLOR VARIABLES
red=$'\e[31m'
green=$'\e[32m'
yellow=$'\e[33m'
cyan=$'\e[36m'
purple=$'\e[35m'
reset=$'\e[0m'

##### FUNCTIONS

output() {
	case "$2" in
		-e)
			OUTPUT="$red$1$reset";;
		-s)
			OUTPUT="$green$1$reset";;
		-w)
			OUTPUT="$yellow$1$reset";;
		-i)
			OUTPUT="$cyan$1$reset";;
		*)
			OUTPUT="$purple$1$reset";;
	esac
	echo -e $OUTPUT
}

input() {
	read -p "$purple> $*$reset" INPUT_VALUE
	echo $INPUT_VALUE
}

##### SETUP DIRECTORIES NAME

READLINK='readlink'
unamestr=`uname`
if [ "$unamestr" == 'FreeBSD' -o "$unamestr" == 'Darwin'  ]; then
  READLINK='greadlink'
fi

if [ -z "`which $READLINK`" ]; then
    output e "[ERROR] $READLINK not installed"
    output e "        make sure coreutils are installed"
    output e "        MacOS: brew install coreutils"
    exit 1
fi

SCRIPT_DIR=$(dirname "$($READLINK -f "$0")")
ROOT_DIR=$($READLINK -f "$SCRIPT_DIR/../../")
SOURCE_DIR=$($READLINK -f "$ROOT_DIR/src")
BACKUP_DIR=$($READLINK -f "$SCRIPT_DIR/../backup")
