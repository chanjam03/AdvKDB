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
##      - [PROCESS] -> "TICK","RDB1","RDB2","FEED","CEP"
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Defining test commands
TEST_TICK=$(ps -ef | grep -v "grep" | grep "${PROC_TICK}"| wc -l)
TEST_HDB=$(ps -ef | grep -v "grep" | grep "${PROC_TICK}"| wc -l)
TEST_RDB1=$(ps -ef | grep -v "grep" | grep "${PROC_RDB1}"| wc -l)
TEST_RDB2=$(ps -ef | grep -v "grep" | grep "${PROC_RDB2}"| wc -l)
TEST_RDB_CSV=$(ps -ef | grep -v "grep" | grep "${PROC_RDB_CSV}"| wc -l)
TEST_FEED=$(ps -ef | grep -v "grep" | grep "${PROC_FEED}"| wc -l)
TEST_CEP=$(ps -ef | grep -v "grep" | grep "${PROC_CEP}"| wc -l)

# Testing passed process
echo ""
case $PROCESS in
    ALL)
        if [ $TEST_TICK -eq 1 ]; then
            echo "Tickerplant is - UP"
        else
            echo "Tickerplant is - DOWN"
        fi
        if [ $TEST_HDB -eq 1 ]; then
            echo "Historical Database is - UP"
        else
            echo "Historical Database is - DOWN"
        fi
        if [ $TEST_RDB1 -eq 1 ]; then
            echo "Realtime Database 1 is - UP"
        else
            echo "Realtime Database 1 is - DOWN"
        fi
        if [ $TEST_RDB2 -eq 1 ]; then
            echo "Realtime Database 2 is - UP"
        else
            echo "Realtime Database 2 is - DOWN"
        fi
        if [ $TEST_RDB_CSV -eq 1 ]; then
            echo "Realtime Database csv is - UP"
        else
            echo "Realtime Database csv is - DOWN"
        fi
        if [ $TEST_FEED -eq 1 ]; then
            echo "Feedhandler is - UP"
        else
            echo "Feedhandler is - DOWN"
        fi
        if [ $TEST_CEP -eq 1 ]; then
            echo "Realtime engine is - UP"
        else
            echo "Realtime engine is - DOWN"
        fi;;
	TICK)
        if [ $TEST_TICK -eq 1 ]; then
            echo "Tickerplant is - UP"
        else
            echo "Tickerplant is - DOWN"
        fi;;
    HDB)
        if [ $TEST_HDB -eq 1 ]; then
            echo "Historical Database is - UP"
        else
            echo "Historical Database is - DOWN"
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
	RDB_CSV)
        if [ $TEST_RDB_CSV -eq 1 ]; then
            echo "Realtime Database csv is - UP"
        else
            echo "Realtime Database csv is - DOWN"
        fi;;
	FEED)
        if [ $TEST_FEED -eq 1 ]; then
            echo "Feedhandler is - UP"
        else
            echo "Feedhandler is - DOWN"
        fi;;
	CEP)
        if [ $TEST_CEP -eq 1 ]; then
            echo "Realtime engine is - UP"
        else
            echo "Realtime engine is - DOWN"
        fi
esac
echo ""
