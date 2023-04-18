#! /bin/bash

################################################################################
##
##  Start process script for tickerplant and related processes
##
##  sh bin/test.sh <PROCESS>
##
##	i.e. sh bin/start.sh TICK
##
##  Parameters:
##      - [PROCESS]: Process to test
##
##  Options:
##      - [PROCESS] -> "TICK","RDB1","RDB2","FEED","RTE"
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Defining test commands
TEST_TICK=$(ps -ef | grep -v "grep" | grep $PROC_TICK| wc -l)
TEST_RDB1="${QEXEC} ${PROC_RDB} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub trade quote </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
TEST_RDB2="${QEXEC} ${PROC_RDB} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHDB ${DIR_HDB} -sub OHLC </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
TEST_FEED="${QEXEC} ${PROC_FEED} -p ${PORT_FEED} -tp ${PORT_TICK} </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"
TEST_RTE="${QEXEC} ${PROC_RTE} -p ${PORT_RTE} -tp ${PORT_TICK} -hdb ${PORT_HDB} -dirHome ${DIR_HOME} -dirHome ${DIR_HOME} -sub trade quote </dev/null >> ${DIR_LOG}/tick.log 2>&1 &"

# Testing passed process
echo ""
case $PROCESS in
	TICK)
        if [ $TEST_TICK -eq 1 ]; then
            echo "Tickerplant is - UP"
        else
            echo "Tickerplant is - DOWN"
        fi;;
	RDB1)
        if [ $TEST_RDB1 -eq 1 ]; then
            echo "Realtime Database 1 is - UP"
        else
            echo "Realtime Database 1 is - DOWN"
        fi;;
	RDB2)
        if [ $TEST_RDB2 -eq 1 ]; then
            echo "Realtime Database 2 is - UP"
        else
            echo "Realtime Database 2 is - DOWN"
        fi;;
	FEED)
        if [ $TEST_FEED -eq 1 ]; then
            echo "Feedhandler is - UP"
        else
            echo "Feedhandler is - DOWN"
        fi;;
	RTE)
        if [ $TEST_RTE -eq 1 ]; then
            echo "Realtime engine is - UP"
        else
            echo "Realtime engine is - DOWN"
        fi
esac
echo ""
