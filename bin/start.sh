#! /bin/bash

################################################################################
##
##  Start process script for tickerplant and related processes
##
##  sh bin/start.sh <PROCESS>
##
##	i.e. sh bin/start.sh ALL
##
##  Parameters:
##      - [PROCESS]: Process to start, if "ALL" will start all process in the 
##      	in the proper order
##
##  Options:
##      - [PROCESS] -> "ALL","TICK","RDB1","RDB2","FEED","RTE"
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Defining start commands
START_TICK="${QEXEC} ${PROC_TICK} sym ${DIR_LOG} -p ${PORT_TICK} -dirHome ${DIR_HOME} </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
START_RDB1="${QEXEC} ${PROC_RDB} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub trade quote </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
START_RDB2="${QEXEC} ${PROC_RDB} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub OHLC </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
START_FEED="${QEXEC} ${PROC_FEED} -p ${PORT_FEED} -tp ${PORT_TICK} </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
START_RTE="${QEXEC} ${PROC_RTE} -p ${PORT_RTE} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHome ${DIR_HOME} -sub trade quote </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"

# Starting process
echo ""
case $PROCESS in
	ALL)
        echo "Starting tick process"
        eval $START_TICK
        echo "Starting rdb1 process"
        eval $START_RDB1
        echo "Starting rdb2 process"
        eval $START_RDB2
        echo "Starting feed process"
        eval $START_FEED
        echo "Starting realtime engine process"
        eval $START_RTE;;
	TICK)
        echo "Starting tick process"
        eval $START_TICK;;
	RDB1)
        echo "Starting rdb1 process"
        eval $START_RDB1;;
	RDB2)
        echo "Starting rdb2 process"
        eval $START_RDB2;;
	FEED)
        echo "Starting feed process"
        eval $START_FEED;;
	RTE)
        echo "Starting realtime engine process"
        eval $START_RTE
esac
echo ""
