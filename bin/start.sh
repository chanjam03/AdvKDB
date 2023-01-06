#! /bin/bash

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Starting process
case $PROCESS in 
	TICK) COMM="${QEXEC} ${PROC_TICK} sym ${DIR_LOG} -p ${PORT_TICK} -dir ${DIR_HOME}";;
	RDB1) COMM="${QEXEC} ${PROC_RDB} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdb ${PORT_HDB} -sub trade quote";;
	RDB2) COMM="${QEXEC} ${PROC_RDB} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdb ${PORT_HDB} -sub OHLC";;
esac

$COMM