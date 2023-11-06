#1/bin/bash
#PSQLQUERY HERE

#If you run ./element.sh, it should output Please provide an element as an argument. and finish running.
echo -e"\nPlease provide an element as an argument."
read EL_ARG
ELEMENT=$($PSQL "
