#! /bin/bash

################################################################################
##
##  Start replay script to parse replay files
##
##  sh bin/reload.sh 
##
##	i.e. sh bin/start.sh ALL (-i for interactive/debug mode, must be
##                                individual process and not "ALL")
##
################################################################################

# Sourcing config profile
source ./config/config.profile

# Defining start commands
COMM="${QEXEC} ${PROC_REPLAY} -p ${PORT_REPLAY} -libCommon ${LIB_COMMON} -dirReplay ${DIR_LOGS_REP}"

# Starting process
$COMM
