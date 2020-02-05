#!/bin/bash
#
# graph_dependencies.sh

GRAPH=graph
DOT=graph.dot

# Get the relative directory
DIR=`dirname $0`

# Main function
main()
{
	if [[ $# -gt 0 ]]
	then
		SRC=$1
	else
		SRC=".."
	fi
	echo "DIR=$DIR"
	echo "SRC=$SRC"

	# Source the common script
	source $DIR/common.sh

	# Check that we're in the right directory
	check_correct_directory $SRC

	# Create and fix up the graphs
	create_graphs $SRC
	convert_to_svg
	make_links_clickable
}

# Ensure that . contains CMakeCache.txt,
#  and $SRC/ contains CMakeLists.txt
check_correct_directory()
{
	# Check that CMake files are where we exepect them to be
	CMAKE_LISTS="$1/CMakeLists.txt"
	CMAKE_CACHE="./CMakeCache.txt"
	for F in $CMAKE_LISTS $CMAKE_CACHE
	do
		echo "Checking for $F"
		if [[ ! -e "$F" ]]
		then
			echo "Failed to find $CMAKE_CACHE" >&2
			exit 1
		fi
	done
}

# Create the graphs with CMake
create_graphs()
{
	# Only argument to this function is the source directory
	SRC=$1
	RUN cmake --graphviz=$GRAPH/$DOT $SRC
	RUN mv $GRAPH/$DOT $GRAPH/$DOT.ALL
}

# Convert graphs into .svg files
convert_to_svg()
{
	for F in $GRAPH/$DOT.*
	do
		O=${F/$DOT\./}
		RUN dot -Tsvg $F -o $O.svg
	done
	rm -f $GRAPH/$DOT.*
}

# Also create links in all the svg files
make_links_clickable()
{
	PY=$DIR/../python/svg_create_links.py
	RUN $PY $GRAPH/*.svg &>/dev/null
}

# Call the main function
main "$@"
