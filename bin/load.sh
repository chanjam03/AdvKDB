#! /bin/bash

################################################################################
##
##  CSV file shell start process for python or java (q called with normal start 
##  script)
##
##  sh load.sh <LANGUAGE> <NAME_CSV> <NAME_TABLE>
##
##  i.e. sh load.sh PYTHON optTrades.csv optTrades
##
##  Parameters:
##      - [LANGUAGE]: script to call the csv load process
##      - [NAME_CSV]: filename of csv to load in and send to tickerplant (All 
##          files should be placed in files directory)
##      - [NAME_TABLE]: name of table to be updated on tickerplant (should be 
##          added to sym schema file)
##
##  Options:
##      - [LANGUAGE] -> "Q","PYTHON","JAVA"
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading and parsing parameters passed
LANGUAGE=$1
FILE_NAME=$2
TABLE=$3

# Adding file root to csv name
FILE="${DIR_FILES}/${FILE_NAME}"

# Creating command to run based on passed argument
case $LANGUAGE in
    Q) COMM="${QEXEC} ${PROC_Q_CSV} -p ${PORT_CSV} -tp ${PORT_TICK}  -libCommon ${LIB_COMMON} -file ${FILE} -table ${TABLE}";;
    PYTHON) COMM="${PYEXEC} ${PROC_PYTHON_CSV} -tp ${PORT_TICK} -file ${FILE} -table ${TABLE}";;
    JAVA) COMM="${JVEXEC} ${PROC_JAVA_CSV} ${PORT_TICK} ${FILE} ${NAME_TABLE}"
esac

$COMM
