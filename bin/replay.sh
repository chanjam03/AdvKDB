#! /bin/bash

################################################################################
##
##  Start replay script to parse replay files
##
##  sh bin/reload.sh TABLE SYM DATE
##
##	i.e. sh bin/replay.sh trade ENB 2023.04.21
##
##  Parameters:
##      - [TABLE]: table on which to filter log file 
##      - [SYM]: symbol to filter on
##      - [DATE]: date to filter on
##
################################################################################

# Sourcing config profile
source ./config/config.profile

# Reading in table and sym
TABLE=$1
SYM=$2
DATE=$3

# Defining start commands
COMM="${QEXEC} ${PROC_REPLAY} -p ${PORT_REPLAY} -libCommon ${LIB_COMMON} -dirReplay ${DIR_LOGS_REP} -dirTick ${DIR_TICK} -table ${TABLE} -sym ${SYM} -date ${DATE} </dev/null >> ${DIR_LOGS_PROC}/tick.log 2>&1 &"

# Starting process
echo ""
echo "Filtering log file: sym${DATE} for table: ${TABLE} and sym: ${SYM}"
eval $COMM
echo "Filtering log file process - DONE"
echo ""
