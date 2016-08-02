#!/bin/sh
#$Id$
#Copyright (c) 2016 Pierre Pronchery <khorben@defora.org>
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



#variables
PROGNAME="tests.sh"
#executables
AR="${OBJDIR}../src/ar${EXEEXT}"
DATE="date"
DEBUG="_debug"
RM="rm -f"


#functions
#date
_date()
{
	if [ -n "$SOURCE_DATE_EPOCH" ]; then
		$DATE -d "@$SOURCE_DATE_EPOCH"
	else
		$DATE
	fi
}


#debug
_debug()
{
	echo "$@" 1>&2
	"$@"
}


#usage
_usage()
{
	echo "Usage: $PROGNAME [-c][-O name=value...][-P prefix] target..." 1>&2
	return 1
}


#main
clean=0
while getopts "cO:P:" name; do
	case "$name" in
		c)
			clean=1
			;;
		O)
			export "${OPTARG%%=*}"="${OPTARG#*=}"
			;;
		P)
			#XXX ignore
			;;
		*)
			_usage
			exit $?
			;;
	esac
done
shift $((OPTIND - 1))
if [ $# -eq 0 ]; then
	_usage
	exit $?
fi

while [ $# -ne 0 ]; do
	target="$1"
	shift

	$DEBUG $RM -- ${OBJDIR}tests.a				|| return 2

	[ $clean -eq 0 ]					|| break

	(_date
	echo
	$AR -rv ${OBJDIR}tests.a \
		$OBJDIR../src/ar.o \
		$OBJDIR../src/ar${EXEEXT} &&
	$AR -tv ${OBJDIR}tests.a) > "$target"			|| return 2
done
