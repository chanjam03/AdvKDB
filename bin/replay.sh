#! /bin/bash

################################################################################
##
##  Start replay script to parse replay files
##
##  sh bin/reload.sh TABLE SYM (DATE)
##
##	i.e. sh bin/replay.sh trade ibm.n
##
################################################################################

# Sourcing config profile
source ./config/config.profile

# Reading in table and sym
TABLE=$1
SYM=$2
DATE=$3

# Defining start commands
COMM="${QEXEC} ${PROC_REPLAY} -p ${PORT_REPLAY} -libCommon ${LIB_COMMON} -dirReplay ${DIR_LOGS_REP} -table ${TABLE} -sym ${SYM} -date ${DATE}"

# Starting process
$COMM
