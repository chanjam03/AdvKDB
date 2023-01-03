#! /bin/bash

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Starting process
case $PROCESS in 
	TICK) COMM="${QEXEC} ${PROC_TICK} sym ${DIR_LOG} -p ${PORT_TICK}";;
esac

$COMM