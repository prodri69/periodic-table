#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [ -z "$1" ]; then
  echo "Please provide an element as an argument."
else
  SYMBOL="$1"
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]; then
    if [ ${#SYMBOL} -gt 2 ]; then
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$SYMBOL'");
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$SYMBOL'");
    EL_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$SYMBOL'");
    ELEMENT_SYMBOL=$(echo "$EL_SYMBOL" | sed 's/^[[:space:](]\+//;s/[[:space:])]$//');
    ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types JOIN properties ON types.type_id = properties.type_id JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$SYMBOL';")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$SYMBOL'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$SYMBOL'")
    BOILING_POINT=$($PSQL "SELECT properties.boiling_point_celsius FROM properties  JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$SYMBOL'")
    echo "The element with the atomic number"$ATOMIC_NUMBER" is "$ELEMENT_NAME" ($ELEMENT_SYMBOL). It's a"$ELEMENT_TYPE", with a mass of"$ELEMENT_MASS" amu. "$ELEMENT_NAME" has a melting point of"$MELTING_POINT" celsius and a boiling point of"$BOILING_POINT" celsius."
    else
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'");
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'");
    ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types JOIN properties ON types.type_id = properties.type_id JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$SYMBOL';")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$SYMBOL'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$SYMBOL'")
    BOILING_POINT=$($PSQL "SELECT properties.boiling_point_celsius FROM properties  JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$SYMBOL'")
    echo "The element with the atomic number"$ATOMIC_NUMBER" is "$ELEMENT_NAME" ($SYMBOL). It's a"$ELEMENT_TYPE", with a mass of"$ELEMENT_MASS" amu."$ELEMENT_NAME" has a melting point of"$MELTING_POINT" celsius and a boiling point of"$BOILING_POINT" celsius."
    fi
   else
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$SYMBOL'");
    ELEMENT_TYPE=$($PSQL "SELECT types.type FROM types JOIN properties ON types.type_id = properties.type_id JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = '$SYMBOL';")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number= '$SYMBOL'")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = '$SYMBOL'")
    BOILING_POINT=$($PSQL "SELECT properties.boiling_point_celsius FROM properties  JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = '$SYMBOL'")
    echo "The element with the atomic number "$SYMBOL" is "$ELEMENT_NAME" ($SYMBOL). It's a "$ELEMENT_TYPE", with a mass of "$ELEMENT_MASS" amu. "$ELEMENT_NAME" has a melting point of "$MELTING_POINT" celsius and a boiling point of"$BOILING_POINT" celsius."
  fi

fi
