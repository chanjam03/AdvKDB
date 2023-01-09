#! /bin/bash

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Starting process
case $PROCESS in 
	TICK) COMM="${QEXEC} ${PROC_TICK} sym ${DIR_LOG} -p ${PORT_TICK} -dirHome ${DIR_HOME}";;
	RDB1) COMM="${QEXEC} ${PROC_RDB} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub trade quote";;
	RDB2) COMM="${QEXEC} ${PROC_RDB} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub OHLC";;
	FEED) COMM="${QEXEC} ${PROC_FEED} -p ${PORT_FEED} -tp ${PORT_TICK}";;
	RTE) COMM="${QEXEC} ${PROC_RTE} -p ${PORT_CPE} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHome ${DIR_HOME} -sub trade quote";;
esac

$COMM