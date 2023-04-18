#! /bin/bash

################################################################################
##
##  Stop process script for tickerplant and related processes
##
##  sh bin/stop.sh <PROCESS>
##
##	i.e. sh bin/stop.sh ALL
##
##  Parameters:
##      - [PROCESS]: Process to stop, if "ALL" will start all process in the 
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

# Stopping process
echo ""
case $PROCESS in
    ALL)
        echo "Stopping tick process"
        lsof -i :${PORT_TICK} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping rdb1 process"
        lsof -i :${PORT_RDB1} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping rdb2 process"
        lsof -i :${PORT_RDB2} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping feed process"
        lsof -i :${PORT_FEED} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping realtime engine process"
        lsof -i :${PORT_RTE} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	TICK)
        echo "Stopping tick process"
        lsof -i :${PORT_TICK} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RDB1)
        echo "Stopping rdb1 process"
        lsof -i :${PORT_RDB1} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RDB2)
        echo "Stopping rdb2 process"
        lsof -i :${PORT_RDB2} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	FEED)
        echo "Stopping feed process"
        lsof -i :${PORT_FEED} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RTE)
        echo "Stopping realtime engine process"
        lsof -i :${PORT_RTE} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
esac
echo ""
