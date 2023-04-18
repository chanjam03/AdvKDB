#! /bin/bash

################################################################################
##
##  CSV file shell start process for python or java (q called with normal start 
##  script)
##
##  sh csv_load.sh <LANGUAGE> <PATH_CSV> <NAME_TABLE>
##
##  Parameters:
##      - [LANGUAGE]: script to call the csv load process (python or java)
##      - [NAME_CSV]: filename of csv to load in and send to tickerplant (All 
##          files should be placed in files directory)
##      - [NAME_TABLE]: name of table to be updated on tickerplant (should be 
##          added to sym schema file)
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading and parsing parameters passed
LANGUAGE=$1
NAME_CSV=$2
NAME_TABLE=$3

# Adding file root to csv name
FILE="${DIR_FILES}/${NAME_CSV}"

# Creating command to run based on passed argument
case $LANGUAGE in
    PYTHON) COMM="${PYEXEC} ${DIR_SCRIPTS}/csv_load.py --file ${FILE} --table ${NAME_TABLE}";;
    JAVA) COMM="${JVEXEC} ${DIR_SCRIPTS}/csv_load.py --file ${FILE} --table ${NAME_TABLE}"
esac

$COMM
