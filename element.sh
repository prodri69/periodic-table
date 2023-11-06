#1/bin/bash
#PSQLQUERY HERE

#If you run ./element.sh, it should output Please provide an element as an argument. and finish running.
echo -e"\nPlease provide an element as an argument."

#If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, it should output The element with atomic number 1 is Hydrogen (H).
#It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
read EL_ARG
EL_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$EL_ARG' OR atomic_number = '$EL_ARG' OR symbol = '$EL_ARG';")
EL_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$EL_NAME';");
EL_SYM=$($PSQL "SELECT symbol FROM elements WHERE name = '$EL_NAME';");
EL_TYPE=$($PSQL "SELECT type FROM types JOIN properties ON types.type_id = properties.type_id WHERE properties.atomic_number = $EL_NUM")
EL_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $EL_NUM")
EL_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $EL_NUM");
EL_BOIL=$($PSQL "SELECT boling_point_celsius FROM properties WHERE atomic_number = $EL_NUM");

